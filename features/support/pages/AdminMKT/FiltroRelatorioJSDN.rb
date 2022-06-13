class FiltroRelatorioJSDN < SitePrism::Page
    element :filtroPersonalizado, 'input[value="Custom"]'
    element :dataInicial, '#f_date_a'
    element :dataFinal, '#f_date_a1'
    element :modelo, 'select[name="reportResult"]'
    element :btnExecutrar, 'button[name="run"]'

end