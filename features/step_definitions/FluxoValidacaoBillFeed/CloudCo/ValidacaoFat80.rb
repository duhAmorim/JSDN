require 'csv'  
require 'yaml'

varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))
csvm = CSVmanubula.new 
nomeArquivoFat77 = csvm.encontraNomeArquivoFat("FAT77")
nomeArquivoFat80 = csvm.encontraNomeArquivoFat("FAT80")

Dado('que recebo o arquivo TXT FAT80') do
    csvm.converteTXTParaCSVFat(nomeArquivoFat77)
  end
  
  Quando('converte-lo o arquivo Fat80 para CSV') do
        csvm.converteTXTParaCSVFat(nomeArquivoFat80)

        @tblFat80 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat80}_Alterado.csv", col_sep: ";" )
        nomeArquivo = @tblFat80[0] 
        puts "Nome do arquivo :#{nomeArquivo.first}" 
        @tblFat77 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv", col_sep: ";" )
  end
  
  Então('posso realizar a validação do arquivo Fat80 convertido') do
        puts "Numero de colunas no arquivo: #{@tblFat80[2].length}"
        numCol = @tblFat80[2].length 
        if numCol == 10
            puts "Estrutura do arquivo com numero de colunas validado"
            puts "Valor de colunas OK"
            
        else
            puts "Estrutura arquivo diferente, verificar presença de bug"
        end
  end
  
  Então('das colunas Fat80') do
    @stringInit = 'D1'
    @tblFat80.each_with_index do |item, index|
        if index == 2
            @primeiro = item[0][0..-11].gsub("#{@stringInit}", "").to_i
        elsif index == @tblFat80.size - 2 
            @ultimo = item[0][0..-12].gsub("#{@stringInit}", "").to_i
        elsif index == @tblFat80.size - 1 
            @ultimoPlanilha = item[0].gsub("FF", "").to_i
        end
    end
    if @tblFat80.length-3 == @ultimo && @ultimo == @ultimoPlanilha
        puts "Valor linhas e dias na coluna OK"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> Valor linhas e dias na coluna OK </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    else
        puts "Planilha com BUG verificar numero de linhas e dias"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> POSSUI BUG </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    end 
  end
  
  Então('dos valores da soma total Fat80') do
     i = 2
     @totalPlanilhaFat80 = 0
     while i < @tblFat80.length do
         @colValidacao = @tblFat80[i][2].to_s.gsub(/\,/,".") 
         @totalPlanilhaFat80 = @totalPlanilhaFat80 + @colValidacao.to_f 
         i+=1
     end
     @totalPlanilhaFat80 = @totalPlanilhaFat80.round(2)
     puts "Total Planilha FAT80 transformada: #{@totalPlanilhaFat80}" 
     utimaLinha = @tblFat80.last 
     utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2) 
     if utimaLinha.to_s == @totalPlanilhaFat80.to_s  
         puts "Valor planilha TXT FAT80 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat80}"
         puts "Valor OK"
         open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> VALOR ok </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
     else
         puts"Valor planilha TXT FAT80 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat80}"
         puts"Possui BUG"
         open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> POSSUI BUG </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
     end
  end
  
  Então('validar o Fat80 com o Fat77') do
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
    if utimaLinha.to_s == @totalPlanilhaFat77.to_s  
        puts "Valor planilha TXT FAT77 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat77} Valor OK"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> 'Valor planilha TXT FAT77 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat77} Valor OK' </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    else
        puts"Valor planilha TXT FAT77 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat77}"
        puts"Possui BUG"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV><b> POSSUI BUG </b></DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    end
    @totalPlanilhaFat77Trat = (@totalPlanilhaFat77).to_f.round(2) 
    if @totalPlanilhaFat77Trat.to_i == @totalPlanilhaFat80.to_i
        puts "Validação FAT77 e FAT58 OK"
    else
        puts "Verificar valor do total do FAT77 com valor total do FAT80 #{@totalPlanilhaFat80} Fat77: #{@totalPlanilhaFat77Trat}"
    end

    File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat77}_Alterado.csv")
    File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat80}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat80}_Alterado.csv")

    visit("file:///#{varGlobal['diretorioAutomacao']}screenshot.html") # Abre o arquivo html criado na linha 180 para tirar a foto final para o relatorio
    File.delete("./screenshot.html") # deleta o arquivo HTML criado
  end