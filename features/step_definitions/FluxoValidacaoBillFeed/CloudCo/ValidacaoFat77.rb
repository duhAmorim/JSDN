require 'csv'
require 'yaml'

varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))
csvm = CSVmanubula.new 
nomeArquivoBillFeed = csvm.encontraNomeArquivoFat("DailyConsolidatedFeed")
nomeArquivoFat77 = csvm.encontraNomeArquivoFat("FAT77")


Dado('que recebo o arquivo TXT FAT77') do

    csvm.converteTXTParaCSVFat(nomeArquivoFat77)

  end
  
  Quando('converte-lo o arquivo Fat77 para CSV') do
      @tbl = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv", col_sep: ";" ) 
      nomeArquivo = @tbl[0] 
      puts "Nome do arquivo :#{nomeArquivo.first}"
  end
  
  Então('posso realizar a validação do arquivo Fat77 convertido') do
        puts "Numero de colunas no arquivo: #{@tbl[2].length}"
        numCol = @tbl[2].length
        if numCol == 10
            puts "Valor de colunas OK"
            open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> VALOR COLUNAS OK </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
        else
            puts "Estrutura arquivo diferente, verificar presença de bug"
        end
  end
  
  Então('das colunas Fat77') do
     @stringInit = 'D1'
     @tbl.each_with_index do |item, index|
         if index == 2 
             @primeiro = item[0][0..-11].gsub("#{@stringInit}", "").to_i
         elsif index == @tbl.size - 2
             @ultimo = item[0][0..-12].gsub("#{@stringInit}", "").to_i
         elsif index == @tbl.size - 1
             @ultimoPlanilha = item[0].gsub("FF", "").to_i
         end
     end
     if @tbl.length-3 == @ultimo && @ultimo == @ultimoPlanilha
         puts "Valor linhas e dias na coluna OK"
     else
         puts "Planilha com BUG verificar numero de linhas e dias"
     end 
  end
  
  Então('dos valores da soma total Fat77') do
     i = 2
     @totalPlanilha = 0
     while i < @tbl.length do
         @colValidacao = @tbl[i][2].to_s.gsub(/\,/,".")
         @totalPlanilha = @totalPlanilha + @colValidacao.to_f
         i+=1
     end
     @totalPlanilha = @totalPlanilha.round(2)
     puts "Total Planilha transformada: #{@totalPlanilha}" 
     utimaLinha = @tbl.last
     utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2)
     if utimaLinha.to_s == @totalPlanilha.to_s  
         puts "Valor planilha TXT #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilha}"
         puts "Valor OK"
         open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> VALOR ok </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
     else
         puts"Valor planilha TXT #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilha}"
         puts"Possui BUG"
     end
  end
  
  Então('validar o Fat77 com o BillFeed') do
   @tblBillFeed = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoBillFeed}", col_sep: "," )
   #DADOS DO BILLFEED
   def calculaRetailPriceEstado(estado)
        i = 1
        @totalGranTotalRetailPrice = 0
        while i < @tblBillFeed.length do
            storeAcronymCol = @tblBillFeed[i][141]
            activityType = @tblBillFeed[i][8]
            serviceTypeCol = @tblBillFeed[i][9]
            paymentMethodCol = @tblBillFeed[i][87]
            billingStateProvince = @tblBillFeed[i][33]
            # Condição que filtra as colunas da planilha do BillFeed
            #BOLETO
            if storeAcronymCol == "cloudco"  && serviceTypeCol == "SAAS"  && paymentMethodCol == "Boleto" && billingStateProvince == "#{estado}"
             granTotalRetailPrice = @tblBillFeed[i][63]
             @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
            end   
            #CARTÃO DE CRETIDO
            if storeAcronymCol == "cloudco"  && serviceTypeCol == "SAAS"  && paymentMethodCol == "Cartão de Crédito" && billingStateProvince == "#{estado}"
              granTotalRetailPrice = @tblBillFeed[i][63]
              @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
            end   
            if storeAcronymCol == "cloudco"  && serviceTypeCol == "IAAS"  && paymentMethodCol == "Cartão de Crédito" && billingStateProvince == "#{estado}"
                granTotalRetailPrice = @tblBillFeed[i][63]
                @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
              end  
            if storeAcronymCol == "cloudco"  && serviceTypeCol == "IAAS"  && paymentMethodCol == "Boleto" && billingStateProvince == "#{estado}"
                granTotalRetailPrice = @tblBillFeed[i][63]
                @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
            end  
        i+=1
        end
        return @totalGranTotalRetailPrice
    end
    #DADOS DO BILLFEED
    estadoCompleto = ["Acre","Alagoas","Amapá","Amazonas","Bahia","Ceará","Espírito Santo","Goiás","Maranhão","Mato Grosso","Mato Grosso do Sul","Minas Gerais","Pará","Paraíba","Paraná","Pernambuco","Piauí","Rio de Janeiro","Rio Grande do Norte","Rio Grande do Sul","Rondônia","Roraima","Santa Catarina","São Paulo","Sergipe","Tocantins", "Federal District"]
    estadoCalculadoBillFeed = [] 
    k = 0
    while k < estadoCompleto.length do
        estado = calculaRetailPriceEstado("#{estadoCompleto[k]}")
        k+=1
        estadoCalculadoBillFeed.append("#{estado}")
    end

    #DADOS FAT77
    def calculaValorEstadoFat77(estado)
        i = 1
        @valorTotalEstadoFat77 = 0
        while i < @tbl.length do
            valoresCol = @tbl[i][2].to_s.gsub(/\,/,".")
            tipoFaturaCol = @tbl[i][5].to_s.slice(4,25)
            estadoCol = @tbl[i][9]
            #BOLETO
            if tipoFaturaCol == "Boleto" && estadoCol == "#{estado}"
                valorescol = valoresCol.to_f.round(2)
                @valorTotalEstadoFat77 = valoresCol.to_f + @valorTotalEstadoFat77.to_f     
            end
            #CARTÃO DE CREDITO
            if tipoFaturaCol == "Cartao de Credito" && estadoCol == "#{estado}"
              valorescol = valoresCol.to_f.round(2)
              @valorTotalEstadoFat77 = valoresCol.to_f + @valorTotalEstadoFat77.to_f     
            end
        i+=1
        end
    return (@valorTotalEstadoFat77/2).to_f
    end
    #DADOS DO FAT77
    estadosAbrev = ["AC","AL","AP","AM","BA","CE","ES","GO","MA","MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO","DF"]
    estadosCalculadoFat77 = []
    j = 0
    while j < estadosAbrev.length do
        estado = calculaValorEstadoFat77("#{estadosAbrev[j]}")
        estadosCalculadoFat77.append("#{estado}")
        j+=1
    end
    CSV.open("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv", "w") do |csv|
        csv << ["AC","AL","AP","AM","BA","CE","ES","GO","MA","MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO","DF"]
        csv << estadosCalculadoFat77
        csv << estadoCalculadoBillFeed
    end
    @tbl2 = CSV.read('./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv', col_sep: "," )
    i=0
    while i < @tbl2[1].length do
            if @tbl2[1][i].to_i == @tbl2[2][i].to_i
                puts "#{@tbl2[0][i]} - Estado OK - BillFeed #{@tbl2[2][i]} Valor Fat77 #{@tbl2[1][i]}"
                open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> #{@tbl2[0][i]} - Estado OK - BillFeed #{@tbl2[2][i]} Valor Fat77 #{@tbl2[1][i]} </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
            else
                puts "#{@tbl2[0][i]} - Estado com conta diferente Valor: BillFeed #{@tbl2[2][i]} Valor Fat77 #{@tbl2[1][i]}"
            end
        i+=1
    end
    File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv")
    File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv")

    visit("file:///#{varGlobal['diretorioAutomacao']}screenshot.html") # Abre o arquivo html criado na linha 180 para tirar a foto final para o relatorio
    File.delete("./screenshot.html") # deleta o arquivo HTML criado

  end