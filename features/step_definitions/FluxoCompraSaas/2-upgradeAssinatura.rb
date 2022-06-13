ass = Assinaturas.new
car = Carrinho.new
ped = Pedidos.new

Então('escolher um produto Saas para realizar o upgrade com a quantidade desejada') do 
  read_config_yaml()
  #Seleciona a linha exata do produto necessário para realizar o click e as ações.
  ped.clicaColunaProduto(@nomeProduto )
  ass.btnVerDetalhes.click
  sleep 1
  ass.quantProd.double_click :backspace
  tirar_foto('fluxoUpgradeBtnQuantidade', 'passou')
  sleep 1
  ass.quantProd.set @quantidade
  sleep 1
  ass.btnAplicar.click
  tirar_foto('fluxoUpgradeBtnAplicar', 'passou')
  sleep 1
  ass.btnConfirmar.click
  tirar_foto('fluxoUpgradeBtnConfirmar', 'passou')
end

  Então('clicar no alerta') do
    validacao2 = ass.tituloAlerta
    expect(validacao2).to have_text("Alerta")
    ass.btnOK.click
  end

  Então('alterar a quantidade desejada do produto') do
      @quantidade
      car.quantidade.click
      tirar_foto('fluxoUpgradeBtnQuantidade1', 'passou')
      car.quantidade.double_click :backspace
      car.quantidade.click @quantidade
      tirar_foto('fluxoUpgradeBtnQuantidade2', 'passou')
      car.quantidade.send_keys :enter
  end
  
  Então('finalizar a compra') do
      car.btnFinalizarCompra.click
      tirar_foto('fluxoUpgradeBtnFinalizarCompra', 'passou')
      # BTN CONTINUAR NAVEGANDO DO POD-UP: "In-Progress hpfms analysis request is not available."
      if page.has_content? 'In-Progress hpfms analysis request is not available.'
        find(:xpath, '//body[1]/div[9]/div[1]/table[1]/tbody[1]/tr[2]/td[2]/div[2]/div[1]/div[3]/div[1]/div[1]/div[1]/div[1]/button[1]/span[1]').click
        car.btnFinalizarCompra.click
      end
      car.btnContinuarNavegando.click
  end