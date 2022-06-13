class Catalogo < SitePrism::Page
    #familias
    element :microsoftOffice365,:link,'Microsoft Office 365',match: :first
    elements :familias, '.col-xs-5ths.col-sm-5ths.col-md-5ths.col-lg-5ths.serviceContainer'
    element :verOferta,:link,'Ver Ofertas',match: :first
    element :btSaas, '#ajax-facets-checkboxes-field-family-service-type-139'
    element :textoPesquisa, '#search_api_views_fulltext_catalog'
    element :btPesquisarProduto, '#applicationSearchButton'
    element :btnSetaCarousel, 'a.right.carousel-control', visible: :all
    
    #Funções
    def mouseHover(digitaNomeOferta2)
        find('span', text:"#{digitaNomeOferta2}").hover
    end
    
    def clickNomeOferta(nome)
        page.all("a[name='#{nome}']")[0].click
        #find("a[name='#{nome}']").click
    end

    def btnCarouselLateral
        'a.right.carousel-control'
    end
       
    def clickNomeOfertaCarousel(nome)
        "h2[data-offer-name='#{nome}']"
    end
    def clickNomeOfertaCarouselDealer(nome)
        first("a[data-offer-name='#{nome}']").click
    end

end