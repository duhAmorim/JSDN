class Assinaturas < SitePrism::Page
    #TELA ASSINATURA
    element :status, 'td.jcTable_orderList_main-col-4'
    element :btnVerDetalhes, :xpath,'//*[@id="actionHover"]/a[2]'
    element :btnRefress, '.refreshTable'
    element :btnAcoesImg, 'img.marginLeft-2'
    element :btnCancelarAss, :xpath, '//*[@id="actionHover"]/a[1]'
    element :btnConfirmaCancela, '#deprovSubmit'

#SUB-TELA DETALHES ASSINATURA
    element :quantProd, '#spin2'
    element :btnAplicar, '#apply'
    element :btnConfirmar, '#confirm'

#SUB-TELA Reduzir Assinatura(após clicar confirmar)
    element :quantRed2, '#Quantity', match: :first
    element :btnSalvar, '#saveReduceSubscription'

#SUB-TELA UPGRADE ASSINATURA ALERTA
    element :tituloAlerta, "div#pop_title"
    element :btnOK, :xpath, "//body[1]/div[8]/div[1]/table[1]/tbody[1]/tr[2]/td[2]/div[2]/div[1]/div[1]/div[1]/div[1]/button[1]/span[1]"
end