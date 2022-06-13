class Pedidos < SitePrism::Page
    element :status, :xpath, '//td[contains(text(),"Concluído")]'
    element :btnVerDetalhes, :xpath,'//a[contains(text(),"Ver Detalhes")]'
    element :btnAcoesImg, 'img.marginLeft-2'
    element :btnRefress, '.refreshTable'
    def clicaColunaProduto(produto)
        find('.dataRow', text: "#{produto}").find('img.marginLeft-2').click
    end
    
    def statusEmAndamento
         "//tbody/tr[contains(text(),'Em Andamento')]"
    end

    def statusConcluido
        first(:xpath, "//span[contains(text(),'Concluido')]")
    end

end

#first(:xpath, '//span[contains(text(),"Concluido")]')