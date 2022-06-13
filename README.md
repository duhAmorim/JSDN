# Testes Automatizados Plataforma Digital

- Tenha intalado o Ruby (versão 2.6 ou superior)

- Instale o chromedriver na mesma versão que a do seu navegador
    1-Baixar o ChromeDriver: https://chromedriver.chromium.org/downloads
    2-Olhar a versão do Chrome(Navegador): Clicar nos "3 pontos" localizado no canto superior direito do navegador. Clicar em "Ajuda" e Clicar em "Sobre o Google Chorme"

- ## Comando para configurar o projeto

### Instale a Gem TestGen
gem install testgen

### Instale a Gem Bundler
gem install bundler

### Rode a gem Bundler para baixar as dependencias do projeto
bundler

### Para executar o projeto rode o camando Cucumber -t + a tag da feature que deseja executar ou a ordem de features
cucumber -t@tag

###Fluxos com tags
Configuração:
@ValidacaoContasFinanceiras
@ConfigISV_PTAX
@GeracaoDescIncondicional_ISV
@GeracaoDesCondicional_ISV
@templates

Compra:
@criarCliente
@FluxoAltaCliente
@UpgradeAssinatura
@DowngradeAssinatura
@CancelamentoAssinatura
@FluxoAltaClienteDescCondicional
@UpgradeAssinaturaDescCondicional
@DowngradeAssinaturaDescCondicional
@CancelamentoAssinaturaDescCondicional
@FluxoAltaClienteCanvasAPI
@GeracaoDescontoCanvasAPI
@FluxoAltaCliente_PTAX
@UpgradeAssinatura_PTAX
@DowngradeAssinatura_PTAX
@CancelamentoAssinatura_PTAX
@ValidacaoFatura_PTAX
@ConfigISV_PTAX
@ValidacaoFaturaPTAX

Pré fechamento:
@tratamentoDCR

Avanço de ciclo:
*Manual

Pós fechamento:
@Billfeed
@billValida
@Fat77
@Fat78
@Fat79
@Fat80
@Fat55
@Fat56
@Fat57
@Fat58
@SoxContabil
@FaturamentoFat
@ServicosFaturados
@boletoRetificado
@GerarBoletoPago
@CreditoFuturo
@regua

Após o termino de cada automação/TAG será gerado um relatório personalizado no diretório: GW_QA_Automacao_Plataforma_Digital\relatorio

### Para executar variás tags dentro de um mesmo diretório em sequência: 
cucumber --require features features/FluxoCompraSaas

## Para validar o BillFeed e os FATs junto com o billfeed.
1 - Caso for rodar no seu computador (localhost) alterar o arquivo (configuracoesGlobaisTeste.yaml) as variáveis e diretorios referênte ao seu computador.
    Alterar duas variáveis-->
    (diretorioAutomacao) local onde a pasta da automação esta no seu computador
    (diretorioPastaDownloads) local onte o download e realizado

2 - Adicionar os FATs extraidos dentro do diretório: GW_QA_Automacao_Plataforma_Digital\features\step_definitions\FluxoValidacaoBillFeed\Relatorio

3 - Adicionar o arquivo de Billfeed no diretorio: GW_QA_Automacao_Plataforma_Digital\features\step_definitions\FluxoValidacaoBillFeed\Relatorio

4 - Após rodar a TAG (@Fat58) da automação, os Fats (@Fat55 e Fat56) adicionados no passo (2) serão movidos para o diretorio "Processado":
    GW_QA_Automacao_Plataforma_Digital\features\step_definitions\FluxoValidacaoBillFeed\Relatorio\Processados
    Caso queira validar novamente, esses arquivos devem ser movidos novamente para o diretório do passo (2)