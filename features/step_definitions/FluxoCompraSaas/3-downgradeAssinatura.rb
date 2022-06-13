require 'timeout'
menu = HomeLoja.new
ass = Assinaturas.new
ped =Pedidos.new

Quando('clicar no botão Gerenciar sub-menu Assinatura') do
    menu.gerenciar.click
    sleep 3
    menu.assinaturas.click
    sleep 3
  end
  
  Então('escolher um produto Saas para realizar o downgrade com a quantidade desejada') do 
    read_config_yaml()
    @nomeProduto
    #Clica em AÇÕES do respectivo produto
    ped.clicaColunaProduto(@nomeProduto)
    ass.btnVerDetalhes.click
    tirar_foto('fluxoDownGradeBtnVerdetalhes', 'passou')
    sleep 1
    ass.quantProd.double_click :backspace
    tirar_foto('fluxoDownGradeBtnQuantidade', 'passou')
    sleep 1
    ass.quantProd.set "-#{@quantidade}"
    sleep 1
    ass.btnAplicar.click
    tirar_foto('fluxoDownGradeBtnAplicar', 'passou')
    sleep 1
    ass.btnConfirmar.click
    tirar_foto('fluxoDownGradeBtnConfirmar', 'passou')
  end
  
  Então('e escolher o pedido com a quantidade') do 
    read_config_yaml()
    ass.quantProd.double_click :backspace
    ass.quantRed2.set @quantidade
    ass.btnSalvar.click
    tirar_foto('fluxoDownGradeBtnSalvar', 'passou')
    sleep 1
  end
  
  Então('clicar em Gerenciar pedidos') do
    menu.gerenciar.click
    tirar_foto('fluxoDownGradeMenuGerenciar', 'passou')
    sleep 1
    menu.pedidos.click
    tirar_foto('fluxoDownGradeMenuPedidos', 'passou')
    sleep 1
  end
  
  Então('verificar o status com um loop até status concluido') do 
    if page.has_xpath?('//span[contains(text(),"Em Andamento")]')
      Timeout.timeout(120) do  
        until page.has_xpath? ('//span[contains(text(),"Concluido")]')
            ped.btnRefress.click 
            break if
            #Contém elemento 
            page.has_xpath? ('//span[contains(text(),"Concluido")]')
        end
      end 
    end
  end