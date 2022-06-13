class LoginADMMKTPage < SitePrism::Page
    element :usuario, '#email'
    element :senha, '#password'
    element :btnEntrar, '#btn-login'
end