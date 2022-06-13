tel=TelaInicialAdmin.new
require 'date'

Quando('capturar as informações do PTAX via API em uma determinada {string}') do |data|
  chamadaAPI = HTTParty.get("https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao='#{data}')")
  @valorPTAX = chamadaAPI['value'][0]['cotacaoVenda']
  puts"\nValor PTAX: #{@valorPTAX}\n Dia PTAX: #{data} \n"
end

Então('posso realizar as validações do {string} para um determinado {string} se o valor da {string} esta de acordo com os dias utilizados do {string}') do |cliente, ciclo, valorFatura, produto|
  tel.menuFaturamento.click
  tel.subMenuFatura.click
  tel.inputPesquisaFatura.set cliente
  tel.dropFiltrar.click
  tel.btnIR.click
  tel.clicaFaturaCliente(cliente).click
  tel.btnExpandir.click
  sleep 1
  
  #validacao nome fatura
  nomeNaFatura = tel.faturaCampoCliente.text
  expect(nomeNaFatura).to include("#{cliente}")
  
  #Valor Total FATURA LARANJA CABEÇALHO.
  #valorFatura = tel.faturaCampoValor.text.split("R$")
  #valorFaturaTratado = valorFatura.last.to_f

  #Captura preço do produto e realiza o tratamento (TIRA O R$ e converte para Float)
  @precoUnitario = tel.precoUnitario.text.split("R$")
  @precoUnitarioTratado = @precoUnitario.last.to_f
  puts "\nPreço unitário: #{@precoUnitarioTratado}"
  
  #Captura valor da data e realiza o tratamento  
  intervaloDataInicio = tel.intervaloData.text.split().first()
  inicial = Date.strptime(intervaloDataInicio,"%d/%m/%Y")
  puts "inicial #{inicial}"

  intervaloDataFim = tel.intervaloData.text.split().last()
  final = Date.strptime(intervaloDataFim , "%d/%m/%Y")
  
  inicial2 = Date.parse("#{inicial}") 
  final2 = Date.parse("#{final}")

  @intervalo = (final2.to_date - inicial2.to_date + 1).to_i
  puts "O intervalo e: #{@intervalo} dias"
  end
  
  Então('validar o valor do pro-rata e o valor do imposto tendo como base o valor da {string}') do |string|
  mes = tel.intervaloData.text.split().first().split("/")
  mes1 = mes.at(1)
  puts "Mês: #{mes1}"
  
  case mes1
  when mes1 == "01" || "03" || "05" || "07" || "08" || "10" || "12"
    mesDias = 31
  when mes1 == "02"
    mesDias = 28
  when mes1 == "04" || "06" || "09" || "11"
    mesDias = 30 
  end
  puts "Dias mês capturados: #{mesDias}"
  
  valorProRataSemPTAX = (@precoUnitarioTratado / mesDias) * @intervalo
  puts "Valor Pró-rata sem PTAX: #{valorProRataSemPTAX}"

  valorProRataComPTAX = ((@valorPTAX * @precoUnitarioTratado / mesDias) * @intervalo).to_f.round(2)
  puts "Valor Pró-rata com PTAX: #{valorProRataComPTAX}"
  
  #ASSERÇÃO
  #TODO alterar variavel com PTAX
  textoValorFaturaIten = tel.valorTotalItenFat.text.split("R$").last().to_f
  expect(valorProRataSemPTAX).to eq(textoValorFaturaIten)
  end
  