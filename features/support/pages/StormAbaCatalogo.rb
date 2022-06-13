class StormAbaCatalogo < SitePrism::Page
    element :valorPesquisa, '#searchValue'
    element :filtroPesquisa, 'select[name="searchString"]'
    element :btnPesquisar,  :xpath, "//button[contains(text(),'Ir')]"
    element :tituloCatalogo, '#spanTitle'

    #grid
    element :editarOferta, :xpath, '//tbody/tr[2]/td[10]/a[2]/img[1]'
    
end