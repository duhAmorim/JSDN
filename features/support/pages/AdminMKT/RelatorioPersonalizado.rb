class RelatorioPersonalizado < SitePrism::Page
    element :nomePersonalizado, 'input[name="customReportName"]'
    element :descPersonalizado, 'textarea[name="customReportDesc"]'
    element :datamart, 'select[name="dataMartName"]'
    element :selecionarTudo, '#selectAll'

    element :btnGerarRelatorio, 'button[name="generateReport"]'
end