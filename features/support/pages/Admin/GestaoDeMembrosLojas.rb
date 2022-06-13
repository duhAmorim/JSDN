class GestaoDeMembrosLojas < SitePrism::Page
    #grid
    #Elemento em UAT #element :gridLojas, :xpath,  "//td[contains(text(),'VIVO PLATAFORMA DIGITAL')]/../td/a[contains(text(),'Loja')]"
    element :gridLojas, :xpath,  "//td[contains(text(),'Telefônica Brasil S.A')]/../td/a[contains(text(),'Loja')]"
    
    def funcGridLojas
        "//td[contains(text(),'Telefônica Brasil S.A')]/../td/a[contains(text(),'Loja')]"
         #Elemento em UAT  #"//td[contains(text(),'VIVO PLATAFORMA DIGITAL')]/../td/a[contains(text(),'Loja')]"
    end
    
    #PROXY LOJAS
    #Catalogo
    element :abaCatalogo, :xpath,'//a[contains(text(),"Catálogo")]'
    element :inputPesquisaCatalogo, '#searchValue'
    element :btnIR, :xpath,'//button[contains(text(),"Ir")]'
    element :btnEditar, :xpath,'//tbody/tr[2]/td[10]/a[2]/img[1]'
    element :dropDownFiltroPor, '#searchString'
    element :dropDrownNomeOferta, :xpath,'//option[contains(text(),"Nome da oferta")]' 
    #Configuração de Oferta
    element :inputValorPtax,:xpath, '//tbody/tr[3]/td[2]/input[1]'
    element :btnSalvar, '#save'
end