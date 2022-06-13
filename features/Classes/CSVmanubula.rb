require "csv"
require "fileutils"
require 'roo'
require  'date'
class CSVmanubula

    def movimentarArquivo(arquivo)
        pastaOrigem = "C:/Users/mateu/Downloads/"
        pastaDestino = "C:/Users/mateu/Desktop/Vivo/backup/master/GW_QA_Automacao_Plataforma_Digital"
        
        FileUtils.move pastaOrigem+arquivo, pastaDestino

    end


    def limpezaDCR((nomeArquivo))
        #leitura do CSV
        table_desc = CSV.table((nomeArquivo), col_sep: ",",headers:true,skip_blanks: true, converters: [])
        #separa o header
        headerDCR = table_desc[2]
        utimalinha = table_desc.count
        utimalinha = utimalinha -2
        #limpa a tabela das linhas de periodo e da última linha 
        dcrSemLinhasFiltros = table_desc[3..utimalinha]
        #cria um novo CSV com Filtros
        CSV.open("DCRAutomacao-edit.csv", 'wb') do |dcr|
            dcr << headerDCR
            dcrSemLinhasFiltros.length.times do |i|
                dcr << dcrSemLinhasFiltros[i]
                end 
            
        end
        #le o novo csv sem as linhas de filtros
        dcrComIaaS = CSV.table("DCRAutomacao-edit.csv",col_sep: ",",headers:true,skip_blanks: true, converters: [])
        #pega os customer code com IaaS de
        customerCode = []

        dcrComIaaS.each { |row| 
            if(row[:tipo_de_servio_em_nuvem].eql? 'IAAS')
                customerCode.push(row[:cdigo_do_cliente])
                
                end           
        }
       #limpa a tabela de linhas de IaaS
        indice = 0
        while indice < customerCode.length
            dcrComIaaS.delete_if do |row|
                 row[:cdigo_do_cliente].eql? customerCode[indice]
             end 
             indice = indice + 1
        end
          #cria o CSV do DCR sem as linha de IaaS
        CSV.open("DCRAutomacaoSemIaaS-edit.csv","wb") do |csv_out|
            
            csv_out << headerDCR
            dcrComIaaS.each{ |row| csv_out << row }
        end
     end

     def limparBilfeedIaaS((nomeArquivo))
        #le o csv do billfeed e limpar as linhas de IaaS
        billComIaaS = CSV.table((nomeArquivo),col_sep: ",",headers:true,skip_blanks: true, converters: [])
        headerBill = CSV.open((nomeArquivo), 'r') { |csv| csv.first }

        customerCode = []

        billComIaaS.each { |row| 
            if(row[:service_type].eql? 'IAAS')
                customerCode.push(row[:customer_code])
                
                end           
        }
       #limpa a tabela de linhas de IaaS
        indice = 0
        while indice < customerCode.length
            billComIaaS.delete_if do |row|
                 row[:customer_code].eql? customerCode[indice]
             end 
             indice = indice + 1
        end
          #cria o CSV do DCR sem as linha de IaaS
        CSV.open("billfeedSemIaaS-edit.csv","wb") do |csv_out|
            csv_out << headerBill
            billComIaaS.each{ |row| csv_out << row }
        end
     end

     def validarBillComDCR()
        bill = CSV.table('billfeedSemIaaS-edit.csv',col_sep: ",",headers:true,skip_blanks: true, converters: [])
        dcr = CSV.table('DCRAutomacaoSemIaaS-edit.csv',col_sep: ",",headers:true,skip_blanks: true, converters: [])
        pedidosForaDoBill = []
        pedidosNoBill = []


        #colunas da billfeed para validar
        activityTypeBill = ':activity_type'
        serviceTypeBill = ':service_type'
        orderIdBill = ':order_id'
        dataCriacaoPedidoBill = ':order_creation_date'
        supscriptionTypeBill = ':subscription_type'
        billFromBill = ':bill_from'
        billToBill = ':bill_to'
        billingStateBill = ':billing_state_province'
        serviceNameBill = ':service_name'
        qtyBill = ':qty'
        retailUnitPriceBill = ':retail_unit_price'
        taxOnRetailPriceBill = ':tax_on_total_retail_price'
        grandTotalRetailPriceBill = ':grand_total_retail_price'
        billingCycleBill = ':billing_cycle'
        usageAttributesBill = ':usage_attributes'
        paymentMethodBill = ':payment_method'
        invoiceNumberBill = ':invoice_number'
        serviceCodeBill = ':service_code'
        dueDateBill = ':due_date'
        totalInvoicePriceBill = 'total_invoice_price'
        cycleCodeBill = ':cycle_code'
        totalIssBill = ':total_taxiss'
        totalCofinsBill = ':total_taxcofins'
        totalPisBill = ':total_taxpis'
        recevableBill  = ':receivable'
        storeAcronymBill = ':store_acronym'
        totalRetailPriceWithTaxesWithoutDiscountBill = ':total_retail_price_with_taxes_without_discount'

        #colunas DCR
        dataFinalCicloDCR = ':data_final_do_ciclo_de_faturamento'
        dataInicialCicloDCR = ':data_inicial_do_ciclo_de_faturamento'
        quantidadeConsumidaDCR = ':quantidade_consumida'
        codigoClienteDCR = ':cdigo_do_cliente'
        nomeClienteDCR = ':nome_do_cliente'
        dataPedidoDCR = ':data_do_pedido'
        iDPedidoDCR = ':id_do_pedido'
        quantidadeDCR = ':quantidade'
        codigoServicoDCR = ':cdigo_do_servio'
        nomeServicoDCR = ':nome_do_servio'
        aliasLojaDCR = ':alias_da_loja'
        valorImpostoDCR = ':valor_do_imposto'
        precoUnitarioDCR = ':preo_unitrio'
        tipoAtividadeDCR = ':tipo_de_atividade'
        precoFinalDCR = ':preo_final'
        estadoEnderecoCobrancaClienteDCR = ':estado_do_endereo_de_cobrana_do_cliente'
        formaPagamentoDCR = ':forma_de_pagamento'
        cicloFaturamentoDCR = ':msano_do_ciclo_de_faturamento'
        totaISSDCR = ':total_taxiss'
        totalCOFINSDCR = ':total_taxcofins'
        totalPISDCR = ':total_taxpis'
        totalRetailPriceWithTaxesWithoutDiscountsDCR = ':totalretailpricewithtaxeswithoutdiscounts'
      
        #pegar os customer code do bill e do DCR e comparar pelo Activuty type seguindo os demais itens
        dcr.each { |rowDCR| 
            iDPedido = rowDCR[iDPedidoDCR]

            bill.each { |rowBill|  
                if(rowBill[:order_id].eql? rowDCR[:id_do_pedido])
                   
                    pedidosNoBill.push(rowBill[:order_id]) 

                    rowBill[:bill_to].eql? rowDCR[:data_final_do_ciclo_de_faturamento]
                    rowBill[:bill_from].eql? rowDCR[:data_inicial_do_ciclo_de_faturamento]
                    rowBill[:qty].eql? rowDCR[:quantidade_consumida]
                    rowBill[:service_name].eql? rowDCR[:nome_do_servio]

                    rowBill[:order_creation_date].eql? rowDCR[:data_do_pedido]
                    rowBill[:service_code].eql? rowDCR[:cdigo_do_servio]
                    rowBill[:store_acronym].eql? rowDCR[:alias_da_loja]
                    rowBill[:tax_on_total_retail_price].eql? rowDCR[:valor_do_imposto]
                    rowBill[:retail_unit_price].eql? rowDCR[:preo_unitrio]
                    rowBill[:grand_total_retail_price].eql? rowDCR[:preo_final]
                    rowBill[:billing_state_province].eql? rowDCR[:estado_do_endereo_de_cobrana_do_cliente]
                    rowBill[:payment_method].eql? rowDCR[:forma_de_pagamento]
                    rowBill[:cycle_code].eql? rowDCR[:msano_do_ciclo_de_faturamento]
                    rowBill[:total_taxiss].eql? rowDCR[:total_taxiss]
                    rowBill[:total_taxcofins].eql? rowDCR[:total_taxcofins]
                    rowBill[:total_taxpis].eql? rowDCR[:total_taxpis]
                    rowBill[:total_retail_price_with_taxes_without_discount].eql? rowDCR[:totalretailpricewithtaxeswithoutdiscounts]

                elsif
                    pedidosForaDoBill.push(rowDCR[:id_do_pedido]) 
                end
            }
                           
        }
        
     

        pedidosNoBill.each { |row| 
            pedidosForaDoBill.delete(row)
        }
        pedidosForaDoBill.uniq!()
        indice = 0
        while indice < pedidosForaDoBill.length
            puts('Pedidos fora da billfeed: ')
            puts(pedidosForaDoBill[indice])
            indice = indice + 1
        end

       
       pedidosFora = pedidosForaDoBill.size
        
        return pedidosFora
        
    end

    

