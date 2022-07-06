# Projeção de Gráficos

# Importação de bilbioteca de gráficos
library(ggplot2)

# Número de incidências únicas
unique(dados$Ano) # 32
unique(dados$Uf) # 27
unique(dados$Ies) # 538
unique(dados$AreaAvaliacao) # 59
unique(dados$Regiao) # 5
unique(dados$GrandeArea) # 9
unique(dados$Nivel) # 2 (5 com Mestrado/Doutorado Profissional)

salvar = function(Grafico, Nome) {
  pdf(paste(Nome, ".pdf", sep = ""), width=11.0, height=9.0)
  plot(Grafico)
  dev.off()
  
  setEPS()
  postscript(paste(Nome, ".eps", sep = ""), width = 11.0, height = 9.0)
  plot(Grafico)
  dev.off()
}

# 1 - Projetar Publicações por Região e Ano (1987-2018) OK 
ggplot(data = dados, mapping = aes( x = Ano, fill = Regiao)) + geom_bar() +
  labs(x="Anos", y="Número de Publicações", title="Publicações por Região (1987-2018)")

# 2 - Projetar Publicações por Grande Área de Conhecimento e Ano (1987-2018)
ggplot(data = dados, mapping = aes( x = Ano, fill = GrandeArea)) + geom_bar() +
  labs(x="Anos", y="Número de Publicações", title="Publicações por Grande Área de Conhecimento (1987-2018)")

# 3 - Projetar Publicações por Nível e Grandes Áreas de Conhecimento (1987 - 2018)
graf <- ggplot(dados, aes(x="", fill=Nivel)) + 
  geom_histogram(stat = "count", bins = 30) + 
  labs(x="Níveis por Grande Área de Conhecimento", y="Número de publicações", fill="Nível", title="1987-2018") + 
  facet_grid(~GrandeArea) + ggtitle("Publicações por Nível e Grandes Áreas de Conhecimento (1987 - 2018)")
salvar(graf, "NivelGrandeArea")

# 4 - Projetar Publicações por Nível e Ano (1987-2018)
ggplot(data = dados, mapping = aes( x = Ano, fill = Nivel)) + geom_bar() +
  labs(x="Anos", y="Número de Publicações", title="Publicações por Nível (1987-2018)")

# 5 - Projetar Publicações por Nível e Estado (1987-2018)
ggplot(data = dados, mapping = aes(x=Uf, fill = Nivel)) + geom_bar() + 
  labs(x="Níveis por Estado", y="Número de Publicações",fill="Nível", title="Publicações por Nível e Estado (1987-2018)")

# 6 - Projetar Publicações por Região por Estado (1987-2018)
ggplot(data = dados, aes(x="", colour=Nivel, fill=Nivel)) + 
  geom_histogram(stat = "count", bins = 30) + 
  labs(x="Nível", y="Número de Publicações", title="Publicações por Região (1987-2018)") + 
  facet_grid(~Regiao)

# 7 - Projetar Publicações por Entidade de Ensino (1987-2018)
ggplot(data = dados, aes(x="" , colour=Nivel, fill=Nivel)) + 
  geom_histogram(stat = "count", bins = 30) + 
  labs(x="Níveis por Região", y="Número de publicações", title="Publicações por Nível e Região (1987-2018)") + 
  facet_wrap(~Regiao, ncol=3) + theme(legend.position="bottom")

#  - Projetar Publicações por Entidade de Ensino (1987-2018)
ggplot(data = dados, mapping = aes( x = Ano, fill = Ies)) + geom_bar() +
  labs(x="Anos", y="Número de Publicações", title="Publicações por Entidade de Ensino (1987-2018)")

# 6 - Projetar Publicações por Área de Avaliação e Ano (1987-2018)
ggplot(data = dados, mapping = aes( x = Ano, fill = AreaAvaliacao)) + geom_bar() +
  labs(x="Anos", y="Número de Publicações", title="Publicações por Área de Avaliação (1987-2018)")

# 7 - Projetar Publicações por Estado por Grande Área (1987-2018)
ggplot(data = dados, mapping = aes( x = Uf, fill = GrandeArea)) + geom_bar() +
  labs(x="Anos", y="Número de Publicações", title="Publicações por Nível (1987-2018)")
