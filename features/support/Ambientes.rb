class Ambientes < SitePrism::Page
    #TODO REDUNDANCIA DE CÓDIGO. ESSE CODIGO TB ESTA DENTRO DA FUNÇÃO "ADMIN" linha 15
    require 'yaml'
    config = YAML.load_file('configuracoesGlobaisTeste.yaml')
    @ambiente = config['ambiente']  

    #CONDICIONAL PARA O TIPO DO AMBIENTE LOJA: cloudco e DEMAIS... dev, uat, uatbilling e stg, admin-clone
    if @ambiente == 'cloudcostg'
      @lojaCloudCo = "https://#{@ambiente}.vivoplataformadigital.com.br/"
      set_url @lojaCloudCo
    elsif @ambiente == 'admin-clone'
      @lojaAdminClone ='https://clone.vivoplataformadigital.com.br/cms/pt'
      set_url @lojaAdminClone
    else
      @loja = "https://rsl-#{@ambiente}.vivoplataformadigital.com.br/"
      set_url @loja  
    end

    canvasLocal = "file:///C:\Users\mateu\Desktop\Vivo\GW_QA_Automacao_Plataforma_Digital-1/canvasFluxoDealler.html"
   
    #FUNÇÃO EXCLUSIVA PARA MUDANÇA DE URL PARA ADMIN
    def admin
      require 'yaml'
      config = YAML.load_file('configuracoesGlobaisTeste.yaml')
      @ambiente = config['ambiente']  
      #CONDICIONAL PARA O TIPO DO AMBIENTE ADMIN: CLOUDCO e DEMAIS... DEV, UAT, UATBILLING e STG
      if @ambiente =='cloudcostg'
        @ambiente ='stg'
        visit("https://admin-clone.vivoplataformadigital.com.br")
      else
        visit("https://admin-clone.vivoplataformadigital.com.br")
      end
    end

   puts "Site acessado com sucesso #{@ambiente}, #{@loja}" 
 end