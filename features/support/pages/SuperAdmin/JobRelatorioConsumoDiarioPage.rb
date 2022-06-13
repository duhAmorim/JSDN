class JobRelatorioConsumoDiarioPage < SitePrism::Page
    element :btnExecutar, '.sbButtonTextLink'
    element :status, :xpath,"//td[contains(text(),'Concluído')]"
end