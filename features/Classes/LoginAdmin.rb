class LoginAdmin < SitePrism::Page
    
    def acessoAdminMKT
        pgAdminmkt = LoginADMMKTPage.new
        if current_url.include?('stg-isv')
            pgAdminmkt.usuario.set 'eduardo.amorim@globalweb.com.brstg'
            pgAdminmkt.senha.set 'Prod@2022'
            pgAdminmkt.btnEntrar.click
        elsif current_url.include?('stg')
             pgAdminmkt.usuario.set 'eduardo.amorim@globalweb.com.br'
             pgAdminmkt.senha.set 'Vivo@2021'
             pgAdminmkt.btnEntrar.click

        elsif current_url.include?('uat-billing')
                pgAdminmkt.usuario.set 'eduardo.amorim@globalweb.com.br'
                pgAdminmkt.senha.set 'Vivo@2021'
                pgAdminmkt.btnEntrar.click
        elsif current_url.include?('dev')
            pgAdminmkt.usuario.set 'eduardo.amorim@globalweb.com.br'
            pgAdminmkt.senha.set 'Vivo@2021'
            pgAdminmkt.btnEntrar.click
       

        end


    end
end