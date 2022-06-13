adm = LoginAdmin.new
inicio = TelaInicialAdmin.new

Então('validar o credito no ambiente admin') do
    novaPagina = open_new_window
    switch_to_window novaPagina
    read_config_yaml()
    visit('https://admin-clone.vivoplataformadigital.com.br')
    adm.usuario.set @usuarioAdmin
    adm.senha.set @senhaAdmin
    adm.btnEntrar.click
    inicio.menuAdministracao.click

    
    #Fraude
    inicio.fraude.click
    within_frame(:xpath,"//iframe[@id='iframe']") do
      click_on "Análise de Fraudes"
      # Status--> SELECIONADO: Em analise      
      find(:xpath, "//body/div[@id='__nuxt']/div[@id='__layout']/div[@id='app']/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[1]/div[1]/div[2]/div[2]/span[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/i[1]").click
      find(:xpath, "//div[contains(text(),'Em Análise')]").click    
      # Canal--> SELECIONADO: Online
      find(:xpath, "/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[1]/div[1]/div[4]/div[2]/span[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]").click
      find(:xpath, "//div[contains(text(),'Online')]").click
      puts @nomeCliente
      #Clientes--> SELECIONADO: @nome
      find('input[autocomplete="on"]').set @nomeCliente
      find('input[autocomplete="on"]').send_keys :enter
      click_on "Buscar"
      click_on "Ação"
      # Alert JS Primeiro
      accept_confirm 'Confirma aprovação manual?' do
        sleep 1
        click_on "Aprovar"
        sleep 1
      end
      # Alert JS Segundo
      accept_confirm 'Salvo com sucesso.'
    
    end
    
    #Credito
    inicio.credito.click
    within_frame(find(:xpath,"//iframe[@id='iframe']")) do
      click_on "Clientes"
      read_config_yaml()
      find(:xpath, "//body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/section[1]/div[1]/div[1]/span[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/i[1]").click
      find(:xpath, "//body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/section[1]/div[1]/div[1]/span[1]/div[1]/div[2]/div[1]/div[1]/div[1]/div[1]").click
      click_on "Buscar"
      find(:xpath, "//body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[1]/span[1]/div[1]/div[1]/div[1]/div[1]/input[1]").set @nomeCliente
      find(:xpath, "//body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/section[1]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[1]").click
      click_on "Alterar Limite"
      find(:xpath, "//body[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/section[1]/div[1]/section[1]/div[2]/form[1]/div[1]/span[1]/div[1]/div[1]/div[1]/div[1]/input[1]").set "100000"
      find(:xpath, "//body[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/section[1]/div[1]/section[1]/div[2]/form[1]/div[2]/span[1]/div[1]/div[1]/div[1]/div[1]/input[1]").set "30062022"
      click_on "Salvar"
    end

  end