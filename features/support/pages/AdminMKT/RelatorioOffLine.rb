class RelatorioOffiLine < SitePrism::Page
    element :stausGeracaoUltimoRelatorio,:xpath, "//tbody/tr[2]/td[10]/..//td[contains(text(),'Email enviado')]"
    element :btnDonwloadOffilineUltimoRelatorio,:xpath, '//tbody/tr[2]/td[12]/a[1]'
    element :idSolicitacao, :xpath, '//table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[2]/td[2]'
    element :nomeRelatorio, :xpath, '//table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[2]/td[4]'
end