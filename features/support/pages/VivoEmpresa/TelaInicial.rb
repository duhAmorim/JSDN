class TelaInicial < SitePrism::Page
    element :logo, '#logo'
    element :btnCadastrar, '.tb-megamenu-item.level-1.mega.jsdn-register'
    element :btnCompareNuvens, '.tb-megamenu-item.level-1.mega.cloud_compare'
    element :btnCatalogo, '.tb-megamenu-item.level-1.mega'
    element :btnEntrar, '.tb-megamenu-item.level-1.mega.loginPopup'
    element :btnCarrinho, '.fa.fa-shopping-cart.fa-lg'

    #credenciais
    element :usuario, '#edit-name'
    element :senha, '#edit-pass'
    element :btnAcessarConta, '#edit-submit'
    
    #Credenciais admin-clone
    # element :usuario, '#username'
    # element :senha, '#password'
    # element :btnAcessarConta, '.sbButtonTextLinkHome'
end