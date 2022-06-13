acesso = Ambientes.new
inicio = TelaInicial.new
cat = Catalogo.new
car = Carrinho.new
ped = Pedidos.new
menu = HomeLoja.new
adm = LoginAdmin.new
admInic = TelaInicialAdmin.new

# Leitura de YAML
varGlobal = YAML.load(File.read('./configuracoesGlobaisTeste.yaml'))
@nomeOferta = varGlobal["nomeOferta"]
@nomeProduto = varGlobal["nomeProduto"]

Dado('que acessei a página da Vivo') do
    acesso.load
  end
  
  Quando('clicar em Entrar posso digitar minhas credenciais de acesso usuario e senha') do 
    # Chama o metodo do yaml para o escopo do teste
    read_config_yaml()
    page.driver.browser.navigate.refresh
    sleep 3
    inicio.btnEntrar.click
    tirar_foto('fluxoAltaClienteBtnEntrar', 'passou')
    inicio.usuario.set @usuario
    inicio.senha.set @senha
    inicio.btnAcessarConta.click
  end

  Quando ('clicar no botão Catálogo') do 
    menu.menuCatalogo.click
    tirar_foto('fluxoAltaClienteBtnCatalogo', 'passou')
  end

  Quando('escolher um produto Saas digitar nome Oferta') do 
    read_config_yaml()
    cat.textoPesquisa.set @nomeOferta 
    #cat.btPesquisarProduto.click
    puts @nomeOferta
    cat.textoPesquisa.set @nomeOferta 
    cat.textoPesquisa.send_keys :enter
    cat.mouseHover(@nomeOferta)
    cat.verOferta.click
    tirar_foto('fluxoAltaClienteBtnOferta', 'passou')
  end
  
  Quando('escolher o produto e clicar em Adicionar ao Carrinho') do 
      cat.clickNomeOferta(@nomeProduto)
  end

  Quando('alterar o campo Quantidade no Carrinho') do 
    if page.has_css? 'input.center.marginTop-5'
      car.quantidade.click
      car.quantidade.double_click :backspace
      car.quantidade.click @quantidade
      sleep 3
      car.quantidade.send_keys :enter
      sleep 3
    end
  end

  Quando('se o valor total for igual ao valor esperado') do 
    # Captura do campo "preço unitário" no carrinho. Tratamento do campo string para float, validação calculo do preço total da compra
    preco = car.validaPrecoUnitario.text.split('R$').last().to_s.gsub(",",".").to_f.round(2)
    @valorTotal = preco.to_f.round(2) * @quantidade.to_f.round(2)
    @valorTotal = @valorTotal.to_f.round(2)
    @valorTotal = @valorTotal.to_s.gsub(".",",")
    puts "R$#{@valorTotal}"
    validacao1 = car.valorTotalGeral
    expect(validacao1).to have_text("R$#{@valorTotal}")
   end
 
  Então('posso finalizar a compra') do
    car.btnFinalizarCompra.click

  end

  Então('aceitar o fluxo de fraude') do
    novaPagina = open_new_window
    switch_to_window novaPagina
    read_config_yaml()
    visit('https://admin-stg.vivoplataformadigital.com.br/')
    adm.usuario.set @usuarioAdmin
    adm.senha.set @senhaAdmin
    adm.btnEntrar.click
    admInic.menuAdministracao.click
    admInic.fraude.click
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
  end

  Então('fazer logout e login e continuar a finalizacao de compra do produto') do
    
    primeiraPagina=page.driver.browser.window_handles.first
    page.driver.browser.switch_to.window(primeiraPagina)
    sleep 1
    # Refresh da página
    page.driver.browser.navigate.refresh
    sleep 1
    car.btnFinalizarCompra.click

    if page.has_xpath? (car.btnContinuarNavegandoFunc)
      car.btnContinuarNavegando.click
    end
   
    page.driver.browser.navigate.refresh

    # Faz log-out e entra no carrinho novamente
    #first("div#profileLogoutMenu").click
    find(:xpath, '//body/div[4]/div[1]/div[1]/nav[1]/div[1]/div[1]/div[1]/div[1]/div[1]/a[1]/div[1]').click
    inicio.btnEntrar.click
    tirar_foto('fluxoAltaClienteEntrarNovamente', 'passou')
    inicio.usuario.set @usuario
    inicio.senha.set @senha
    inicio.btnAcessarConta.click
    tirar_foto('fluxoAltaClienteBtnAcessarContaNovamente', 'passou')
    menu.meuCarrinho.click
    tirar_foto('fluxoAltaClienteMenuCarrinhoClick', 'passou')
    sleep 1
    car.btnFinalizarCompra.click
    tirar_foto('fluxoAltaClienteBtnFinalizarCompraNovamente', 'passou')
    sleep 1
    tirar_foto('fluxoAltaClienteBtnAprovar', 'passou')
  end

  Então('finalizar a compra concordando com o contrato de servicos') do
    new_window = open_new_window
    switch_to_window new_window
    visit('https://clone.vivoplataformadigital.com.br/')
    find(:xpath,"//*[@id='profileLogoutMenu']/a").click
    find(:xpath, "//a[contains(text(),'Entrar')]").click
    read_config_yaml()
    inicio.usuario.set @usuario
    inicio.senha.set @senha
    inicio.btnAcessarConta.click
    menu.meuCarrinho.click
    car.btnFinalizarCompra.click
    sleep 2
    
    car.btnConcordoTudo.click

  
  end

  Então('na pagina RESUMO validar o nome do produto') do 
    car.prosseguir.click
  end

  Então ('verificar a compra realizada na tela PEDIDO CONCLUIDO com os campos nome do Produto e valor Boleto') do 
    # Validar na tela de pedido concluido a data da ativação e o valor do boleto.
    texto3 = car.textoProdutoConcl
    expect(texto3).to have_text("#{@nomeProduto}")
    puts "Validação nome produto: #{@nomeProduto}"
    # Valida o valor do boleto
    texto4 = car.valorTotalConcluido
    expect(texto4).to have_text("#{@valorTotal}")
    puts "Validação valor total: #{@valorTotal}"
  end

  Então ('na tela PEDIDOS verificar o status concluido') do
    menu.gerenciar.click
    menu.pedidos.click
    puts "Pedido Concluido"
    tirar_foto('fluxoAltaClientePedidoConcluido', 'passou')
    #Validação da ultima data de pedido
    require 'date'
    data = DateTime.now
    @dataformat = data.strftime ("%d/%m/%Y")
    
    puts @dataformat
    
    def funcaoIf
      find(".dataRow", text: "Em andamento") 
    end
    
    page.should have_content("Pedidos")
      
    if  funcaoIf() == true 
      puts "IF FINAl acessado"
      until page.has_no_css? funcaoIf()
        puts "Until final Acessado"
        ped.btnRefress.click 
        puts "BTN CLICADO"
      end

      stat = find_all('.dataRow', text: "#{@dataformat}").find(ped.statusConcluido)
      expect(stat).to have_text("Concluido")
      puts "Expect final executado"
    end

    # if page.has_xpath? ped.statusEmAndamento
    #   puts "IF FINAl acessado"
    #   until page.has_xpath? !ped.statusEmAndamento
    #     puts "Until final Acessado"
    #     ped.btnRefress.click 
    #     puts "BTN CLICADO"
    #     #  break if
    #     #  find_all('.dataRow', text: "#{@dataformat}").find(:xpath,"//span[contains(text(),'Concluido')]")
    #   end
    #       stat = find_all('.dataRow', text: "#{@dataformat}").find(ped.statusConcluido)
    #       expect(stat).to have_text("Concluido")
    #       puts "Expect final executado"
    #     #page.has_xpath? ped.statusConcluido
    # end

  end