def validarBillPROD
    bill = CSV.table('C:\Users\eduardoam\Downloads\billprod/DailyConsolidatedFeed_targettelefonica_27-4-2022.csv',col_sep: ",",headers:true,skip_blanks: true, converters: [])
    headerBill = CSV.open('billfeedSemIaaS-edit.csv', 'r') { |csv| csv.first }
    clientesJurosMultas = []
    sequence = []
    multa = []
    dataCorte = '16/03/2022'
    bill.each { |rowBill|  
        if(rowBill[:activity_type].eql? 'Interest')
            puts rowBill[:comments_credited]
            comentario = rowBill[:comments_credited]
            vetorComentatio = comentario.split        
            datapg = vetorComentatio[6]
            if(Date.parse(dataCorte) > Date.parse(datapg))
                puts (dataCorte + ' >' + datapg)
                sequence.push(rowBill[:sequence])
                clientesJurosMultas.push(rowBill[:customer_code])
                clientesJurosMultas.push(rowBill[:grand_total_retail_price])
            end
        end
        if(rowBill[:activity_type].eql? 'Fines')
            puts rowBill[:comments_credited]
            comentario = rowBill[:comments_credited]
            vetorComentatio = comentario.split
            datapg = vetorComentatio[6]
              if(Date.parse(dataCorte) > Date.parse(datapg))
                puts (dataCorte + ' >' + datapg)
                sequence.push(rowBill[:sequence])
                clientesJurosMultas.push(rowBill[:customer_code])
                clientesJurosMultas.push(rowBill[:grand_total_retail_price])
                end
            end
    }
    for i in 0..sequence.length
        bill.delete_if do |row|
            row[:sequence].eql? sequence[i]
        end 
    end
        CSV.open("billfeedProd-edit.csv","wb") do |csv_out|
            csv_out << headerBill
            bill.each{ |row| csv_out << row }
        end
        newBill = CSV.table('billfeedProd-edit.csv',col_sep: ",",headers:true,skip_blanks: true, converters: [])
        for i in 0..clientesJurosMultas.length do 
            newBill.each{ |row|
                if( row[:customer_code].eql? clientesJurosMultas[i])
                    if (row[:total_invoice_price].to_f>0)
                        row[:total_invoice_price] = (row[:total_invoice_price].to_f - clientesJurosMultas[i+1].to_f).to_s
                        row[:total_due_amount] = (row[:total_due_amount].to_f - clientesJurosMultas[i+1].to_f).to_s
                        row[:total_retail_price_with_taxes_without_discount] = (row[:total_retail_price_with_taxes_without_discount].to_f - clientesJurosMultas[i+1].to_f).to_s
                    end
                end
            }
        end
        CSV.open("DailyConsolidatedFeed_targettelefonica_27-4-2022.csv","wb") do |csv_out|
            csv_out << headerBill
            newBill.each{ |row| csv_out << row }
        end
    end
    
    #tratamento do SOX-Contabil, ele vem em XLSX e precisamos tranformar em CSV
    def converterSoxContabil
        xls_file = Roo::Excelx.new('relatorio-sox-contabil.xlsx')
        CSV.open('relatorio-sox-contabil.csv',"wb") do |csv|
            xls_file.each{ |row| csv << row }
        end
    end

    def limpezaSoxContabil
        sox = CSV.table('relatorio-sox-contabil.csv',col_sep: ",",headers:true,skip_blanks: true, converters: [])
        headerSox = sox[3]
        soxSemFiltros = sox[4...]
        CSV.open("relatorio-sox-contabil.csv", 'wb') do |r|
            r << headerSox
            soxSemFiltros.length.times do |i|
                r << soxSemFiltros[i]
                end 
        end
    end

    def validarSoxContabil
        sox = CSV.table('relatorio-sox-contabil.csv',col_sep: ",",headers:true,skip_blanks: true, converters: [])
        bill = CSV.table('billfeedSemIaaS-edit.csv',col_sep: ",",headers:true,skip_blanks: true, converters: [])
        
    end
    
    # Função que converte arquivos TXT em CSV para melhor trabalho na automação. Pois arquivos TXT são difíceis de trabalhar.
    def converteTXTParaCSVFat (nomeArquivo)
        File.open("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivo}") do |fileTxt|
            File.open("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/#{nomeArquivo}_Alterado.csv", 'w') do |fileCSV| #o 'w' abre o arquivo para escrever nele.
              fileTxt.each {|linha| fileCSV << linha.squeeze(' ').gsub(' ', ';').gsub('Cartao;de;Credito', 'Cartao de Credito')} #Faz uma iteração em cada linha do arquivo TXT remove os espaços e adiciona um ponto-e-virgula, e faz um tratamento para retirar os espaços da palavra "cartão de credito"
            end # Fecha o CSV
          end  # Fecha o TXT
    end

    # Função que encontra automaticamente o nome do arquivo FAT dentro do diretorio 
    def encontraNomeArquivoFat (arquivo)
        directory = './features/step_definitions/FluxoValidacaoBillFeed/Relatorio'
        result = Dir.glob(File.join(directory, '**.*')).select do |f|
                   f.match(arquivo)
                 end
        result = result.to_s.gsub("./features/step_definitions/FluxoValidacaoBillFeed/Relatorio/", "").gsub('[', '').gsub(']', '').gsub('"', '').to_s      
        return result
    end

end