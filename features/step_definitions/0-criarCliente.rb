require 'faker'
require 'cpf_faker'

tl = TelaInicial.new
gn =GetNada.new
cad = CadastroUsuario.new
inicio = TelaInicial.new

Quando('clicar em Prosseguir no cadastro de usuario') do
    tl.btnCadastrar.click
    tirar_foto('criarClienteBtnCadastrar', 'passou')
  end
  
  Quando('realizar todas válidações para a criação de um novo usuario') do
    #Janela GetNada
    new_window = open_new_window
    switch_to_window new_window
    visit('https://getnada.com/')
    @email = gn.email.text().delete(' ')
    window = page.driver.browser.window_handles
    page.driver.browser.switch_to.window(window.first)
    sleep 5
    
    #variaveis criadas
    @cpf = Faker::CPF.number
    @cnpj = Faker::CNPJ.numeric
    @nome = Faker::Name.first_name 
    @sobrenome = Faker::Name.last_name
    @telefone = Faker::PhoneNumber.cell_phone_in_e164
    
    puts @email
    puts @nome
    puts @sobrenome

    #Janela VIVO
    #Primeiro Bloco DADOS DO USUÁRIO
    cad.cpf.set @cpf
    cad.nome.set @nome
    cad.sobrenome.set @sobrenome
    cad.email.set @email
    cad.telefone.set @telefone

    #Segundo Bloco EMPRESA
    cad.cnpj.set @cnpj
    cad.nomeEmpresa.set "#{@nome} LTDA"
    cad.inscricaoEstadual

    #Terceiro Bloco ENDEREÇO DA EMPRESA
    #Endereço de Correspondência
    cad.rua.set "Rua Numero1" 
    cad.numero.set 10
    cad.complemento.set "Casa"
    cad.bairro.set "BairroTeste"
    cad.telefoneEndereco.set 31991278565
    cad.estado.select "Minas Gerais"
    cad.cidade.set "BH"
    cad.cep.set "30350690"
    #Endereço de Cobrança
    cad.rua2.set "Rua Numero1" 
    cad.numero2.set 10
    cad.complemento2.set "Casa"
    cad.bairro2.set "BairroTeste"
    cad.telefone2.set 31991278565
    cad.estado2.select "Minas Gerais"
    cad.cidade2.set "BH"
    cad.cep2.set "30350690"
    cad.flagManterDadosEnderecoCobranca.check
    cad.fuso.select '(GMT-03:00) Brasilia'
    cad.flagEuConcordoComTermos.check
    cad.btnCadastrar.click
    tirar_foto('criarClienteBtnCadastrarFinal', 'passou')
   
    #Jenela GetNada
    janelas = windows
    switch_to_window janelas[1]
    sleep 10
    gn.mudarSenhaEmail.click
    tirar_foto('criarClienteMudarSenhaEmail', 'passou')
    within_frame(:xpath,('//iframe[@id="the_message_iframe"]')) do
        click_link'Clique aqui'
      end

    #Janela VIVO
    janelas = windows
    switch_to_window janelas[2]
    cad.senha.set '123456'
    cad.confirmaSenha.set '123456'
    cad.pergunta.select 'Qual é o nome de solteira da sua mãe?'
    cad.resposta.set 'Maria'
    cad.btnSalvarFinalizar.click
    tirar_foto('criarClienteBtnFinalizar', 'passou')
    sleep 2
    
    #window = page.current_window
    #window.close
  end
  
  Então('sistema deve exibir o usuário logado mostrando o nome do usuario criado na tela principal') do
    nameUp = @nome.upcase
    lastNameUp = @sobrenome.upcase
    expect(page).to have_text "#{nameUp} #{lastNameUp}"

    #Escreve no arquivo de variáveis globais com o email e o nome criado no getnada
    require 'yaml'
    config = YAML.load_file('configuracoesGlobaisTeste.yaml')
    puts config['usuarioEmail'] 
    config['usuarioEmail'] = "#{@email}"
    config['nomeCliente'] = "#{@nome}"
    File.open('configuracoesGlobaisTeste.yaml','w') do |usuario| 
    usuario.write config.to_yaml
  
    end
  end

