class RelatorioOffiLine < SitePrism::Page
    element :stausGeracaoUltimoRelatorio,:xpath, "//tbody/tr[2]/td[10]/..//td[contains(text(),'Email enviado')]"
    element :btnDonwloadOffilineUltimoRelatorio,:xpath, '//tbody/tr[2]/td[12]/a[1]'
    element :idSolicitacao, :xpath, '//table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[2]/td[2]'
    element :nomeRelatorio, :xpath, '//table[1]/tbody[1]/tr[1]/td[1]/table[1]/tbody[1]/tr[2]/td[4]'
    
    #ALTERAR PARA CONTESTAÇÃO 
    element :relatorioReceitaContestacao, :xpath, '//tbody/tr[76]/td[8]/a[1]'

    # Sub-Menu Relatorio Receita Contestacao
    element :relatorioContestDataInicio, :xpath, "//body/div[@id='app']/section[1]/section[1]/div[1]/section[1]/div[1]/div[2]/div[1]/div[5]/div[2]/input[1]"
    element :relatorioContestDataFinal, :xpath, "//body/div[@id='app']/section[1]/section[1]/div[1]/section[1]/div[1]/div[2]/div[1]/div[6]/div[2]/input[1]"
end