require 'csv'
csvm = CSVmanubula.new 

  # INICIO PRIMEIRO BDD
Dado('que tenha tenho gerado consumo na plataforma antes do final ciclo de fechamento') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  Dado('Gerado as invoices') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  Quando('gerar o billfeed do ambiente') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  
  Então('o billfeed deve conter as colunas {string} - {string}') do |string, string2|
    nomeArquivoBillFeed = csvm.encontraNomeArquivoFat("DailyConsolidatedFeed")
    @tbl = CSV.read("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivoBillFeed}", col_sep: "," )

    puts "Numero de linhas no arquivo é: #{@tbl.length}"
    puts "Numero de colunas no arquivo: #{@tbl[0].length}"
    numColArquivo = @tbl[0].length

    # Valida o total de colunas da planilha
    if numColArquivo == 142 
        puts "Numero de colunas do arquivo esta correto"
    else
        puts"Verifique o numero de colunas do arquivo"
    end

    i= 0
    while i < @tbl[0].length do
        @colValidacao = @tbl[0][i].strip
        # VALIDAÇÃO DE COLUNAS DO ARQUIVO
        if @colValidacao == "Sequence" || @colValidacao == "Marketplace" || @colValidacao == "Reseller Name" || @colValidacao == "Reseller Contact Name" || @colValidacao == "Reseller Email Address" || @colValidacao == "Reseller Phone Number" || @colValidacao == "Order Id" || @colValidacao == "Subscription Id" || @colValidacao == "Activity Type" || @colValidacao == "Service Type" || @colValidacao == "Order Creation Date" || @colValidacao == "Purchase Date" || @colValidacao == "Activation Date" || @colValidacao == "Subscription Type" || @colValidacao == "Term Start Date" || @colValidacao == "Term End Date" || @colValidacao == "Term Duration" || @colValidacao == "Next Renewal Date" || @colValidacao == "Service Cancellation Date" || @colValidacao == "Bill From" || @colValidacao == "Bill To" || @colValidacao == "Company Name" || @colValidacao == "Customer Acronym" || @colValidacao == "Account Creation Date" || @colValidacao == "First Name" || @colValidacao == "Last Name" || @colValidacao == "Customer Email Address" || @colValidacao == "Customer Phone Number" || @colValidacao == "Billing Street" || @colValidacao == "Billing Number" || @colValidacao == "Billing Complement" || @colValidacao == "Billing Neighbourhood" || @colValidacao == "Billing City" || @colValidacao == "Billing  State/Province" || @colValidacao == "Billing  ZIP code" || @colValidacao == "Billing Country" || @colValidacao == "Billing  Country Code" || @colValidacao == "Billing Phone Number" || @colValidacao == "Mailing Street" || @colValidacao == "Mailing Number" || @colValidacao == "Mailing Complement" || @colValidacao == "Mailing City" || @colValidacao == "Mailing  State/Province" || @colValidacao == "Mailing  ZIP code" || @colValidacao == "Mailing Country" || @colValidacao == "Mailing  Country Code" || @colValidacao == "Mailing Phone Number" || @colValidacao == "Service Name" || @colValidacao ==  "Offer Name" || @colValidacao == "Offer Code" || @colValidacao == "Sales Reference Code" || @colValidacao == "Unit Of Measure" || @colValidacao == "Qty" || @colValidacao == "Pro-rate Scale" || @colValidacao == "Retail Unit Price" || @colValidacao == "Pro-rated Retail Price Unit Price" || @colValidacao == "Gross Retail Price" || @colValidacao == "Retail Price Discount (%)" || @colValidacao == "Pro-Rated Retail Unit Discounted Price (Amount)" || @colValidacao == "Total Retail Price Discount (Amount)" || @colValidacao == "Total Retail Price" || @colValidacao == "Tax on Total Retail Price" || @colValidacao == "Grand Total: Retail Price" || @colValidacao == "Promotion Code" || @colValidacao == "Promotion duration" || @colValidacao == "Wholesale Unit Price" || @colValidacao == "Pro-rated Wholesale Unit Price" || @colValidacao ==  "Customer Transaction Currency" || @colValidacao == "Vendor Currency" || @colValidacao == "Gross Wholesale Price" || @colValidacao == "Wholesale Price Discount (%)" || @colValidacao == "Pro-Rated Wholesale Unit Discounted Price (Amount)" || @colValidacao == "Total Wholesale Price Discount (Amount)" || @colValidacao == "Total Wholesale Price" || @colValidacao == "Tax on Total Wholesale Price" || @colValidacao == "Grand Total: Wholesale Price" || @colValidacao == "Vendor Name" || @colValidacao == "Vendor Unit Price" || @colValidacao == "Pro-rated Vendor Unit Price" || @colValidacao == "Total Vendor Price" || @colValidacao == "Tax on Total Vendor Price" || @colValidacao == "Grand Total: Vendor Price" || @colValidacao == "Billing Cycle" || @colValidacao == "Prorate Type" || @colValidacao == "Prorate On Cancellation" || @colValidacao == "Usage Attributes" || @colValidacao == "Payment Method" || @colValidacao == "Payment Status" || @colValidacao == "Refund Type" || @colValidacao == "Refund Amount" || @colValidacao == "Invoice Number" || @colValidacao == "Resource Id" || @colValidacao == "Charge Type" || @colValidacao == "Invoice Status" || @colValidacao == "Customer CPF" || @colValidacao == "Customer CNPJ" || @colValidacao == "Customer State Registration" || @colValidacao == "Invoice Creation Date" || @colValidacao == "Service Code" || @colValidacao == "Due Date" || @colValidacao == "Store Code" || @colValidacao == "Marketplace City" || @colValidacao == "Marketplace State" || @colValidacao == "User Account Status" || @colValidacao == "Premeditated defaulter" || @colValidacao == "Individual Invoice" || @colValidacao == "Municipal Taxpayer Registration" || @colValidacao == "Company Code" || @colValidacao ==  "Affiliate Code" || @colValidacao == "City Service Code" || @colValidacao == "Special Procedure Number" || @colValidacao == "Description City Service (fee)" || @colValidacao == "Total Invoice Price" || @colValidacao == "Total Due Amount" || @colValidacao == "Customer Code" || @colValidacao == "Segment" || @colValidacao == "Cycle Code" || @colValidacao == "Cycle Reference" || @colValidacao == "Tax Code" || @colValidacao == "Tax Rate-ISS" || @colValidacao == "Total Tax-IS" || @colValidacao == "Tax Code" || @colValidacao == "Tax Rate-CONFINS" || @colValidacao == "Total Tax-CONFINS" || @colValidacao == "Tax Code" || @colValidacao == "Tax Rate-PIS" || @colValidacao == "Total Tax-PIS" || @colValidacao == "Financial Status" || @colValidacao == "Comments Credited" || @colValidacao == "Receivable" || @colValidacao == "User CPF has made the credit" || @colValidacao == "Proposal Number" || @colValidacao == "Adabas Code" || @colValidacao == "Opportunity Id" || @colValidacao == "Quote Id" || @colValidacao == "Original Retail Price" || @colValidacao == "Original Wholesale Price" || @colValidacao == "Original Vendor Price" || @colValidacao == "Exchange Rate" || @colValidacao == "invoice-tax-calculation-base" || @colValidacao == "Store Acronym" || @colValidacao == "Total Retail Price with taxes without discount" || @colValidacao == "CNPJ Store" || @colValidacao == "Contractual Fine Percentage" || @colValidacao == "Installment Value" || @colValidacao == "Number of Months" || @colValidacao == "Number of Days"
        puts "NOME DA COLUNA VALIDADA: #{@colValidacao} Validada"
        else 
            puts "NÃO foi possivel encontrar a COLUNA: #{@colValidacao}"
        end
    i+=1
    end

  end
  # FIM PRIMEIRO BDD



