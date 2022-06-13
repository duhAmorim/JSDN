require 'csv'
require 'yaml'

varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))
csvm = CSVmanubula.new 
nomeArquivoFat77 = csvm.encontraNomeArquivoFat("FAT77")
nomeArquivoFat78 = csvm.encontraNomeArquivoFat("FAT78")

Dado('que recebo o arquivo TXT FAT78') do
    csvm.converteTXTParaCSVFat(nomeArquivoFat77)

  end
  
  Quando('converte-lo o arquivo Fat78 para CSV') do
        csvm.converteTXTParaCSVFat(nomeArquivoFat78)

        @tblFat78 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat78}_Alterado.csv", col_sep: ";" )
        nomeArquivo = @tblFat78[0]
        puts "Nome do arquivo :#{nomeArquivo.first}"
        @tblFat77 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv", col_sep: ";" )
  end
  
  Então('posso realizar a validação do arquivo Fat78 convertido') do
       puts "Numero de colunas no arquivo: #{@tblFat78[2].length}"
       numCol = @tblFat78[2].length 
       if numCol == 10
           puts "Estrutura do arquivo com numero de colunas validado"
           puts "Valor de colunas OK"
           open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> VALOR COLUNAS OK </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
       else
           puts "Estrutura arquivo diferente, verificar presença de bug"
       end
  end
  
  Então('das colunas Fat78') do 
    @stringInit = 'D1'
    @tblFat78.each_with_index do |item, index|
        if index == 2 
            @primeiro = item[0][0..-11].gsub("#{@stringInit}", "").to_i
        elsif index == @tblFat78.size - 2 
            @ultimo = item[0][0..-12].gsub("#{@stringInit}", "").to_i
        elsif index == @tblFat78.size - 1 
            @ultimoPlanilha = item[0].gsub("FF", "").to_i
        end
    end
    #Valida os dias da primeira coluna com o numero de linhas
    if @tblFat78.length-3 == @ultimo && @ultimo == @ultimoPlanilha
        puts "Valor linhas e dias na coluna OK"
    else
        puts "Planilha com BUG verificar numero de linhas e dias"
    end 
  end
  
  Então('dos valores da soma total Fat78') do
    i = 2
    @totalPlanilhaFat78 = 0
    while i < @tblFat78.length do
        @colValidacao = @tblFat78[i][2].to_s.gsub(/\,/,".")
        @totalPlanilhaFat78 = @totalPlanilhaFat78 + @colValidacao.to_f
        i+=1
    end
    @totalPlanilhaFat78 = @totalPlanilhaFat78.round(2) 
    puts "Total Planilha FAT78 transformada: #{@totalPlanilhaFat78}" 
    utimaLinha = @tblFat78.last 
    utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2) 
    if utimaLinha.to_s == @totalPlanilhaFat78.to_s  
        puts "Valor planilha TXT FAT78 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat78}"
        puts "Valor OK"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> VALOR ok </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    else
        puts"Valor planilha TXT FAT78 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat78}"
        puts"Possui BUG"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> POSSUI BUG </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    end
  end
  
  Então('validar o Fat78 com o Fat77') do
     # Validação do total da fatura da coluna
     i = 2
     @totalPlanilhaFat77 = 0
     while i < @tblFat77.length do
         @colValidacao = @tblFat77[i][2].to_s.gsub(/\,/,".") 
         @totalPlanilhaFat77 = @totalPlanilhaFat77 + @colValidacao.to_f 
         i+=1
     end
     @totalPlanilhaFat77 = @totalPlanilhaFat77.round(2) 
     puts "Total Planilha FAT77 transformada: #{@totalPlanilhaFat77}" 
     utimaLinha = @tblFat77.last 
     utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2) 
     # Valida os valores da planilha CSV/TXT com os valores calculados pela automação
     if utimaLinha.to_s == @totalPlanilhaFat77.to_s  
         puts "Valor planilha TXT FAT77 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat77}"
         puts "Valor OK"
     else
         puts"Valor planilha TXT FAT77 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat77}"
         puts"Possui BUG"
     end
     @totalPlanilhaFat77Trat = (@totalPlanilhaFat77/30*4).to_f.round(2) # Abrir FAT77, pegar o valor, dividir SEMPRE por 30 e multiplicar por 4
     puts "Tratamento para validar FAT78 #{@totalPlanilhaFat77Trat}"
     
     if @totalPlanilhaFat77Trat.to_i == @totalPlanilhaFat78.to_i
         puts "Validação FAT77 #{@totalPlanilhaFat77Trat} e FAT78 #{@totalPlanilhaFat78} OK"
     else
         puts "Verificar valor do total do FAT77 com valor total do FAT78"
     end

     File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv")
     File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat78}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat78}_Alterado.csv")

     visit("file:///#{varGlobal['diretorioAutomacao']}screenshot.html") # Abre o arquivo html criado na linha 180 para tirar a foto final para o relatorio
     File.delete("./screenshot.html") # deleta o arquivo HTML criado
  end