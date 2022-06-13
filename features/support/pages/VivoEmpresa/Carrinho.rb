class Carrinho < SitePrism::Page
    element :btnFinalizarCompra, '#checkout'
    elements :btnContinuarCredito, 'button[value="submit"]'
    element :dominio, '#domain'
    element :pgBoleto, '#billingMapBLT'
    element :prosseguir, '#btnProceed'
    element :nomeProduto, '#orderRcptOfferName'
    element :validaCredencial, '#loadingafmd'
    element :quantidade, 'input.center.marginTop-5'
    element :valorTotalGeral, 'p.GrandtotalValue'
    element :btnRemover,'a.removeSubs'
    element :validaPrecoUnitario, '.padding-6.paddingRight-0 .floatLeft.clearRight'
    element :campoCodigoDesconto, '.textinput'
    element :btnAplicar,'.inactive_small'

    #Pop-Up Crédito pré-aprovado
    element :btnContinuarNavegando, :xpath, '//tbody/tr[2]/td[2]/div[2]/div[1]/div[3]/div[1]/div[1]/div[1]/div[1]/button[1]'
    element :btnContinuarNavegando2,:link,'Continuar navegando',match: :first
    def btnContinuarNavegandoFunc
         '//tbody/tr[2]/td[2]/div[2]/div[1]/div[3]/div[1]/div[1]/div[1]/div[1]/button[1]'
    end

    #pop-up remover produto carrinho
    element :btnConfirmar, 'button.normal.marginRight-18'
    element :btnCancelar, 'button.inactive'

    #Após finalizar comprar-> Página: Contrato de serviços
    element :btnConcordoTudo, 'button[name="agree"]'
    element :btnCancelarContratoServ, 'button[name="cancel"]'
    element :tituloContrato, '#header_popUpId'
    def btnConcordoTudoFunc
        'button[name="agree"]'
    end
    
    #Após finalizar compra-> Pagina Informação Adicional
    element :tituloInfoAdi, '.floatLeft.popupTitle.clearboth'
    element :btnCancelarInfAdi, '#dcCancel'
    element :dominio, 'domain'
    element :btnSalvarFecharInfoAdi, 'button[name="save"]'



    #Finalizar compra PTAX
    element :btnOkPtax, :xpath, '//tbody/tr[2]/td[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/button[1]'
    def pageHasvalidaPopPTAX
        '//tbody/tr[2]/td[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/button[1]'
    end

    #Após aprovar contrato-> Pagina Resumo da Compra
    element :tituloPagina, 'h2'
    element :dataAtivacaoProd, '#datepicker_orderLevel'
    element :btnSalvarPedido, '#saveBtn'
    element :textoProduto, '.orderDetailOfferName'
    element :textoPagamento, '.headingText.padding-10'
    element :seletorBoleto,'#billingMapBLT'
    element :valorTotalResumo, 'p.GrandtotalValue.floatRight'
    element :btnProsseguir, '#btnProceed'
    
    #Após Resumo da Compra--> Pagina Pedido Concluido
    element :textoProdutoConcl, 'p.orderRcptOfferName'
    element :valorTotalConcluido, '.GrandtotalValue'
    def pageHasValidaResumoTxt
        '//tbody/tr[2]/td[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/button[1]'
    end

    #Elemento no site Dealer CANVAS
    element :btnCriarProposta,'button#proceed.normal.marginRight-10'
    element :btnEnviarProposta,'#btnProceed.normal.floatLeft'
end