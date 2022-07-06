# Para intervalo de 1987 a 2012
#AnoBase
#Regiao
#Uf
#SiglaIes
#GrandeAreaDescricao
#AreaAvaliacao
#Nivel

# Para intervalo de 2013 a 2018
#AN_BASE
#SG_ENTIDADE_ENSINO
#NM_GRAU_ACADEMICO
#NM_REGIAO
#NM_AREA_AVALIACAO
#SG_UF_IES	
#NM_GRANDE_AREA_CONHECIMENTO	
#NM_AREA_AVALIACAO

# Importar bibliotecas para concatenação de tabelas com texto
library(dplyr)

# Limpar variáveis 
rm(nova_tabela, tabela_simplificada, tabela_tmp, tabela_nome, anoInicio, w)

# Inicializar ano de partida
anoInicio = 1987

# Laço de redução de tabelas
for (w in anoInicio:2018) {
  # Selecionar ano e nome da tabela
  tabela_nome <- paste("dados_", w, ".csv", sep = "")
  
  # Caminho da tabela
  caminho_tabela <- paste(diretorio, "/", tabela_nome, sep = "")
  
  # Carregar dados da tabela
  tabela_tmp <- read.csv(caminho_tabela, sep=";")
  
  # Verificar ano da tabela e selecionar colunas
  if(w < 2013) {
    tabela_simplificada = tabela_tmp[c("AnoBase",	"Regiao",	"Uf",	"SiglaIes",
                                       "GrandeAreaDescricao",	"AreaAvaliacao",
                                       "Nivel"
    )]  
  } else {
    tabela_simplificada = tabela_tmp[c("AN_BASE",	"NM_REGIAO",	"SG_UF_IES",
                                       "SG_ENTIDADE_ENSINO", "NM_GRANDE_AREA_CONHECIMENTO",
                                       "NM_AREA_AVALIACAO", "NM_GRAU_ACADEMICO"
    )]
  }
  
  # Substituir nome das colunas da tabela
  names(tabela_simplificada)[1:7] <- c("Ano",	"Regiao",	"UF",	"Entidade",
                                       "GrandeArea",	"AreaAvaliacao",	"Nivel")
  
  # Mesclar tabelas
  if(w == anoInicio) {
    nova_tabela <- tabela_simplificada
  } else {
    nova_tabela <- bind_rows(nova_tabela, tabela_simplificada)
  }
}

# Salvar tabela
write.csv2(nova_tabela, paste("dados_", anoInicio, "_", w, ".csv", sep = ""), row.names = FALSE)

# Abrir tabela final
dados <- read.csv("dados.csv", sep="\t", encoding = "UTF-8")