class ConfiguracaoAmbienteFakePage < SitePrism::Page
    element :menuConfigAmbienteFake, :link,'Configuração de ambiente',match: :first
    element :limpezaAmbienteJC, ''
    element :limpezaAmbienteFSW, '' 
    element :processamentoInterfaces, ''
    element :uploadArquivoUsoIaaS, ''
    element :jobRelatorioConsumoDiario, :link,'Job relatório de consumo diário',match: :first
    element :gerarInvoice, ''
    element :jobDatamartContestacao, ''
    element :gerarBillfeed, :link,'Gerer Billfeed',match: :first
    element :gerarPaymentFeed, ''
end