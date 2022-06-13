class FiltroRelatorioFSW < SitePrism::Page
    element :filtroPersonalizado, '#radio-date-range'
    elements :datas, :xpath ,'//div[2]/input[1]'
    element :btnExecutrar,:xpath, '//button[contains(text(),"Executar")]'

end