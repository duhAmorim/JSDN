telaIni =TelaInicialAdmin.new
gestaoML = GestaoDeMembrosLojas.new
inicio = TelaInicial.new

Quando('clicar em Gestão de Membros') do
  telaIni.gestaoMembros.click
  tirar_foto('configIsvPtaxTelaInicialMenbros', 'passou')
  end
  
  Quando('clicar em Lojas') do
    telaIni.loja.click
    tirar_foto('configIsvPtaxTelaInicialLoja', 'passou')
  end
  
  Quando('clicar em VIVO PLATAFORMA DIGITAL na coluna Lojas') do
        if page.has_xpath? gestaoML.funcGridLojas, visible: true 
          gestaoML.gridLojas.click
          tirar_foto('configIsvPtaxGridLoja', 'passou')
        else 
          until page.has_xpath? gestaoML.funcGridLojas do
            telaIni.btnProximaPagina.click
            tirar_foto('configIsvPtaxBtnProximaPagina', 'passou')
            if   page.has_xpath? gestaoML.funcGridLojas
              break
            end
          end        
          gestaoML.gridLojas.click
          tirar_foto('configIsvPtaxGridLoja2', 'passou')
        end
  end
  
  Quando('clicar em Catálogo') do
    gestaoML.abaCatalogo.click
    tirar_foto('configIsvPtaxCatalogo', 'passou')
  end
  
  Então('posso pesquisar o nome do Servico') do 
    read_config_yaml()
    gestaoML.inputPesquisaCatalogo.set @nomeProduto
    gestaoML.dropDownFiltroPor.click
    gestaoML.dropDrownNomeOferta.click
    gestaoML.btnIR.click
    tirar_foto('configIsvPtaxBtnIr', 'passou')
    sleep 1
  end
  
  Então('clicar em Editar') do
    gestaoML.btnEditar.click
    tirar_foto('configIsvPtaxBtnEditar', 'passou')
  end
  
  Então('clicar editar o campo USD com o valor de varejo USD') do 
    read_config_yaml()
    gestaoML.inputValorPtax.double_click :backspace
    tirar_foto('configIsvPtaxInputValorPtax', 'passou')
    gestaoML.inputValorPtax.set @valorPTAXDescontoUSD
    tirar_foto('configIsvPtaxInputValorPtaxSet', 'passou')
    sleep 1
  end
  
  Então('clicar em Salvar') do
    gestaoML.btnSalvar.click
    tirar_foto('configIsvPtaxBtnSalvarPtaxFinal', 'passou')
  end
  