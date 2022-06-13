require 'csv'  
require 'yaml'

varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))
csvm = CSVmanubula.new 
nomeArquivoFat55 = csvm.encontraNomeArquivoFat("FAT55")
nomeArquivoFat58 = csvm.encontraNomeArquivoFat("FAT58")
nomeArquivoFat56 = csvm.encontraNomeArquivoFat("FAT56")

Dado('que recebo o arquivo TXT FAT58') do
        # Abre o arquibo TXT e converte em CSV com as colunas exatas do arquivo TXT.
        csvm.converteTXTParaCSVFat(nomeArquivoFat55)
  end
  
  Quando('converte-lo o arquivo Fat58 para CSV') do
        # Abre o arquibo TXT e converte em CSV com as colunas exatas do arquivo TXT.
        csvm.converteTXTParaCSVFat(nomeArquivoFat58)

        # Inicia a verifiação do novo arquivo CSV, pois, fica mais fácil fazer a manipulação com CSV.  
        @tblFat58 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat58}_Alterado.csv", col_sep: ";" ) # Abre o arquivo CSV gerado anteriormente e o separa por virgulas 
        nomeArquivo = @tblFat58[0] # Extrai a primeira linha do arquivo CSV.
        puts "Nome do arquivo :#{nomeArquivo.first}" # Extrai a primeira posição do array criado acima.
        @tblFat55 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv", col_sep: ";" )
  end
  
  Então('posso realizar a validação do arquivo Fat58 convertido') do
        # Validação da estrutura
        puts "Numero de colunas no arquivo: #{@tblFat58[2].length}"
        numCol = @tblFat58[2].length # Pega a primeira linha do arquivo saltando direto para a 3 linha do CSV, pois as duas primeiras linhas são lixo.
        if numCol == 10
            puts "Estrutura do arquivo com numero de colunas validado"
            puts "Valor de colunas OK"
        else
            puts "Estrutura arquivo diferente, verificar presença de bug"
        end
  end
  
  Então('das colunas Fat58') do
        # Valida numero de linhas na primeira coluna
        @stringInit = 'D1'
        # Loop para retirar os primeiros e ultimos elementos
        @tblFat58.each_with_index do |item, index|
            if index == 2 # Pega a terceira linha da planilha
                @primeiro = item[0][0..-11].gsub("#{@stringInit}", "").to_i
            elsif index == @tblFat58.size - 2 # Pega a penultima linha da planilha
                @ultimo = item[0][0..-12].gsub("#{@stringInit}", "").to_i
            elsif index == @tblFat58.size - 1 # Pega a utima linha da planilha
                @ultimoPlanilha = item[0].gsub("FF", "").to_i
            end
        end
        #Valida os dias da primeira coluna com o numero de linhas
        if @tblFat58.length-3 == @ultimo && @ultimo == @ultimoPlanilha
            puts "Valor linhas e dias na coluna OK"
        else
            puts "Planilha com BUG verificar numero de linhas e dias"
        end 
  end
  
  Então('dos valores da soma total Fat58') do
        # Validação do total da fatura da coluna
        i = 2
        @totalPlanilhaFat58 = 0
        while i < @tblFat58.length do
            @colValidacao = @tblFat58[i][2].to_s.gsub(/\,/,".") # Tratamento para tirar virgula e colocar ponto
            @totalPlanilhaFat58 = @totalPlanilhaFat58 + @colValidacao.to_f # Itera sobre o falor total, acumulando o valor da compra em cada iteração
            i+=1
        end
        @totalPlanilhaFat58 = @totalPlanilhaFat58.round(2) # Formata o valor do total da planilha para 2 pontos flutuantes
        puts "Total Planilha FAT58 transformada: #{@totalPlanilhaFat58}" 
        utimaLinha = @tblFat58.last # Pega o ultimo valor do arquivo CSV que é o total
        utimaLinha = utimaLinha[1].to_s.gsub(/\,/,".").to_f.round(2) # transforma em string, retira o ";" e coloca "." transforma em ponto-flutuente em 2 casas decimais, com o intuito de fazer a comparação dos valores
        # Valida os valores da planilha CSV/TXT com os valores calculados pela automação
        if utimaLinha.to_s == @totalPlanilhaFat58.to_s  
            puts "Valor planilha TXT FAT58 #{utimaLinha} igual ao valor calculado da automação  #{@totalPlanilhaFat58}"
            puts "Valor OK"
        else
            puts"Valor planilha TXT FAT58 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat58}"
            puts"Possui BUG"
        end
  end
  
  Então('validar o Fat58 com o Fat55') do
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
            open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> VALOR OK </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
        else
            puts"Valor planilha TXT FAT55 #{utimaLinha} diferente do valor calculado da automação #{@totalPlanilhaFat55}"
            puts"Possui BUG"
            open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> POSSUI BUG </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
        end
        @totalPlanilhaFat55Trat = (@totalPlanilhaFat55).to_f.round(2) # Abrir FAT55, pegar o valor total de FAT55
        # Verifica se o valor de FAT55 esta igual ao FAT58
        if @totalPlanilhaFat55Trat.to_i == @totalPlanilhaFat58.to_i
            puts "Validação FAT55 e FAT58 OK"
            open("screenshot.html", "a"){ |f| f.puts "<HTML><BODY><DIV> Validação FAT55 e FAT58 OK </DIV></BODY></HTML>"} # Cria um arquivo HTML para tirar o print e adicionar no relatorio
        else
            puts "Verificar valor do total do FAT55 com valor total do FAT58 #{@totalPlanilhaFat58} Fat55: #{@totalPlanilhaFat55Trat}"
        end

        File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat55}_Alterado.csv")
        File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat58}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat58}_Alterado.csv")
        
        visit("file:///#{varGlobal['diretorioAutomacao']}screenshot.html") # Abre o arquivo html criado na linha 180 para tirar a foto final para o relatorio
        File.delete("./screenshot.html") # deleta o arquivo HTML criado

        def moveArquivo nomeArquivo
            origem = "./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivo}"
            destino = "./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/Processados"
            FileUtils.mv(origem, destino)
        end

        moveArquivo(nomeArquivoFat55)
        moveArquivo(nomeArquivoFat56)
        moveArquivo(nomeArquivoFat58)
  end
