class HomeLoja < SitePrism::Page
    #Menu superior
    element :meusProdutos,:link,'Meus Produtos',match: :first
    element :painelControle,:link,'Painel de Controle',match: :first
    element :catalogo,:link,'Catálogo',match: :first
    element :gerenciar,:link,'Gerenciar',match: :first
    element :relatorios,:link,'Relatórios',match: :first
    element :saldoCredito, '#walletBalance'
    element :menuCatalogo, :link,'Catálogo'
    element :btnSair, 'div#profileLogoutMenu'
    element :meuCarrinho, '.second'
    

    #menu Gerenciar
    element :assinaturas,:link,'Assinaturas',match: :first
    element :pedidos,:link,'Pedidos',match: :first
end