class LoginAdmin < SitePrism::Page
    element :usuario, '#username'
    element :senha, '#password'
    element :btnEntrar, :xpath, "//button[contains(text(),'Entrar')]"
end