Dado('que tenha acessado o super admin') do
    acesso = Ambientes.new
    acesso.load
    tirar_foto('acesso super admin', 'passou')
    
    if current_url.include?('dev')
        visit('https://admin-dev.vivoplataformadigital.com.br/jsdn/superadmin/pages/view.jsp?view=.view.jsdn.superadmin.login')
        lgSuperAdminpg = LoginSuperAdminPage.new
        lgSuperAdminpg.userSuperAdmin.set 'superadmin@jamcrackerjsdn.com'
        lgSuperAdminpg.passSuperAdmin.set 'Vivomasteradmin@123*'
        lgSuperAdminpg.btnSuperAmin.click

    elsif current_url.include?('stg-isv')
            visit('https://admin-stg-isv.vivoplataformadigital.com.br/jsdn/superadmin/pages/view.jsp?view=.view.jsdn.superadmin.login')
            lgSuperAdminpg = LoginSuperAdminPage.new
            lgSuperAdminpg.userSuperAdmin.set 'superadmin@jamcrackerjsdn.comstg'
            lgSuperAdminpg.passSuperAdmin.set 'Vivomasteradmin@123*'
            lgSuperAdminpg.btnSuperAmin.click

          elsif current_url.include?('stg')
            visit('https://admin-stg.vivoplataformadigital.com.br/jsdn/superadmin/pages/view.jsp?view=.view.jsdn.superadmin.login')
            lgSuperAdminpg = LoginSuperAdminPage.new
            lgSuperAdminpg.userSuperAdmin.set 'superadmin@jamcrackerjsdn.com'
            lgSuperAdminpg.passSuperAdmin.set 'root123'
            lgSuperAdminpg.btnSuperAmin.click

         elsif current_url.include?('prod')
            visit('https://admin.vivoplataformadigital.com.br/jsdn/superadmin/pages/view.jsp?view=.view.jsdn.superadmin.login')
            lgSuperAdminpg = LoginSuperAdminPage.new
            lgSuperAdminpg.userSuperAdmin.set 'superadmin@jamcrackerjsdn.com'
            lgSuperAdminpg.passSuperAdmin.set 'Vivomasteradmin@123*'
            lgSuperAdminpg.btnSuperAmin.click
        end
  end
  
  Dado('acessado o menu COnfiguração do ambiente') do
    menuSuperadmin = ConfiguracaoAmbienteFakePage.new 
    menuSuperadmin.menuConfigAmbienteFake.click
    tirar_foto('Acesso menu configuração no super admin', 'passou')
  end
  
  Dado('Acessado o menu de Job relatório de consumo diário') do
    menuSuperadmin = ConfiguracaoAmbienteFakePage.new 
    menuSuperadmin.jobRelatorioConsumoDiario.click
    tirar_foto('job do DCR', 'passou')
  end
  
  Dado('clicar em executar o Job do relatório de consumo diário') do
    jobDCR = JobRelatorioConsumoDiarioPage.new
    sleep 2
    jobDCR.btnExecutar.click
    tirar_foto('Execução do job DCR', 'passou')
  end
  
  Dado('o job finalizar com sucesso') do
    jobDCR = JobRelatorioConsumoDiarioPage.new
    menuSuperadmin = ConfiguracaoAmbienteFakePage.new
    statusDCR= false
    laco = 0
    while laco<1 do
      tirar_foto('Status do job', 'passou')
        statusDCR =  has_xpath?"//td[contains(text(),'Concluído')]"
        puts statusDCR
        if statusDCR == true 
            laco=1
        end
        sleep 10
        menuSuperadmin.jobRelatorioConsumoDiario.click
      end

  end
  
  Quando('acessar o admin mkt') do
    acesso = Ambientes.new
    acesso.load
    lgAdm = LoginAdmin.new
    if current_url.include?('dev')
        visit('https://admin-dev.vivoplataformadigital.com.br/')
        sleep 2
        
        lgAdm.acessoAdminMKT

    elsif current_url.include?('stg-isv')
            visit('https://admin-stg-isv.vivoplataformadigital.com.br/')
            sleep 2
        
        lgAdm.acessoAdminMKT

      elsif current_url.include?('uat-billing')
        visit('https://admin-uat-billing.vivoplataformadigital.com.br/')
        sleep 2
    
    lgAdm.acessoAdminMKT
   
    elsif current_url.include?('stg')
            visit('https://admin-stg.vivoplataformadigital.com.br/')
            
            sleep 2
           
            lgAdm.acessoAdminMKT
                    
        end
        tirar_foto('acesso mkt', 'passou')
  end
  
  Quando('acessar o menu Relatórios') do
    sleep 2
     menuMKT = HomeAdmMKT.new
     menuMKT.relatorios.click
     tirar_foto('Acesso menu relatório', 'passou')
  end
  
  Quando('acessar aba Relatórios Personalizados') do
    menuRelatorios = RelatoriosMKT.new 
    menuRelatorios.relatoriospersonalisados.click
    tirar_foto('Acesso relatório personalizado', 'passou')
  end
  
  Quando('Clicar em Adicionar Relatório Personalizado') do

    within_frame(find('#idIframe')) do

        menuRelatorios = RelatoriosMKT.new 
        menuRelatorios.addRelatorioPersonalizado.click  
    end
         
 
    tirar_foto('Criar relatorio personalizado', 'passou')
    
  end
  
  Quando('preencher o nome para o relatório {string}') do |string|
    within_frame(find('#idIframe')) do
         
        relatorioPers = RelatorioPersonalizado.new 
        relatorioPers.nomePersonalizado.set string  

    end
  end
  
  Quando('preencher a descrição do relatório {string}') do |string|
    within_frame(find('#idIframe')) do

        relatorioPers = RelatorioPersonalizado.new 
        relatorioPers.descPersonalizado.set string  


    end
  end
  
  Quando('Selecionar o datamart {string}') do |string|
    within_frame(find('#idIframe')) do
         
        relatorioPers = RelatorioPersonalizado.new 
        relatorioPers.datamart.select string  
        sleep 3
    end
  end
  
  Quando('clicar em Selecionar tudo') do
    within_frame(find('#idIframe')) do
         
        relatorioPers = RelatorioPersonalizado.new 
        relatorioPers.selecionarTudo.click 
        sleep 2

    end  
    tirar_foto('Dados relatorio DCR', 'passou')
