inicio = TelaInicial.new
cat = Catalogo.new

Quando('clicar em Entrar posso digitar minhas credenciais de acesso usuario e senha para cliente PTAX') do
      # Chama o metodo do yaml para o escopo do teste
      read_config_yaml()
      page.driver.browser.navigate.refresh
      sleep 3
      inicio.btnEntrar.click
      tirar_foto('fluxoAltaClienteBtnEntrar', 'passou')
      inicio.usuario.set @usuarioPTAX
      inicio.senha.set @senhaPTAX
      inicio.btnAcessarConta.click
end


Quando('escolher o produto e o tipo PTAX e clicar em Adicionar ao Carrinho') do 
  read_config_yaml
  cat = Catalogo.new
  #Contém elemento
  #Condicional se a pagina possui o botão "proximo" no carroussel de produtos
  if page.has_css? 'a.right.carousel-control', visible: true
    #Contém elemento
    until page.has_css? ("h2[data-offer-name='#{@nomeProduto}']"), visible: true do
        cat = Catalogo.new
        cat.btnSetaCarousel.click
        tirar_foto('fluxoAltaClientePtaxCarosel', 'passou')
          break if
            #Contém elemento 
            page.has_css? ("h2[data-offer-name='#{@nomeProduto}']")
      end
  else
      page.all("a[data-offer-name='#{@nomeProduto}']")[1].click
      tirar_foto('fluxoAltaClientePtaxOferta', 'passou')
  end
end

