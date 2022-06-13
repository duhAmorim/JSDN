class StormConfiguracaoOferta < SitePrism::Page
    element :precoStormVarejo, 'input[name="retailPrice"]'
    element :precoStormPtax, 'input[name="priceOfRetail"]'
    element :btnSalvar, '#save'
end