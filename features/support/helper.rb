
module Helper
    
    def tirar_foto(nome_arquivo, resultado)
        caminho_arquivo = "reports/screenshot/"
        dataHora = DateTime.now.to_s
        dataHora.split(':')
        data = dataHora[0..12].to_s+dataHora[14..15].to_s+dataHora[17..21].to_s
        foto = "#{caminho_arquivo}#{data}#{nome_arquivo}-#{resultado}.png"
        temp_shot = page.save_screenshot(foto)
        shot = Base64.encode64(File.open(temp_shot, "rb").read)
        attach(shot, 'image/png')
    end

    # Método que carrega as informações do arquivo YAML. Caso altere os nomes do YAML ou adicione uma nova propriedade no YAML adicionar aqui dentro da função.
    def read_config_yaml
        require 'yaml'
        config = YAML.load(File.read('configuracoesGlobaisTeste.yaml'))
        @usuario = config['usuarioEmail']
        @senha = config['senha']
        @nomeOferta = config['nomeOferta']
        @nomeProduto = config['nomeProduto']
        @quantidade = config['quantidade']
        @nomeCliente = config['nomeCliente']
        @ambiente = config['ambiente']
        @usuarioAdmin = config['usuarioAdmin']
        @senhaAdmin = config['senhaAdmin']

        @usuarioFluxoPresencial = config['usuarioFluxoPresencial']
        @senhaFluxoPresencial = config['senhaFluxoPresencial']
        @fluxoPresencialCPF = config['fluxoPresencialCPF']
        @fluxoPresencialCNPJ = config['fluxoPresencialCNPJ']
        @fluxoPresencialEmail = config['fluxoPresencialEmail']
        @fluxoPresencialEmpresa = config['fluxoPresencialEmpresa']

        @usuarioPTAX = config['usuarioPTAX']
        @senhaPTAX = config ['senhaPTAX']   
        @valorPTAXDescontoUSD = config['valorPTAXDescontoUSD']
       
    end

end