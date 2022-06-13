require 'csv'  
require 'yaml'

csvm = CSVmanubula.new 
varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))
nomeArquivoBillFeed = csvm.encontraNomeArquivoFat("DailyConsolidatedFeed")
nomeArquivoFat55 = csvm.encontraNomeArquivoFat("FAT55")

Dado('que recebo o arquivo TXT FAT55') do

    # Coloca uma cor na automação. Caso falhe printa algo em vermelho, caso passe, printa algo em verde
    class String
        def red; "\e[31m#{self}\e[0m" end
        def green; "\e[32m#{self}\e[0m" end
        def bg_green;       "\e[42m#{self}\e[0m" end
    end
    # Abre o arquivo TXT e converte em CSV com as colunas exatas do arquivo TXT.
    csvm.converteTXTParaCSVFat(nomeArquivoFat55)
  end
  
  Quando('converte-lo para CSV') do
    # Inicia a verificação do novo arquivo CSV, pois, fica mais fácil fazer a manipulação com CSV.  
    @tbl = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv", col_sep: ";" ) # Abre o arquivo CSV gerado anteriormente e o separa por virgulas 
    nomeArquivo = @tbl[0] # Extrai a primeira linha do arquivo CSV.
    puts "Nome do arquivo :#{nomeArquivo.first}".bg_green # Extrai a primeira posição do array criado acima.
  end
  
  Então('posso realizar a validação do arquivo') do
    # Validação da estrutura do arquivo TXT convertido Fat55
    puts "Numero de colunas no arquivo: #{@tbl[2].length}"
    numCol = @tbl[2].length # Pega a primeira linha do arquivo saltando direto para a 3 linha do CSV, pois as duas primeiras linhas são lixo.
    if numCol == 10
        puts "Estrutura do arquivo com numero de colunas validado".green
        puts "Valor de colunas OK".green
    else
        puts "Estrutura arquivo diferente, verificar presença de bug".red
    end
  end
  
  Então('das colunas') do
    # Valida numero de linhas na primeira coluna do arquivo  TXT convertido FAT55
    @stringInit = 'D1'
    # Loop para retirar os primeiros e ultimos elementos
    @tbl.each_with_index do |item, index|
        if index == 2 # Pega a terceira linha da planilha
            @primeiro = item[0][0..-11].gsub("#{@stringInit}", "").to_i #Remove os ultimos 11 caracteres e remove os primeiros caracteres que começa com D1 e converte para inteiro
        elsif index == @tbl.size - 2 # Pega a penultima linha da planilha
            @ultimo = item[0][0..-12].gsub("#{@stringInit}", "").to_i
        elsif index == @tbl.size - 1 # Pega a utima linha da planilha
            @ultimoPlanilha = item[0].gsub("FF", "").to_i
        end
    end

    #Valida os dias da primeira coluna com o numero de linhas
    if @tbl.length-3 == @ultimo && @ultimo == @ultimoPlanilha
        puts "Valor linhas e dias na coluna OK".green
    else
        puts "Planilha com BUG verificar numero de linhas e dias".red
    end 
  end
  
  Então('dos valores da soma total') do
    # Validação do total da fatura da coluna do arquivo TXT convertido Fat55 e a automação tambem realiza a soma da coluna e valida com o valor que vem do TXT Fat.
    i = 2
    @totalPlanilha = 0
    while i < @tbl.length do
        @colValidacao = @tbl[i][2].to_s.gsub(/\,/,".") # Tratamento para tirar virgula e colocar ponto
        @totalPlanilha = @totalPlanilha + @colValidacao.to_f # Itera sobre o falor total, acumulando o valor da compra em cada iteração
        i+=1
    end
    @totalPlanilha = @totalPlanilha.round(2) # Formata o valor do total da planilha para 2 pontos flutuantes
    puts "Total Planilha convertida TXT: #{@totalPlanilha}" 
    utimaLinha = @tbl.last # Pega o ultimo valor do arquivo CSV que é o total
    utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2) # transforma em string, retira o ";" e coloca "." transforma em ponto-flutuente em 2 casas decimais, com o intuito de fazer a comparação dos valores
    # Valida os valores da planilha CSV/TXT com os valores calculados pela automação
    if utimaLinha.to_s == @totalPlanilha.to_s  
        puts "Valor arquivo TXT Fat55 ultima linha #{utimaLinha} igual ao valor calculado da automação #{@totalPlanilha}"
        puts "Valor OK".green
    else
        puts"Valor arquivo TXT Fat55 ultima linha #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilha}".red
        puts"Possui BUG".red
    end
  end

  # Validação FAT55 TXT convertido para CSV, junto com arquivo do BillFeed CSV
  Então('validar com o Billfeed') do
   @tblBillFeed = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoBillFeed}", col_sep: "," )
  
   #DADOS DO BILLFEED
   #Função que valida a soma do valor da coluna (Grand Total: Retail Price) da planilha de BillFeed para cada estado
   def calculaRetailPriceEstado(estado)
        i = 1
        @totalGranTotalRetailPrice = 0
        while i < @tblBillFeed.length do
            storeAcronymCol = @tblBillFeed[i][141]
            activityType = @tblBillFeed[i][8]
            serviceTypeCol = @tblBillFeed[i][9]
            paymentMethodCol = @tblBillFeed[i][87]
            billingStateProvince = @tblBillFeed[i][33]
            # Condição que filtra as colunas da planilha do BillFeed para a loja TELERESE E PRODUTOS SAAS e IAAS
            #BOLETO SAAS
            if storeAcronymCol == "telerese"  && serviceTypeCol == "SAAS"  && paymentMethodCol == "Boleto" && billingStateProvince == "#{estado}"
             granTotalRetailPrice = @tblBillFeed[i][63]
             @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
            end
            #CARTÃO DE CRETIDO   SAAS
            if storeAcronymCol == "telerese"  && serviceTypeCol == "SAAS"  && paymentMethodCol == "Cartão de Crédito" && billingStateProvince == "#{estado}"
                granTotalRetailPrice = @tblBillFeed[i][63]
                @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
            end  
            #CARTÃO DE CRETIDO   IAAS
            if storeAcronymCol == "telerese"  && serviceTypeCol == "IAAS"  && paymentMethodCol == "Cartão de Crédito" && billingStateProvince == "#{estado}"
                granTotalRetailPrice = @tblBillFeed[i][63]
                @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
            end  
            #BOLETO IAAS   
            if storeAcronymCol == "telerese"  && serviceTypeCol == "IAAS"  && paymentMethodCol == "Boleto" && billingStateProvince == "#{estado}"
                granTotalRetailPrice = @tblBillFeed[i][63]
                @totalGranTotalRetailPrice = granTotalRetailPrice.to_f + @totalGranTotalRetailPrice.to_f
            end  
            
        i+=1
        end
        return @totalGranTotalRetailPrice

    end
    #DADOS DO BILLFEED
    estadoCompleto = ["Acre","Alagoas","Amapá","Amazonas","Bahia","Ceará","Espírito Santo","Goiás","Maranhão","Mato Grosso","Mato Grosso do Sul","Minas Gerais","Pará","Paraíba","Paraná","Pernambuco","Piauí","Rio de Janeiro","Rio Grande do Norte","Rio Grande do Sul","Rondônia","Roraima","Santa Catarina","São Paulo","Sergipe","Tocantins", "Federal District"]
    estadoCalculadoBillFeed = [] # Cria um novo array com os dados de fatura de cada estado já calculados
    
    # LOOP PARA CALCULAR POR ESTADO ENVIA por parâmetro os estados para realizar o calculo da fatura por estado
    k = 0
    while k < estadoCompleto.length do
        estado = calculaRetailPriceEstado("#{estadoCompleto[k]}")
        #puts "#{k}, #{estadoCompleto[k]}, #{estado}"
        k+=1
        estadoCalculadoBillFeed.append("#{estado}") # Cria um novo array com os dados de fatura de cada estado calculados
    end
    #puts "BillFeed #{estadoCalculadoBillFeed}" # Variável com os valores de BILLFEED calculados por estado

    #DADOS FAT55 TXT
    # Validação dos valores de BILLFEED junto com o arquivo FAT55 ja tratato e transformado em CSV.
    def calculaValorEstadoFat55(estado)
        i = 1
        @valorTotalEstadoFat55 = 0
        while i < @tbl.length do
            valoresCol = @tbl[i][2].to_s.gsub(/\,/,".")
            tipoFaturaCol = @tbl[i][5].to_s.slice(4,25)
            estadoCol = @tbl[i][9]
            #Boleto
            if tipoFaturaCol == "Boleto" && estadoCol == "#{estado}"
                valorescol = valoresCol.to_f.round(2) # converte para float e aredonda em 2 casas decimais
                @valorTotalEstadoFat55 = valoresCol.to_f + @valorTotalEstadoFat55.to_f     # faz a soma do valor da coluna com a variável "valorTotalEstadoFat55"
            end
            #Cartão de Credito
            if tipoFaturaCol == "Cartao de Credito" && estadoCol == "#{estado}"
                valorescol = valoresCol.to_f.round(2)
                @valorTotalEstadoFat55 = valoresCol.to_f + @valorTotalEstadoFat55.to_f     
            end
        i+=1
        end
    return (@valorTotalEstadoFat55/2).to_f
    end
    #DADOS DO FAT55 TXT CONVERTIDO
    estadosAbrev = ["AC","AL","AP","AM","BA","CE","ES","GO","MA","MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO","DF"]
    estadosCalculadoFat55 = []
    j = 0
    while j < estadosAbrev.length do
        estado = calculaValorEstadoFat55("#{estadosAbrev[j]}")
        #puts "#{j}, #{estadosAbrev[j]}, #{estado}"
        estadosCalculadoFat55.append("#{estado}")
        j+=1
    end
    #puts "fat55#{estadosCalculadoFat55}" # Variável com os valores de BILLFEED calculados por estado

    # Faz um Arquivo com o valor total calculado dos estados de Fat55.TXT e do valor total Billfeed.CSV
    CSV.open("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv", "w") do |csv|
        csv << ["AC","AL","AP","AM","BA","CE","ES","GO","MA","MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN","RS","RO","RR","SC","SP","SE","TO","DF"]
        csv << estadosCalculadoFat55
        csv << estadoCalculadoBillFeed
    end

    @tbl2 = CSV.read('./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv', col_sep: "," )

    i=0
    while i < @tbl2[1].length do
            if @tbl2[1][i].to_i == @tbl2[2][i].to_i
                puts "#{@tbl2[0][i]} - Estado OK BillFeed #{@tbl2[2][i]} Valor Fat55 #{@tbl2[1][i]}".green
                open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> #{@tbl2[0][i]} - Estado OK BillFeed #{@tbl2[2][i]} Valor Fat55 #{@tbl2[1][i]} </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
            else
                puts "#{@tbl2[0][i]} - Estado com conta diferente Valor: BillFeed #{@tbl2[2][i]} Valor Fat55 #{@tbl2[1][i]}".red
                open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> #{@tbl2[0][i]} - Estado com conta diferente Valor: BillFeed #{@tbl2[2][i]} Valor Fat55 #{@tbl2[1][i]} </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
            end
        i+=1
    end
    
    # Deleta o arquivo CSV criado a partir do TXT de FAT55, ele é criado na linha 18, pois a manipulação dos dados e mais fácil no arquivo CSV. Comente a linha abaixo para ver o arquivo.
    File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv")
    File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/arquivoCalculado.csv")

    visit("file:///#{varGlobal['diretorioAutomacao']}screenshot.html") # Abre o arquivo html criado na linha 180 para tirar a foto final para o relatorio
    File.delete("./screenshot.html") # deleta o arquivo HTML criado

    # origem = "./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}"
    # destino = "./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/Processados"
    # FileUtils.mv(origem, destino)
    
  end