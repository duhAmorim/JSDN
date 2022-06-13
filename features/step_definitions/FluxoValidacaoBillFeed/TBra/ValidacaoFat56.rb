require 'csv'  

varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))
csvm = CSVmanubula.new 
nomeArquivoFat55 = csvm.encontraNomeArquivoFat("FAT55")
nomeArquivoFat56 = csvm.encontraNomeArquivoFat("FAT56")

Dado('que recebo o arquivo TXT FAT56') do
    
    # Abre o arquibo TXT e converte em CSV com as colunas exatas do arquivo TXT.
    csvm.converteTXTParaCSVFat(nomeArquivoFat55)

  end
  
  Quando('converte-lo o arquivo Fat56 para CSV') do

    # Abre o arquibo TXT e converte em CSV com as colunas exatas do arquivo TXT.
    csvm.converteTXTParaCSVFat(nomeArquivoFat56)

    # Inicia a verifiação do novo arquivo CSV, pois, fica mais fácil fazer a manipulação com CSV.  
    @tblFat56 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat56}_Alterado.csv", col_sep: ";" ) # Abre o arquivo CSV gerado anteriormente e o separa por virgulas 
    nomeArquivo = @tblFat56[0] # Extrai a primeira linha do arquivo CSV.
    puts "Nome do arquivo :#{nomeArquivo.first}" # Extrai a primeira posição do array criado acima.
    @tblFat55 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv", col_sep: ";" )

  end
  
  Então('posso realizar a validação do arquivo Fat56 convertido') do
        # Validação da estrutura
    puts "Numero de colunas no arquivo: #{@tblFat56[2].length}"
    numCol = @tblFat56[2].length # Pega a primeira linha do arquivo saltando direto para a 3 linha do CSV, pois as duas primeiras linhas são lixo.
    if numCol == 10
        puts "Estrutura do arquivo com numero de colunas validado"
        puts "Valor de colunas OK"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> 'VALOR COLUNAS OK' </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    else
        puts "Estrutura arquivo diferente, verificar presença de bug"
    end
  end
  
  Então('das colunas Fat56') do
    
    # Valida numero de linhas na primeira coluna

    @stringInit = 'D1'
    # Loop para retirar os primeiros e ultimos elementos
    @tblFat56.each_with_index do |item, index|
        if index == 2 # Pega a terceira linha da planilha
            @primeiro = item[0][0..-11].gsub("#{@stringInit}", "").to_i
        elsif index == @tblFat56.size - 2 # Pega a penultima linha da planilha
            @ultimo = item[0][0..-12].gsub("#{@stringInit}", "").to_i
        elsif index == @tblFat56.size - 1 # Pega a utima linha da planilha
            @ultimoPlanilha = item[0].gsub("FF", "").to_i
        end
    end
    #Valida os dias da primeira coluna com o numero de linhas
    if @tblFat56.length-3 == @ultimo && @ultimo == @ultimoPlanilha
        puts "Valor linhas e dias na coluna OK"
    else
        puts "Planilha com BUG verificar numero de linhas e dias"
    end 
  end
  
  Então('dos valores da soma total Fat56') do
    
    # Validação do total da fatura da coluna
    i = 2
    @totalPlanilhaFat56 = 0
    while i < @tblFat56.length do
        @colValidacao = @tblFat56[i][2].to_s.gsub(/\,/,".") # Tratamento para tirar virgula e colocar ponto
        @totalPlanilhaFat56 = @totalPlanilhaFat56 + @colValidacao.to_f # Itera sobre o falor total, acumulando o valor da compra em cada iteração
        i+=1
    end
    @totalPlanilhaFat56 = @totalPlanilhaFat56.round(2) # Formata o valor do total da planilha para 2 pontos flutuantes
    puts "Total Planilha FAT56 transformada: #{@totalPlanilhaFat56}" 
    utimaLinha = @tblFat56.last # Pega o ultimo valor do arquivo CSV que é o total
    utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2) # transforma em string, retira o ";" e coloca "." transforma em ponto-flutuente em 2 casas decimais, com o intuito de fazer a comparação dos valores
    # Valida os valores da planilha CSV/TXT com os valores calculados pela automação
    if utimaLinha.to_s == @totalPlanilhaFat56.to_s  
        puts "Valor planilha TXT FAT56 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat56}"
        puts "Valor OK"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> 'VALOR OK' </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    else
        puts"Valor planilha TXT FAT56 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat56}"
        puts"Possui BUG"
        open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> 'VERIFICAR PRESENÇA DE BUG' </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
    end

  end
  
  Então('validar o Fat56 com o Fat55') do
        # Validação do total da fatura da coluna
        i = 2
        @totalPlanilhaFat55 = 0
        while i < @tblFat55.length do
            @colValidacao = @tblFat55[i][2].to_s.gsub(/\,/,".") # Tratamento para tirar virgula e colocar ponto
            @totalPlanilhaFat55 = @totalPlanilhaFat55 + @colValidacao.to_f # Itera sobre o falor total, acumulando o valor da compra em cada iteração
            i+=1
        end
        @totalPlanilhaFat55 = @totalPlanilhaFat55.round(2) # Formata o valor do total da planilha para 2 pontos flutuantes
        puts "Total Planilha FAT55 transformada: #{@totalPlanilhaFat55}" 
        utimaLinha = @tblFat55.last # Pega o ultimo valor do arquivo CSV que é o total
        utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2) # transforma em string, retira o ";" e coloca "." transforma em ponto-flutuente em 2 casas decimais, com o intuito de fazer a comparação dos valores
        # Valida os valores da planilha CSV/TXT com os valores calculados pela automação
        if utimaLinha.to_s == @totalPlanilhaFat55.to_s  
            puts "Valor planilha TXT FAT55 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat55}"
            puts "Valor OK"
            open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> 'VALOR OK' </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
        else
            puts"Valor planilha TXT FAT55 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat55}"
            puts"Possui BUG"
        end
        @totalPlanilhaFat55Trat = (@totalPlanilhaFat55/30*4).to_f.round(2) # Abrir FAT55, pegar o valor, dividir SEMPRE por 30 e multiplicar por 4
        puts "Tratamento para validar FAT56 #{@totalPlanilhaFat55Trat}"
        
        if @totalPlanilhaFat55Trat.to_i == @totalPlanilhaFat56.to_i
            puts "Validação FAT55 e FAT56 OK"
            open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> 'Validação FAT55 e FAT56 OK' </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
        else
            puts "Verificar valor do total do FAT55 com valor total do FAT56"
        end
        
        File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv")
        File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat56}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat56}_Alterado.csv")
        visit("file:///#{varGlobal['diretorioAutomacao']}screenshot.html")# Abre o arquivo html criado na linha 180 para tirar a foto final para o relatorio
        File.delete("./screenshot.html") # deleta o arquivo HTML criado
  end