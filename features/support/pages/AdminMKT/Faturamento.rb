class Faturamento  < SitePrism::Page   
    #submenu de faturamento no admin
    element :faturas, :xpath, '//a[contains(text(),"Faturas")]'

    #menu Faturas
    element :dropStatus, 'select[name="status"]'
    element :pesquisarFatura, '#simpleValue'
    element :btnPesquisarfatura, :xpath, '//button[contains(text(),"Ir")]'


    #grid de faturas
    element :numeroInvoice,:xpath, '//tr[2]/td[2]'
    element :valorInvoice,:xpath, '//tr[2]/td[8]'
    element :aplicarAjuste,:xpath, '//tr[2]/td[18]/a[2]'

    #tela de ajustes
    element :btnCredito,:xpath, '//a/font[contains(text(),"Crédito")]'
   

    #iframe de crédito
    element :valorCredito, '#amount'
    element :numProcesso, '#caseId'
    element :obs, '#description'
    element :numOrdem, '#requestNo'
    element :btnCreditoIframe,:xpath, '//button[contains(text(),"Crédito")]'

    #gerar boleto 
    element :btnGerarBoletoRetificado, '#boleto'

end