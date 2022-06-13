telaIni =TelaInicialAdmin.new

Quando('clicar em Gerenciamento de contas financeiras de uma loja {string}') do |loja|
    telaIni.gerenContasFinanceiras.click
    sleep 5
    @loja = loja
    #Iframe com elementos
    within_frame(:xpath,"//iframe[@id='iframe']") do
        click_on "Contas por serviço"
        find("div.v-input__append-inner").click
        tirar_foto('fluxoValidacaoContasFinanceirasbtnContasServicos', 'passou')
        find('div[role="listbox"]' ).send_keys :end
        find(".v-list-item__content", text: "#{@loja}", visible: true).click
        click_on "Buscar"

      end

     sleep 5
  end
  
  Então('posso validar as contas cadastradas') do 

    #FATO365CSPGW
    @codigoServicos = [
      'visioonlineplan2',
      'windows10enterprisee3',
      'visioonlineplan1',
      'sharepointonlineplan1',
      'PowerBIPremiumP5',
      'azureactivedirectorypremiumP1',
      'Dynamics365AIforSales',
      'Dynamics365forCustomerServiceEnterprise',
      'AzureActiveDirectoryPremiumP2',
      'dynamics365forsalesprofessional',
      'Dynamics365RemoteAssist',
      'dynamics365forfieldservice',
      'Dynamics365TeamMembers',
      'Dynamics365UnifiedOperationsDevice',
      'dynamics365formarketing',
      'Dynamics365UnifiedOperationsActivity',
      'dynamics365forretail',
      'ExchangeOnlineKiosk',
      'dynamics365forsalesenterprise',
      'ExchangeOnlinePlan2',
      'ExchangeOnlineProtection',
      'dynamics365forsalesenterprisedevice',
      'MeetingRoom',
      'dynamics365layout',
      'MicrosoftIntuneDevice',
      'Dynamics365Plan',
      'office365advancedcompliance',
      'MicrosoftPowerAppsPlan1',
      'exchangeonlinearchivingeexchangeonline',
      'office365be',
      'Office65Business',
      'Microsoft365E3',
      'projectonlineprofessional',
      'Office365AdvancedThreatProtectionP2',
      'PowerBIPremiumP1',
      'projectonlinepremium',
      'Dynamics365UnifiedOperationsPlan',
      'ProjectOnlineEssentials',
      'PowerBIPro',
      'PowerBIPremiumP3',
      'Office365BusinessPremium',
      'Office365EnterpriseE1',
      'Office365F1',
      'Office365ProPlus',
      'OneDriveforBusinessPlan1',
      'windows10enterprisee5',
      'sharepointonlineplan2',
      'dynamics365forprojectserviceautomation',
      'windows10enterprisee3vda',
      'Dynamics365BusinessCentralExternalAccountant',
      'ExchangeOnlineArchivingforExchangeServer',
      'dynamics365forfieldservicedevice',
      'PowerBIPremiumP4',
      'Dynamics365forCustomerServiceEnterpriseDevice',
      'Dynamics365BusinessCentralEssential',
      'Dynamics365AdditionalDatabaseStorage',
      'microsoftkaizalapro',
      'office356bp',
      'dynamics365forcustomerserviceprofessional',
      'EnterpriseMobilitySecurityE5',
      'Dynamics365BusinessCentralPremium',
      'Dynamics365forTalent',
      'Dynamics365BusinessCentralTeamMember',
      'skypeforbusinessonlineplan2',
      'AzureActiveDirectoryBasic',
      'Microsoft365E5',
      'Microsoft365F1',
      'PowerBIPremiumP2',
      'Office365EnterpriseE5',
      'msflowPlan1',
      'Office365BusinessEssentials',
      'AudioConferencing',
      'Dynamics365AdditionalNonProductionInstance',
      'MicrosoftCloudAppSecurity',
      'dummyservice',
      'hsmnanuvem3',
      'mcafeeorigin2',
      'dinamopixpagamentoinstantaneo',
      'testevideo',
      'mcafee1',
      'PhoneSystem',
      'elevevendas',
      'demoservice',
      'servicoprofissional',
      'mcafee',
      'PowApPowapaddon',
      'MicE5InsRiskMa',
      'Office365F3',
      'PowerAppsuser',
      'MicE5InsRiskMa',
      'MicE5eDAud',
      'PoApPorlogcapaddon',
      'ProjectPlan1',
      'PowerAppsuser',
      'MicE5eDAud',
      'MicE5InsRiskMa',
      'PowerAppplan',
      'AzureInformationProtectionPremiumP2',
      'msflowPlan2',
      'Dynamics 365 for Marketing',
      'Azure Active Directory Premium P1',
      'AdvancedeDiscoveryStorage',
      'Dynamics 365 AI for Sales',
      'MicrosoftPowerAppsPlan2',
      'Office365EnterpriseE3',
      'OneDriveforBusinessPlan2',
      'AzureAdvancedThreatProtectionforUsers',
      'AzureInformationProtectionPlan1',
      'EnterpriseMobilitySecurityE3',
      'ExchangeOnlinePlan1',
      'MSintune',
      'addonsmcafee1',
      'serviceone',
      'servicetwo',
      'mcafeev2',
      'hsmnanuvem2',
      'Office365E5',
      'Microsoft 365 Business',
      'Office365E1']

    #FATCLOUDAWSGW
    @codigoServicos2 = [
      'awslinuxstack',
      'vivocloudawslinux',
      'vivocloudawswindows',
      'amazonsubscriptionservicesweden',
      'awsstack']

    #TD.VCO.VWS.SP
    @codigoServicos3 = [
      'huaweicloudstack', 
      'jamcrackeropenstackvivosubscriptionservice']

    #FATAZURECSPGW
    @codigoServicos4 = [
      'newazurecspsubscriptionservice',
      'azurecsplinuxstack',
      'microsoftazureubuntustack',
      'microsoftazurewindowsstack']


    for codigoServico in @codigoServicos 
        within_frame(:xpath,"//iframe[@id='iframe']") do
          @elemento = all('input[autocomplete]')[1].click
          tirar_foto('fluxoValidacaoContasFinanceirasBtnElementoAutoComplete', 'passou')
          @elemento.set "#{codigoServico}"
          expect(page).to have_text "#{codigoServico}"
          validacao = all('div.infoTable')[0]
          puts expect(validacao).to have_text("FATO365CSPGW")
        end
    end
    puts "Fim do serviços FATO365CSPGW"

    for codigoServico in @codigoServicos2 
      within_frame(:xpath,"//iframe[@id='iframe']") do
        @elemento = all('input[autocomplete]')[1].click
        @elemento.set "#{codigoServico}"
        expect(page).to have_text "#{codigoServico}"
        validacao = all('div.infoTable')[0]
        puts expect(validacao).to have_text("FATCLOUDAWSGW")
      end
    end
    puts "Fim do serviços FATCLOUDAWSGW"

    for codigoServico in @codigoServicos3 
      within_frame(:xpath,"//iframe[@id='iframe']") do
        @elemento = all('input[autocomplete]')[1].click
        @elemento.set "#{codigoServico}"
        expect(page).to have_text "#{codigoServico}"
        validacao = all('div.infoTable')[0]
        puts expect(validacao).to have_text("TD.VCO.VWS.SP")
      end
    end
    puts "Fim do serviços TD.VCO.VWS.SP"

    for codigoServico in @codigoServicos4
      within_frame(:xpath,"//iframe[@id='iframe']") do
        @elemento = all('input[autocomplete]')[1].click
        @elemento.set "#{codigoServico}"
        expect(page).to have_text "#{codigoServico}"
        validacao = all('div.infoTable')[0]
        puts expect(validacao).to have_text("FATAZURECSPGW")
      end
    end
    puts "Fim do serviços FATAZURECSPGW"

  end