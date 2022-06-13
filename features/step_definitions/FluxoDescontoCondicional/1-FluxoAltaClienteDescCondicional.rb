car = Carrinho.new
Quando('adicionar o cupom de desconto condicional cadastrado') do
  read_config_yaml()
  car.campoCodigoDesconto.click
  car.campoCodigoDesconto.set @nomeCliente
  car.btnAplicar.click
end