class TesteVerbosAPI
    
    #classe de teste dos verbos de uma api
    @headers =
    {
        'Accept':         'application/vnd.tasksmanager.v2',
        'Content-Type': 'application/json'
    }
    def verboGet(idUsuario) 
        #o verbo get serve para consultar dados de uma api, como um select
        @chamadaAPI = HTTParty.get("https://api-de-tarefas.herokuapp.com/contacts/#{idUsuario}")
        return @chamadaAPI
    end

    def verboPost
        #o verbo post serve para inserir dados na api, como um insert
        #Para inserir dados precisamos passar o body da API (Corpo da chamada, que tem os dados que vão ser inseridos)
        #e precisamos passar o headers (cabeçalho da chamada da api)
        @email =  Faker::Internet.email #gera um email fake
        @body = 
        {
            "name": "Eduardo 450",
            "last_name": "Amorim 450",
            "email": "#{@email}",
            "age": "28",
            "phone": "21984759575",
            "address": "Rua dois",
            "state": "Minas Gerais",
            "city": "Belo Horizonte"
        }.to_json #converte a mensagem em json

        @headers =
        {
            'Accept':         'application/vnd.tasksmanager.v2',
            'Content-Type': 'application/json'
        }

        retornoPost = HTTParty.post("https://api-de-tarefas.herokuapp.com/contacts",body: @body, headers: @headers)
        
        return retornoPost
    end

    def verboPut(idUsuario)
        #o verbo PUT faz alterações nos dados do usuário, mas seu body deve conter todos os campos do contrato
        @email =  Faker::Internet.email
        @body =
        {
            "id": idUsuario,
            "name": "Eduardo",
            "last_name": "API",
            "email": "#{@email}",
            "age": "28",
            "phone": "21984759575",
            "address": "Rua dois",
            "state": "Minas Gerais",
            "city": "Belo Horizonte"
        }.to_json

        @headers =
    {
        'Accept':         'application/vnd.tasksmanager.v2',
        'Content-Type': 'application/json'
    }

        respostaPut = HTTParty.put("https://api-de-tarefas.herokuapp.com/contacts/#{idUsuario}",body: @body, headers: @headers)
        return respostaPut
    end

    def verboPatch(idUsuario)
        #o verbo Pacth faz alterações nos dados do usuário, mas seu body não precisa conter todos os campos do contrato
        @email =  Faker::Internet.email
        @body =
        {
            "id": idUsuario,
            "email": "#{@email}",
            "age": "24"
        }.to_json
        @headers =
    {
        'Accept':         'application/vnd.tasksmanager.v2',
        'Content-Type': 'application/json'
    }
        respostaPatch = HTTParty.put("https://api-de-tarefas.herokuapp.com/contacts/#{idUsuario}",body: @body, headers: @headers)
        return respostaPatch
        
    end

    def verboDelete(idUsuario)
        #o verbo Delete exclui os resgistros via API
        @headers =
    {
        'Accept':         'application/vnd.tasksmanager.v2',
        'Content-Type': 'application/json'
    }
    
        respostaDelete =  HTTParty.delete("https://api-de-tarefas.herokuapp.com/contacts/#{idUsuario}", headers: @headers)
        return respostaDelete
    end
    
end