class GetNada < SitePrism::Page
    element :email, '.bg-red-800'
    element :mudarSenhaEmail, :xpath, '//a[contains(text(),"...")]'
    element :cliqueAqui, :link,'clique aqui.',match: :first
end