class JobgerarBillfeedPage < SitePrism::Page
    element :btnExecutar, '.sbButtonTextLink'
    element :status, :xpath,"//td[contains(text(),'Concluído')]"
    element :btnBaixarBifeel, ''
end