end
  
  Quando('clicar no botão de Gerar relatório') do
    within_frame(find('#idIframe')) do
         
        relatorioPers = RelatorioPersonalizado.new 
        relatorioPers.btnGerarRelatorio.click 

    end
    tirar_foto('Gerar DCR', 'passou')
  end
  
  Quando('selecionar o opção de filtro Personalizadas') do
    within_frame(find('#idIframe')) do
         
        filroRelatorio = FiltroRelatorioJSDN.new 
        filroRelatorio.filtroPersonalizado.click 

    end
  end
  
  Quando('preencher as datas com o ciclo de {string} até {string}') do |string, string2|
    within_frame(find('#idIframe')) do
         #entender o calendar
        filroRelatorio = FiltroRelatorioJSDN.new 
        scriptDTInicial = "document.getElementById('f_date_a').value = '"+string+"'"
        scriptDTFinal = "document.getElementById('f_date_a1').value = '"+string2+"'"
        page.execute_script(scriptDTInicial)
        page.execute_script(scriptDTFinal)
        
        
        filroRelatorio.dataFinal.set string2

    end
  end
  
  Quando('selecionar o modelo CSV') do
    within_frame(find('#idIframe')) do
         
        filroRelatorio = FiltroRelatorioJSDN.new 
        filroRelatorio.modelo.select 'CSV'
        sleep 10

    end
  end
  
  Quando('clicar em Executar o relatório') do
    within_frame(find('#idIframe')) do
      tirar_foto('Filtro DCR', 'passou')
        filroRelatorio = FiltroRelatorioJSDN.new 
        
        filroRelatorio.btnExecutrar.click

    end
  end
  
  Quando('aceitar o pop up do relatório com mais de {string} Colunas') do |string|
        page.accept_alert
    end
  
  Quando('acessar o menu Solicitações de Relatórios Off-line') do
        menu = RelatoriosMKT.new 
        sleep 2
        tirar_foto('Msg DCR', 'passou')
        menu.solicitacoesRelatoriosOffiline.click
     
        sleep 5
    end
  
  Quando('o relatório ficar disponivel para ser baixado') do
    relatorioOff = RelatorioOffiLine.new 
    statusDCR= false
    laco = 0
    tirar_foto('Relatorios Offline', 'passou')
    while laco<1 do
        
    
    within_frame(find('#idIframe')) do
         
        
        

    
        statusDCR =  has_xpath?"//tbody/tr[2]/td[contains(text(),'Email enviado')]"
        puts statusDCR
        if statusDCR == true 
            laco=1
        end
        tirar_foto('Status relatório DCR', 'passou')
        sleep 10
        page.driver.browser.navigate.refresh
      end

    end

  end
  
  Quando('baixar o relatório de consumo Diário') do
    

    within_frame(find('#idIframe')) do
         sleep 2
        relatorioOff = RelatorioOffiLine.new 
        relatorioOff.btnDonwloadOffilineUltimoRelatorio.click
        nomeRelatorioGrid = relatorioOff.nomeRelatorio.text
        idRelatorioGrid = relatorioOff.idSolicitacao.text
        @@nomeRelatorioDCR = nomeRelatorioGrid + '_' + idRelatorioGrid +'.csv'
    end
    #sleep de 30s enquando não temos um codigo de validação do downloade concluido pelo navegador
    sleep 30

