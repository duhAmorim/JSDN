
Dado('que ja possuo cadastro de uma empresa via API no ambiente Canvas') do
    read_config_yaml()

  fileHtml = File.new("Canvas.html", "w+")
  #CRIAÇÃO DO HTML DO ARQUIVO EM CANVAS
  fileHtml.puts "
  <html>
    <body>
        <form action='https://admin-#{@ambiente}.vivoplataformadigital.com.br/jsdn/savesfcanvasparams?isUnSignedRequest=true' method='post'>
            <!--form action='http://admin.vivoplataformadigital.com.br:8080/jsdn/savesfcanvasparams?isUnSignedRequest=true' method='post'-->
            <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Canvas Parameters :
            <br/><br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <textarea name='signed_request' id='signed_request' rows='35' cols='175'>
            </textarea> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <textarea name='signed_request_hidden' id='signed_request_hidden' style='display:none;' rows='35' cols='175'>{'client':{'refreshToken':null,'instanceId':'_:CanvasGlobalweb:1:1957;a:canvasapp','targetOrigin':'https://vivo--devgweb.my.salesforce.com','instanceUrl':'https://vivo--devgweb.my.salesforce.com','oauthToken':'00D560000002bjX!AQYAQC.EvX94GceSYISgOj60e3q2OJosIP_F892OwZQ0ydENh3dUT1lNc.WNgCij7Uub17Yp4uQIVIBtW2aUW2XZweheQI6C'},'issuedAt':-1364736570,'userId':'0051R00000HLRf4QAH','context':{'user':{'userId':'0051R00000HLRf4QAH','userName':'a0094244@telefonica.com.devgweb','firstName':'Julio','lastName':'Cesar Lima','email':'julio.clima@telefonica.com','fullName':'Julio Cesar Lima','locale':'pt_BR','language':'en_US','timeZone':'America/Sao_Paulo','profileId':'00e36000000n0QH','roleId':null,'userType':'STANDARD','currencyISOCode':'BRL','profilePhotoUrl':'https://vivo--devgweb--c.documentforce.com/profilephoto/005/F','profileThumbnailUrl':'https://vivo--devgweb--c.documentforce.com/profilephoto/005/T','siteUrl':null,'siteUrlPrefix':null,'networkId':null,'accessibilityModeEnabled':false,'isDefaultNetwork':true},'links':{'loginUrl':'https://vivo--devgweb.my.salesforce.com','enterpriseUrl':'/services/Soap/c/48.0/00D560000002bjX','metadataUrl':'/services/Soap/m/48.0/00D560000002bjX','partnerUrl':'/services/Soap/u/48.0/00D560000002bjX','restUrl':'/services/data/v48.0/','sobjectUrl':'/services/data/v48.0/sobjects/','searchUrl':'/services/data/v48.0/search/','queryUrl':'/services/data/v48.0/query/','recentItemsUrl':'/services/data/v48.0/recent/','chatterFeedsUrl':'/services/data/v31.0/chatter/feeds','chatterGroupsUrl':'/services/data/v48.0/chatter/groups','chatterUsersUrl':'/services/data/v48.0/chatter/users','chatterFeedItemsUrl':'/services/data/v31.0/chatter/feed-items','userUrl':'/0051R00000HLRf4QAH'},'application':{'name':'Canvas Globalweb','canvasUrl':'https://vivo-int-dev.vivoplataformadigital.com.br/sfdccanvastest','applicationId':'06P560000008lYb','version':'1.0','authType':'SIGNED_REQUEST','referenceId':'09H560000008lVH','options':[],'samlInitiationMethod':'None','namespace':'','isInstalledPersonalApp':false,'developerName':'CanvasGlobalweb'},'organization':{'organizationId':'00D560000002bjXEAQ','name':'Vivo','multicurrencyEnabled':false,'namespacePrefix':null,'currencyIsoCode':'BRL'},'environment':{'referer':null,'locationUrl':'https://vivo--devgweb.lightning.force.com/lightning/r/Opportunity/00656000008T0ORAA0/view','displayLocation':'Aura','sublocation':null,'uiTheme':'Theme3','dimensions':{'width':'100%','height':'100%','maxWidth':'1000px','maxHeight':'2000px','clientWidth':'1366px','clientHeight':'221px'},'parameters':{'IsReadOnly':true,'CurrentUserATM':false,'AccountExternalId':'09515489000109','OpportunityADABAS':'MPJ00657569','OpportunityOwnerID':'0051R00000HLHxHQAX','OpportunityOwnerName':'Felippe Vance Silva','OpportunityOwnerEmail':'felippe.silva@telefonica.com','OpportunityOwnerUsername':'a0091958@telefonica.com.devgweb','OpportunityOwnerLoginRede':'A0091958','OpportunityOwnerADABAS':'MPJ05041990','OpportunityId':'00656000008T0ORAA0','QuoteId':'0Q0560000005SfHCAU','QuoteExternalId':'0Q0560000005SfH'},'record':{},'version':{'season':'SPRING','api':'48.0'}}},'algorithm':'HMACSHA256'} </textarea>
            <br/><br/>
            <div style='width: 100%;text-align: center;'><button>Submit</button></div>
            <!--	?offerCode=office365bp&azurecsplinux_1011004.fromBuy=true&office365be.fromBuy=true 	-->
        </form>
    </body>
  </html>"
  fileHtml.close()
  
  visit('file:///C:\Users\mateu\Desktop\Vivo\GW_QA_Automacao_Plataforma_Digital-1\Canvas.html')

  @OpportunityOwnerID = Faker::Number.number(digits: 2).to_s
  @OpportunityId = Faker::Number.number(digits: 2).to_s
  @QuoteId = Faker::Number.number(digits: 2).to_s
  @body = 
      {
        "client_secret": "b1703d38-75d1-48a2-a533-f1306838d7d9",
        "client_id": "telefonica",
        "grant_type": "client_credentials",
        "scope": "organization.salesforce"
      }

  @headers =
      {
        'Content-Type': 'application/x-www-form-urlencoded'
      }

  @retornoPost = HTTParty.post(
    "https://vivo-int-#{@ambiente}.vivoplataformadigital.com.br/token/connect/token", 
    body: URI.encode_www_form(@body), 
    headers: @headers)
        
  @retornoPost.body
  expect(@retornoPost.code).to eq '200'.to_i
  @token = (@retornoPost.parsed_response['access_token']).to_s

  @current_year = Time.new.year.to_s
  @body2 ={
    "users": [
      {
        "profile":"Gestor de Contato",
        "phone":"11999999999",
        "lastname":"duh sfa",
        "isPrimaryAdmin":true,
        "firstname":"Apresentacao",
        "email":"#{@fluxoPresencialEmail}",
        "customInfo1":"#{@fluxoPresencialCPF}"
      }
    ],
    "team": [
   
    ],
    "organization": {
    "timezone":"JCP_TIMEZONE_00018",
    "phone":"1155555555",
    "languageCode":"pt_PT",
    "customInfo3":"ISENTO",
    "customInfo2":"#{@fluxoPresencialCNPJ}",
    "companyName":"#{@fluxoPresencialEmpresa}",
    "companyAcronym":"#{@fluxoPresencialCNPJ}23"
    },
    "creditAccount": {
    "potentialCreditLimit":15.0,
    "internalDebtFlag":"false",
    "initialCreditLimitAvailable":0.0,
    "idAnalysisRequest":"2071052",
    "externalRestrictionFlag":"false",
    "consumptionValueLegacy":15.0,
    "analysisStatus":"Informativo",
    "analysisDueDate":"#{@current_year}-12-30 23:59:59",
    "analysisDate":"#{@current_year}-12-30 10:55:18"
    },
    "classification": {
    "legalNature":"SOCIEDADE SIMPLES LIMITADA",
    "economicActivity":"OUTRAS ATIVIDADES DE SERVICOS PESSOAIS NAO ESPECIFICADAS ANTERIORMENTE",
    "customerSubSegment":"Top",
    "customerSegment":"Top",
    "csaCode":"TBRA",
    "companyType":"LTDA",
    "cnaeDivision":"OUTRAS ATIVIDADES DE SERVICOS PESSOAIS",
    "Cnae":"9609299"
    },
    "billingAddress": {
    "zip":"02225-001",
    "state":"SP",
    "district":"Jardim Brasil",
    "country":"BR",
    "city":"São Paulo",
    "address3":"Fundos",
    "address2":"769",
    "address1":"Crisciuma"
    },
    "address": {
    "zip":"02225-001",
    "state":"SP",
    "district":"Jardim Brasil",
    "country":"BR",
    "city":"São Paulo",
    "address3":"Fundos",
    "address2":"769",
    "address1":"Crisciuma"
    }
  }.to_json

  @headers2 =
  {
    "Content-Type" => "application/json",
    "Authorization" => "Bearer #{@token}" 

  }

  response = HTTParty.post("https://vivo-int-#{@ambiente}.vivoplataformadigital.com.br/ext-sfdc/api/Customer",body: @body2, headers: @headers2)
 
  puts response.code, response.body 
  #expect(response.code).should eq '201'.to_i

  jsonCanvas ='{
    "client": {
      "refreshToken": null,
      "instanceId": "_:CanvasGlobalweb:1:1957;a:canvasapp",
      "targetOrigin": "https://vivo--devgweb.my.salesforce.com",
      "instanceUrl": "https://vivo--devgweb.my.salesforce.com",
      "oauthToken": "00D560000002bjX!AQYAQC.EvX94GceSYISgOj60e3q2OJosIP_F892OwZQ0ydENh3dUT1lNc.WNgCij7Uub17Yp4uQIVIBtW2aUW2XZweheQI6C"
    },
    "issuedAt": -1364736570,
    "userId": "iduauriocanvas1224",
    "context": {
      "user": {
        "userId": "iduauriocanvas1225",
        "userName": "A0078625@telefonica.com.devgweb",
        "firstName": "Noele",
        "lastName": "Guerino",
        "email": "noele.guerino@telefonica.com",
        "fullName": "Noele Guerino",
        "locale": "pt_BR",
        "language": "en_US",
        "timeZone": "America/Sao_Paulo",
        "profileId": "00e36000000n0QH",
        "roleId": null,
        "userType": "STANDARD",
        "currencyISOCode": "BRL",
        "profilePhotoUrl": "https://vivo--devgweb--c.documentforce.com/profilephoto/005/F",
        "profileThumbnailUrl": "https://vivo--devgweb--c.documentforce.com/profilephoto/005/T",
        "siteUrl": null,
        "siteUrlPrefix": null,
        "networkId": null,
        "accessibilityModeEnabled": false,
        "isDefaultNetwork": true
      },
      "links": {
        "loginUrl": "https://vivo--devgweb.my.salesforce.com",
        "enterpriseUrl": "/services/Soap/c/48.0/00D560000002bjX",
        "metadataUrl": "/services/Soap/m/48.0/00D560000002bjX",
        "partnerUrl": "/services/Soap/u/48.0/00D560000002bjX",
        "restUrl": "/services/data/v48.0/",
        "sobjectUrl": "/services/data/v48.0/sobjects/",
        "searchUrl": "/services/data/v48.0/search/",
        "queryUrl": "/services/data/v48.0/query/",
        "recentItemsUrl": "/services/data/v48.0/recent/",
        "chatterFeedsUrl": "/services/data/v31.0/chatter/feeds",
        "chatterGroupsUrl": "/services/data/v48.0/chatter/groups",
        "chatterUsersUrl": "/services/data/v48.0/chatter/users",
        "chatterFeedItemsUrl": "/services/data/v31.0/chatter/feed-items",
        "userUrl": "/0051R00000HLRf4QAH"
      },
      "application": {
        "name": "Canvas Globalweb",
        "canvasUrl": "https://vivo-int-dev.vivoplataformadigital.com.br/sfdccanvastest",
        "applicationId": "06P560000008lYb",
        "version": "1.0",
        "authType": "SIGNED_REQUEST",
        "referenceId": "09H560000008lVH",
        "options": [],
        "samlInitiationMethod": "None",
        "namespace": "",
        "isInstalledPersonalApp": false,
        "developerName": "CanvasGlobalweb"
      },
      "organization": {
        "organizationId": "00D560000002bjXEAQ",
        "name": "Vivo",
        "multicurrencyEnabled": false,
        "namespacePrefix": null,
        "currencyIsoCode": "BRL"
      },
      "environment": {
        "referer": null,
        "locationUrl": "https://vivo--devgweb.lightning.force.com/lightning/r/Opportunity/00656000008T0ORAA0/view",
        "displayLocation": "Aura",
        "sublocation": null,
        "uiTheme": "Theme3",
        "dimensions": {
          "width": "100%",
          "height": "100%",
          "maxWidth": "1000px",
          "maxHeight": "2000px",
          "clientWidth": "1366px",
          "clientHeight": "221px"
        },
        "parameters": {
          "IsReadOnly": false,
          "CurrentUserATM": false,
          "AccountExternalId": "'+@fluxoPresencialCNPJ+'",
          "SalesLogin": "SalesLogin_Value",
          "SalesCode": "SalesCode_Value",
          "MarketPlace":"TBRA",
          "OpportunityADABAS": "80767979",
          "OpportunityOwnerID": "0'+@OpportunityOwnerID+'1D0pZ'+@OpportunityOwnerID+'6A86qQ'+@OpportunityOwnerID+'",
          "OpportunityOwnerName": "Jonicler Isaias Teixeira Saldanha Dos Passos",
          "OpportunityOwnerEmail": "jonicler.isaias.saldanha@everis.nttdata.com",
          "OpportunityOwnerUsername": "80767979@telefonica.com.uat",
          "OpportunityOwnerLoginRede": "80767979",
          "OpportunityOwnerADABAS": "80767979",
          "OpportunityId": "'+@OpportunityId+'O1D0'+@OpportunityId+'UpDDAkjQ'+@OpportunityId+'",
          "QuoteId": "0051R'+@QuoteId+'Z879HL3xHi'+@QuoteId+'",
          "OpportunityOwnerCPF": "84545512000123",
          "CurrentUserCPF": "38006122830"
          },
        "record": {},
        "version": {
          "season": "SPRING",
          "api": "48.0"
        }
      }
    },
    "algorithm": "HMACSHA256"
  }'
  find("#signed_request").set jsonCanvas
  tirar_foto('fluxoDescontoCanvasDados', 'passou')
  find('button').click
  end
  
  Então('concluir a compra de um produdo que ja possui um desconto') do
    pending # Write code here that turns the phrase above into concrete actions
  end
  