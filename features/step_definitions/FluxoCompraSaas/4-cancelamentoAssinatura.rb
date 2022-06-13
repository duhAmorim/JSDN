ass = Assinaturas.new
ped = Pedidos.new
Então('escolher um produto Saas para realizar o cancelamento') do 
    read_config_yaml()
    @nomeProduto 
    ped.clicaColunaProduto(@nomeProduto)
    sleep 1
    ass.btnCancelarAss.click
    tirar_foto('fluxoCancelarBtnCancelar', 'passou')
    sleep 1
    ass.btnConfirmaCancela.click
    tirar_foto('fluxoCancelarBtnCOnfirmarCancelar', 'passou')
    sleep 2
  end