end
  
  Então('o robo deve limpar o DCR para SaaS') do
        csvm = CSVmanubula.new  
        nomeArquivo =  @@nomeRelatorioDCR
        
        csvm.movimentarArquivo(nomeArquivo)
        csvm.limpezaDCR(nomeArquivo)

    end
  
    Dado('Acessado o menu de Job Gerar billfeed') do
      menuSuperadmin = ConfiguracaoAmbienteFakePage.new 
      menuSuperadmin.gerarBillfeed.click
      tirar_foto('Tela Gerar billfeed', 'passou')
    end
    
    Dado('clicar em executar o Job do Billfeed') do
      jobBill = JobgerarBillfeedPage.new
      sleep 2
      jobBill.btnExecutar.click
      tirar_foto('Execução do job Billfeed', 'passou')
    end
    
    Dado('o job do billfeed tenha finalizado com sucesso') do
    jobBill = JobgerarBillfeedPage.new
    menuSuperadmin = ConfiguracaoAmbienteFakePage.new
    statusDCR= false
    laco = 0
    while laco<1 do
      tirar_foto('Status do job billfeed', 'passou')
        statusDCR =  has_xpath?"//td[contains(text(),'Concluído')]"
        puts statusDCR
        if statusDCR == true 
            laco=1
        end
        sleep 10
        menuSuperadmin.gerarBillfeed.click
      end

    end
    
    Dado('baixar o billfeed') do
      #sleep de 30s enquando não temos um codigo de validação do downloade concluido pelo navegador
    sleep 30
      csvm = CSVmanubula.new  
      #pegar o elemento do nome da billfeed

      nomeArquivo =  nomeBillfeed
        
        csvm.movimentarArquivo(nomeArquivo)
        
    end
    
    Quando('comparar com o Billfeed com DCR') do
      csvm = CSVmanubula.new  
      nomeArquivo =  @@nomeRelatorioDCR
      csvm.limparBilfeedIaaS(nomeArquivo)
      
    end
    
    Então('no billfeed deve conter todos os pedidos do DCR') do 
      csvm = CSVmanubula.new  
      errorNaBill = csvm.validarBillComDCR
      expect(errorNaBill).to eq(0)
    end
    