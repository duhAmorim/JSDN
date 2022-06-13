class RelatoriosMKT < SitePrism::Page
    element :relatoriospersonalisados, :link,'Relatórios personalizados',match: :first
    element :addRelatorioPersonalizado,'input[value="Adicionar Relatório Personalizado"]'
    element :solicitacoesRelatoriosOffiline,:link,"Solicitações de relatório off-line"
    element :relatorioSoxContabil,:xpath, '//a[@href="/reports/reports/getNextFilter.do?cName=Relatórios Gerais&rName=Relatório SOX Contábil&rID=2000&externalReport=Y&reportCode=REL_S_C"]'
end