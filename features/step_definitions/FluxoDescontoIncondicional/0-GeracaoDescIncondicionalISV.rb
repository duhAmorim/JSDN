acesso = Ambientes.new
logAdmin = LoginAdmin.new
telaIni =TelaInicialAdmin.new

Dado('que acessei a página da Vivo Administrativo') do
    #CHAMA A FUNÇÃO PARA ACESSAR O SITE ADMINISTRATIVO
    acesso.admin 
    tirar_foto('GeracaoDescIncondicionalLoadPagina', 'passou')
  end
    
  Quando('visualizar a pagina principal') do 
    page.switch_to_window page.windows.first
    telaIni.menuAdministracao.click
    tirar_foto('GeracaoDescIncondicionalMenuAdm', 'passou')
  end
  
  Quando('clicar no menu Administração') do 
    page.switch_to_window page.windows.first
    telaIni.menuAdministracao.click
    tirar_foto('GeracaoDescIncondicionalMenuAdministracao', 'passou')
  end

  Quando('clicar em Gerenciamento de Serviços') do 
    telaIni.gerenciamentoDeServicos.click
    tirar_foto('GeracaoDescIncondicionalTelaInicialGemServicos', 'passou')
  end
  
  Quando('clicar em Cadastrar desconto GN\/Dealer') do
    telaIni.cadastrarDescontoDealer.click
    tirar_foto('GeracaoDescIncondicionalCadastrarDescDealer', 'passou')
  end

  Quando ('clicar no botão novo') do
    telaIni.btnNovo.click
    tirar_foto('GeracaoDescIncondicionalBtnNovo', 'passou')    
  end

  Então('posso selecionar o nome da loja {string} o Servico {string} e realizar a a geracao de desconto incondicional nos campos de segmento {string}  o valor {string} a porcentagem {string} o valor PTAX {string} a porcentagem PTAX {string} e validar o nome do produto {string}') do |nomeLoja, numeroServico, numeroSegmento, valor, porcentagem, valorPtax, porcentagemPtax, nomeProdutoValidacao|
    telaIni.selecionarLoja.click
    find("[value='#{nomeLoja}']").click
    telaIni.selecionarServico.click
    find("[value='#{numeroServico}']").click
    telaIni.segmento.click
    tirar_foto('GeracaoDescIncondicionalSegmento', 'passou')
    find("[value='#{numeroSegmento}']").click
    telaIni.valor.set valor
    telaIni.porcentagem.set porcentagem
    telaIni.valorPtax.set valorPtax
    telaIni.porcentagemPtax.set porcentagemPtax
    tirar_foto('GeracaoDescIncondicionalPorcentagemPtax', 'passou')
    telaIni.btnInserir.click
    tirar_foto('GeracaoDescIncondicionalBtnInserir', 'passou')
    #PAGINA COM IFRAME
    within_frame(:xpath,("//tbody/tr[2]/td[1]/div[1]/div[1]/div[2]/iframe[1]")) do
      click_button 'OK'
    end
    have_css ".sbListText[title='#{nomeProdutoValidacao}']", visible: true
    sleep 3
  end