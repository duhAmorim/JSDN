
class CadastroUsuario < SitePrism::Page
    require "cpf_cnpj"

    element :cpf, '#cpfNumber'
    element :nome, '#firstName'
    element :sobrenome, '#lastName'
    element :email,'#email'
    element :telefone, '#contactPhone'

    element :cnpj, '#cnpjNumber'
    element :nomeEmpresa, '#companyName'
    element :inscricaoEstadual, '#stateRegister'

    element :rua, '#mailingAddress1'
    element :numero, '#mailingAddress2'
    element :complemento, '#mailingAddress3'
    element :bairro, '#mailingaddress4'
    element :telefoneEndereco, '#mailingPhone'
    element :pais, '#mailingcountry'
    element :estado, 'select[id="mailingState"]'
    element :cidade, '#mailingCity'
    element :cep, '#mailingZip'

    element :rua2, 'input[name="billingaddress1"]'
    element :numero2, 'input[name="billingaddress2"]'
    element :complemento2, 'input[name="billingaddress3"]'
    element :bairro2, 'input[name="billingaddress4"]'
    element :telefone2, 'input[name="companyRegistrationConfig.companyProfile.companyBillingAddress.phone"]'
    element :estado2, 'select[name="companyRegistrationConfig.companyProfile.companyBillingAddress.state.stateCode"]'
    element :cidade2, 'input[name="companyRegistrationConfig.companyProfile.companyBillingAddress.city"]'
    element :cep2, 'input[name="companyRegistrationConfig.companyProfile.companyBillingAddress.zipCode"]'


    element :flagManterDadosEnderecoCobranca, '#billingCheck'

    element :fuso, 'select[id="timeZone"]'
    element :flagEuConcordoComTermos, '#i_agree'

    element :btnCadastrar, '#btn_submit'
    element :btnCancelar, '#cancel'
    

    #frame senha
    element :senha, '#newPassword'
    element :confirmaSenha, '#confirmPassword'
    element :pergunta, 'select[id="securityQuestion"]'
    element :resposta, '#securityQueAns'
    element :btnSalvarFinalizar, '#setPwdSaveClose'
    def criarCPF
        
        novoCpf = CPF.generate
        return novoCpf
    end

    def criarCNPJ
        novoCNPJ = CNPJ.generate
        return novoCNPJ
    end
end