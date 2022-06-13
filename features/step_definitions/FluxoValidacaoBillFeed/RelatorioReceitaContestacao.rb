require 'yaml'
require 'csv'
require 'roo' #Biblioteca para arquivos xlsx

csvm = CSVmanubula.new 
admin = TelaInicialAdmin.new        
relatorioOff = RelatorioOffiLine.new

# Leitura de YAML
varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))

nomeArquivoBillFeed = csvm.encontraNomeArquivoFat("DailyConsolidatedFeed")
nomeArquivoFat57 = csvm.encontraNomeArquivoFat("FAT57")
nomeArquivoFat79 = csvm.encontraNomeArquivoFat("FAT57")
nomeArquivoRelatorioContestacao = csvm.encontraNomeArquivoFat("relatorio-de-receita-contestacao")

Dado('clico no sub-menu RelatorioServicoFaturado') do
    admin.menuRelatorios.click
    tirar_foto('Clicar menu relatorio', 'passou')
    sleep 2
  end
  
  Dado('baixo o relatorio de receita de contestação em um determinado periodo') do
   
    within_frame(:xpath,('//iframe[@id="idIframe"]')) do
      relatorioOff.relatorioReceitaContestacao.click
      tirar_foto('Baixar relatorio contestação', 'passou')
      end

      within_frame(find('#idIframe')) do
        within_frame(find('#idIframe')) do
          find(:xpath,"//input[@id='radio-date-range']").click
           relatorioOff.relatorioContestDataInicio.set varGlobal["dataInicialRelatorioReceitaContestacao"]
           relatorioOff.relatorioContestDataFinal.set varGlobal["dataFinalRelatorioReceitaContestacao"]
     end
    end
  end
  
  Quando('o relatorio realizar o download') do
    within_frame(find('#idIframe')) do
      within_frame(find('#idIframe')) do
        rellFSW = FiltroRelatorioFSW.new
        rellFSW.btnExecutrar.click
      end
    end
  
    #Loop para verificar se o arquivo foi feito o download, caso não fazer o download vai ficar no loop infinito
    verificaDado = File.file?("#{varGlobal['diretorioPastaDownloads']}#{nomeArquivoRelatorioContestacao}")
    if !verificaDado
      while !verificaDado
        sleep 1
        verificaDado = File.file?("#{varGlobal['diretorioPastaDownloads']}#{nomeArquivoRelatorioContestacao}")
        if verificaDado == true
          puts "arquivo baixou"
          break
        end
      end
    end

  end
  
  Então('posso realizar a validação do arquivo de RelatorioReceitaContestacao') do

    origem = "#{varGlobal['diretorioPastaDownloads']}#{nomeArquivoRelatorioContestacao}"
    destino = "#{varGlobal['diretorioAutomacao']}features/step_definitions/FluxoValidacaoBillFeed/Relatorio"
    FileUtils.cp(origem, destino)

    #Calcula valor contestado XLSX
    def calculaValorContestadoXLS loja
      arquivo = Roo::Spreadsheet.open './features/step_definitions/FluxoValidacaoBillFeed/Relatorio/relatorio-de-receita-contestacao.xlsx'
      arquivo.each_with_pagename do |name, sheet|      
      ultimaLinha = sheet.last_row # Retorna um inteiro com o valor da ultima linha do arquivo

      #Iteração para calcular somente colunas que contenha TELEFONICA CLOUD ou Telefonica BRASIL de acordo com o ARGUMENTO PASSADO na chamada da função ### VALIDA VALORES DA COLUNA VALOR CONTESTADO
        i = 0
        soma = 0
        while i < ultimaLinha + 1 # Soma +1 para iterar tambem com o ultimo item do array       
          if sheet.row(i)[22] == loja # Recebe a loja que deseja calcular por parametro da função
            valorDaCol = sheet.row(i)[6].to_f.round(2) # Coluna: Valor Contestado [6]
            soma = soma + valorDaCol # Soma o valor da coluna da planilha com o valor da variavel "SOMA" para trazer o valor total acumulado de cada iteração do loop.
          end
          i+=1
        end 
        return soma.to_f.round(2)       
      end # Fim EACH LEITURA DE ARQUIVO
    end # Fim Função
    
    tbraRelatorioXLS = calculaValorContestadoXLS("Telefônica Brasil S.A") #TBRA FAT57 ARGUMENTO PASSADO PARA CALCULAR A LOJA
    cloudcoRelatorioXLS = calculaValorContestadoXLS("Telefônica Cloud e Tecnologia do Brasil S.A") #CLOUDCO FAT79
    
    #puts "Valor contestado TBRA #{tbraRelatorio}"
    #puts "Valor contestado CloudCO #{cloudcoRelatorio}"

    #Valida a coluna Conta Financeira do arquivo XLSX
    def validaColunaContaFinanceiraXLS loja
      arquivo = Roo::Spreadsheet.open './features/step_definitions/FluxoValidacaoBillFeed/Relatorio/relatorio-de-receita-contestacao.xlsx'
      arquivo.each_with_pagename do |name, sheet|      
      ultimaLinha = sheet.last_row # Retorna um inteiro com o valor da ultima linha do arquivo

      #Iteração para extrair os valores da coluna CONTAFINANCEIRA de acordo com loja no argumento passado na chamada da função
        i = 0
        valor = []
        while i < ultimaLinha + 1 # Soma +1 para iterar tambem com o ultimo item do array       
          if sheet.row(i)[22] == loja # Recebe a loja que deseja calcular por parametro da função
            valorDaCol = sheet.row(i)[16] # Coluna: Valor Contestado [6]
            valor += [valorDaCol]
          end
          i+=1
        end 
        return  valor     
      end # Fim EACH LEITURA DE ARQUIVO
    end # Fim Função

    tbraRelatorioColContaFinanceira = validaColunaContaFinanceiraXLS('Telefônica Brasil S.A')
    cloudcoRelatorioColContaFinanceira = validaColunaContaFinanceiraXLS("Telefônica Cloud e Tecnologia do Brasil S.A") #CLOUDCO FAT79

    # Validação junto a FAT57 e FAT79
    # Abre o arquivo TXT e converte em CSV com as colunas exatas do arquivo TXT.
    csvm.converteTXTParaCSVFat(nomeArquivoFat57) # Passa a variável do arquivo YAML para a função
    csvm.converteTXTParaCSVFat(nomeArquivoFat79)
    
    #Valida FAT57.TXT e FAT79.TXT VALORES DAS COLUNAS DOS PREÇOS
    # Inicia a verifiação do novo arquivo CSV, pois, fica mais fácil fazer a manipulação com CSV.  
    @tbl57 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat57}_Alterado.csv", col_sep: ";" ) # Abre o arquivo CSV gerado anteriormente e o separa por virgulas 
    @tbl79 = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat79}_Alterado.csv", col_sep: ";" ) # Abre o arquivo CSV gerado anteriormente e o separa por virgulas 
    # Validação do VALOR CONTESTADO
    def calculoValorFatTXT(tbl)
      i = 2
      @totalPlanilha = 0
      while i < tbl.length do
          @colValidacao = tbl[i][2].to_s.gsub(/\,/,".") # Tratamento para tirar virgula e colocar ponto
          @totalPlanilha = @totalPlanilha + @colValidacao.to_f # Itera sobre o falor total, acumulando o valor da compra em cada iteração
          i+=1
      end
     return (@totalPlanilha/2).round(2) # Divide por 2, pois a fatura no arquio TXT vem duplicada.
    end

   tbraFatTXT = calculoValorFatTXT(@tbl57)
   cloudCoFatTXT = calculoValorFatTXT(@tbl79)

   puts "Valor FAT57 = #{tbraFatTXT}, Valor Relatorio Contestação = #{tbraRelatorioXLS}"
   puts "Valor FAT57 = #{cloudCoFatTXT}, Valor Relatorio Contestação = #{cloudcoRelatorioXLS}"

   #VALIDAÇÃO COLUNA CONTA FINANCEIRA NO TXT FAT57 e FAT79
   def validaColunaContaFinanceiraTXT(tbl)
    i = 2
    nomeColunas =[]
    while i < tbl.length do
        @colValidacaoContaFinanceira = tbl[i][1]
        i+=1
        nomeColunas += [@colValidacaoContaFinanceira]
    end
   return nomeColunas
  end
  # CHAMA METODO PARA EXTRAIR VALORES DA COLUNA DE CONTA FINANCEIRA
  fat57validaColunaContaFinanceiraTXT = validaColunaContaFinanceiraTXT(@tbl57)
  fat79validaColunaContaFinanceiraTXT = validaColunaContaFinanceiraTXT(@tbl79) 

  #VALIDA LOJA TBRA COLUNA CONTAFINANCEIRA
  fat57validaColunaContaFinanceiraTXT = fat57validaColunaContaFinanceiraTXT.uniq.to_a #REMOVE VALORES DUPLICADOS E TRANSFORMA EM ARRAY
  fat57validaColunaContaFinanceiraTXT = fat57validaColunaContaFinanceiraTXT.length-1 # REMOVE A ULTIMA LINHA LIXO DO ARQUIVO TXT PARA FAZER A VALIDAÇÃO DO NUMERO DE COLUNAS
  
  tbraRelatorioColContaFinanceira = tbraRelatorioColContaFinanceira.uniq.to_a
  tbraRelatorioColContaFinanceira = tbraRelatorioColContaFinanceira.length

  if  fat57validaColunaContaFinanceiraTXT == tbraRelatorioColContaFinanceira 
    puts "Coluna CONTA FINANCEIRA validada LOJA TBRA"
  else
    puts "Verificar presença de BUG coluna conta financeira"
  end

  #VALIDA LOJA CLOUDCO COLUNA CONTAFINANCEIRA
  fat79validaColunaContaFinanceiraTXT = fat79validaColunaContaFinanceiraTXT.uniq.to_a
  fat79validaColunaContaFinanceiraTXT = fat79validaColunaContaFinanceiraTXT.length-1
  
  cloudcoRelatorioColContaFinanceira = cloudcoRelatorioColContaFinanceira.uniq.to_a
  cloudcoRelatorioColContaFinanceira = cloudcoRelatorioColContaFinanceira.length
  
  if  fat79validaColunaContaFinanceiraTXT == cloudcoRelatorioColContaFinanceira 
    puts "Coluna CONTA FINANCEIRA validada LOJA CLOUDCO"
  else
    puts "Verificar presença de BUG coluna conta financeira"
  end



  # Deleta o arquivo CSV criado a partir do TXT de FAT55, ele é criado na linha 18, pois a manipulação dos dados e mais fácil no arquivo CSV. Comente a linha abaixo para ver o arquivo.
  File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat57}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat57}_Alterado.csv")
  File.delete("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat79}_Alterado.csv") if File.exist?("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoFat79}_Alterado.csv")


  end #Fim BDD


  # colValorContestado = sheet.column(7).drop(5) # Seleciona a coluna 7 do arquivo, remove as 5 primeiras linhas da coluna.