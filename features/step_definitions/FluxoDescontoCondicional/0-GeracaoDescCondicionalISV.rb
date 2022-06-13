adm = LoginAdmin.new
admInic = TelaInicialAdmin.new

Dado('digitei minhas credenciais administrativo usuario e senha') do 
    read_config_yaml() 
    adm.usuario.set @usuarioAdmin
    adm.senha.set @senhaAdmin
    adm.btnEntrar.click
  end
  
  Quando('clicar em Descontos condicionais') do
    admInic.descCondicionais.click
  end
  
  Então('posso Cadastrar um novo cupon de desconto condicional') do
    within_frame(:xpath,"//iframe[@id='iframe']") do
      read_config_yaml()
      click_on "Desconto padrão"
      find('span.v-btn__content', text: 'Novo', visible:true, match: :first).click
      find('.v-icon.notranslate').click
      find('.v-list-item__title', text: 'Telefônica Brasil S.A', visible:true, match: :first).click
      find('.button.button.button.v-btn', text: 'Buscar', visible:true, match: :first).click
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[1]/div[1]/section[1]/span[2]/div[1]/div[1]/div[1]/div[1]/input[1]').set @nomeCliente
      find(:xpath,'/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[2]/div[1]/section[1]/span[2]/div[1]/div[1]/div[1]/div[1]/input[1]').click
      find('.v-list-item__title', text: 'IAAS', match: :first).click
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[3]/div[1]/section[1]/span[2]/div[1]/div[1]/div[1]/div[1]/input[1]').click
      find('.v-list-item__title', text: 'IaaS', match: :first).click
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[4]/div[1]/section[1]/span[2]/div[1]/div[1]/div[1]/div[1]/input[1]').set @nomeProduto
      find('.v-list-item__title', text: "#{@nomeProduto}", match: :first).click
      #find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[8]/div[1]/div[2]/div[1]/section[1]/span[2]/div[1]/div[1]/div[1]/div[1]/input[1]').set'1'
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[6]/div[2]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]').click
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[8]/div[1]/div[2]/div[1]/section[2]/span[2]/div[1]/div[1]/div[1]/div[1]/input[1]').set '1'
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[10]/div[1]/div[1]/div[1]/section[1]/span[2]/div[1]/div[1]/div[1]/div[1]/input[1]').set '2'
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[10]/div[1]/div[1]/div[2]/section[1]/span[2]/div[1]/div[1]/div[1]/div[1]/div[1]').click
      find('.v-list-item__title', text: 'Dia(s)', match: :first).click
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[13]/div[1]/div[1]/div[2]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/input[1]').set @nomeCliente
      find(:xpath, '/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/main[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/form[1]/div[13]/div[1]/div[1]/div[2]/section[1]/div[1]/div[1]/div[1]/div[1]/div[1]/input[1]').click :enter
      find('span.v-btn__content', text: 'Salvar', visible:true, match: :first).click
    end
    # Alert de confirmação
    accept_confirm 'Salvo com sucesso!' #do
      # sleep 1
      # click_on "OK"
      # sleep 1
    #end 
  end