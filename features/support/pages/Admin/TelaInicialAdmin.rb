class TelaInicialAdmin  < SitePrism::Page
    #Menu Superior
    element :menuHome , :link,'Home',match: :first
    element :menuPControle , :link,'Painel de Controle',match: :first
    element :menuMarketplace , :link,'Marketplace',match: :first
    element :menuAdministracao , :link,'Administração',match: :first
    element :menuIaas , :link,'Iaas',match: :first
    element :menuMinhaEmp , :link,'Minha Empresa',match: :first
    element :menuPerfil , :link,'Meu Perfil',match: :first
    element :menuFaturamento , :link,'Faturamento',match: :first
    element :menuVWIMGOn , :link,'VW Image Onboarding',match: :first
    element :menuRelatorios , :link,'Relatórios',match: :first

    #Menu Inferior ADMINISTRAÇÃO
    element :gerenciamentoDeServicos, :link,'Gerenciamento de Serviços',match: :first
    element :gestaoMembros, :link,'Gestão de Membros',match: :first
    element :gerenContasFinanceiras, :link,'Gerenciamento de contas financeiras',match: :first
    element :fraude, :link,'Fraude',match: :first
    element :descCondicionais, :link, 'Descontos condicionais', match: :first
    element :credito, :link, 'Crédito', match: :first


    #Faturamento
    element :subMenuFatura ,'a.secmenuunselected'
    element :inputPesquisaFatura,'input#simpleValue'
    element :btnIR,'button.sbbuttontextlink'
    element :dropFiltrar, 'option[value="customerName"]'
    element :faturaCampoPeriodo, '.invoiceHeader_DueDate'
    element :faturaCampoValor,'.invoiceHeader_Amt'
    element :faturaCampoCliente, '.address#billTo'
    element :btnExpandir, :xpath, '//tbody/tr[1]/td[1]/a[1]'
    element :intervaloData, :xpath, '//tbody/tr[3]/td[4]'
    element :precoUnitario, :xpath,'//tbody/tr[3]/td[6]'
    element :valorTotalItenFat, :xpath,'//tbody/tr[3]/td[10]'

    def clicaFaturaCliente(cliente)
        first('tr[valign="middle"]', text: "#{cliente}").find('img[title="Ver"]')
    end

    #Sub-Tela Gerenciamento de Serviços
    element :cadastrarDescontoDealer , :link,'Cadastrar desconto GN/ Dealer',match: :first
    element :btnNovo, '#cancel'
    element :selecionarLoja,'[name="storeId"]'
    element :selecionarServico, '[name="offerId"]'
    element :segmento,'[name="segmentId"]'
    element :valor, 'input[name="fixedPriceAmount"]'
    element :porcentagem, 'input[name="fixedPricePercent"]'
    element :valorPtax, 'input[name="variablePriceAmount"]'
    element :porcentagemPtax, 'input[name="variablePricePercent"]'
    element :btnInserir,'.sbButtonTextLink'
    element :btnOK,:xpath,'//tbody/tr[2]/td[1]/div[1]/div[1]/div[2]/iframe[1]'

    #Sub-Tela Gestão de Membros
    element :loja ,:link, "Lojas"
    element :btnProximaPagina, :xpath,'//tbody/tr[2]/td[6]/a[1]/img[1]'


    #ADMIN DEALER CANVAS BARRA ROXA MENU
    element :btnGerenciar, '#manageUsersId'
    element :btnPropostas,:link,'Propostas',match: :first
    element :cmpPesquisaCliente, '.searchbox.floatLeft.userInputTxtBox_listCustomers'
   

end