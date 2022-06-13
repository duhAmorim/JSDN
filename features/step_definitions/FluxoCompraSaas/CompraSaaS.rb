limiteCredito = 0
Dado("que tenha acessado a plataforma com usuário {string} senha {string}") do |string, string2|
    acesso = Ambientes.new
    acesso.load

    inicio = TelaInicial.new
    inicio.btnEntrar.click
    
    inicio.usuario.set string
    inicio.senha.set string2
    inicio.btnAcessarConta.click

  end
  
  Dado("capturar o saldo de limite de crédito") do
    hj = HomeLoja.new
    
    limiteCredito = hj.saldoCredito.value
    puts ('Limite de crédito '+ limiteCredito)
    tirar_foto('limiteDeCredito', 'passou')
  end

  Dado("tenha adicionado ao carrinho uma oferta SaaS") do
    hj = HomeLoja.new
    hj.catalogo.click
    
    cat = Catalogo.new
    cat.btSaas.click
    cat.textoPesquisa.set 'microsoft office 365'
    cat.btPesquisarProduto.click
    cat.familias[0].hover
    sleep 2
    cat.verOferta.click

    mo365 = MicrosoftOffice365.new
    mo365.addCarrinhoMicrosostCloud.click

  end
  
  Quando("clicar em Finalizar Compra no Carrinho") do
    
    car = Carrinho.new
    car.btnFinalizarCompra.click
    sleep 15
    car.btnContinuarCredito[2].click
    #confirmar contrato
    sleep 10
    car.btnContinuarCredito[2].click
    sleep 5
    nomeDinamico = Faker::Alphanumeric.alphanumeric(number: 10)
    car.dominio.set nomeDinamico
    car.btnContinuarCredito[3].click
    #espera carregar se o e-mail na microsoft pode ser criado
    car.wait_until_validaCredencial_invisible
    
  end
  
  Quando("Confirmar compra com meio de pagamento selecionado") do
    
    car = Carrinho.new
    car.pgBoleto.click
    sleep 3
    car.prosseguir.click
    sleep 5
  end
  
  Então("sistema deve adicionar assinatura de SaaS as assinaturas do cliente") do
    car = Carrinho.new
    menu = HomeLoja.new
    menu.gerenciar.click
    sleep 3
    menu.assinaturas.click
    sleep 3
    tirar_foto('assinaturas', 'passou')
  end

  Então("deve atualizar o valor do saldo do limite de crédito") do
    
        hj = HomeLoja.new
        limiteCredito = hj.saldoCredito.value
        puts ('Novo limite de crédito '+ limiteCredito)
        tirar_foto('NovoLimiteDeCredito', 'passou')
  end