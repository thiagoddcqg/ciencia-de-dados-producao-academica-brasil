
library(stringr)
Base<- BaseAnos
Base <- str_replace_all(BaseAnos$GrandeAreaDescricao, "CI�NCIAS HUMANAS", "CIENCIAS HUMANAS" )
for(i in 1:length(BaseAnos$GrandeAreaDescricao)){
   if(str_detect(BaseAnos$GrandeAreaDescricao[i], pattern = "CI�NCIAS HUMANAS")){
      BaseAnos$GrandeAreaDescricao[BaseAnos$GrandeAreaDescricao == "CI�NCIAS HUMANAS"]="CIENCIAS HUMANAS"
      print(BaseAnos$GrandeAreaDescricao == "CI�NCIAS HUMANAS	")
   }
}
library(ggplot2)
library(tidyverse)
options(max.print=5.5E5) 
 diretorio = '~/Dados/'
 setwd(diretorio)
 anoInicio = 1987
 LimpDatas = function(NomeDataAtual, NomeDataNovo, ano){
   if(ano>1989){
      NomeDataAtual<- rename(get(paste("Ano",ano, sep = "")) , AreasConhecimento = AreaConhecimento, AreasConhecimentoCodigo = AreaConhecimentoCodigo)
   
   }
    NomeDataNovo <- subset(NomeDataAtual, Uf!= '' & AnoBase!= '' & Regiao!= '' & SiglaIes!= '' & NomeIes!= '' & NomePrograma!= '' & GrandeAreaCodigo!= '' & AreasConhecimentoCodigo!= '' & AreasConhecimento!= '' & Nivel!= '', select = c(Uf, Regiao, AnoBase, SiglaIes, NomePrograma, GrandeAreaDescricao, AreasConhecimento, Nivel, DataDefesa))
   
   for(i in 1:length(NomeDataNovo$Nivel))
   {
     
     if(NomeDataNovo$DataDefesa[i] == 'Mestrado' | NomeDataNovo$DataDefesa[i] == 'Doutorado' ){
       NomeDataNovo$Nivel[i]=NomeDataNovo$DataDefesa[i]}
     
     
     
     
   }  
   
   NomeDataNovo1 <- subset(NomeDataNovo, NomeDataNovo$Nivel == 'Mestrado')
   NomeDataNovo2 <- subset(NomeDataNovo, NomeDataNovo$Nivel == 'Doutorado')
   NomeDataNovo <- rbind(NomeDataNovo1, NomeDataNovo2)
   return(NomeDataNovo)
 }
 
 for(w in 1:26){
  # nome1 <- paste("Ano",anoInicio, sep = "")
   assign(paste("Ano",anoInicio, sep = ""),read.csv(paste(diretorio,paste(w,".csv",sep = ""), sep = ""),sep=";", comment.char="#", encoding = "UTF-8")) 
         
   if(w>26){
      print("Passou")
      assign(paste("Ano",anoInicio, sep = ""), rename(get(paste("Ano",anoInicio, sep = "")), AnoBase = AN_BASE, Regiao = NM_REGIAO, SiglaIes = SG_ENTIDADE_ENSINO, NomePrograma = NM_PROGRAMA, GrandeAreaDescricao =  NM_GRANDE_AREA_CONHECIMENTO, AreaConhecimento = NM_AREA_CONHECIMENTO, Nivel = NM_GRAU_ACADEMICO, DataDefesa = DT_TITULACAO, Uf = SG_UF_IES, NomeIes = NM_ENTIDADE_ENSINO, GrandeAreaCodigo = CD_GRANDE_AREA_CONHECIMENTO, AreaConhecimentoCodigo = CD_AREA_CONHECIMENTO))
      
      }
   
   print(paste("Ano",anoInicio, sep = ""))
   assign(paste("Ano",anoInicio, sep = ""),LimpDatas(get(paste("Ano", anoInicio, sep = "")), get(paste("AnoBase",anoInicio, sep = "")),anoInicio))
   if(w==1){
         BaseAnos <- get(paste("Ano",anoInicio, sep = ""))
         rm( list=c(paste("Ano",anoInicio, sep = "")) )
         
      }else{
         BaseAnos<-rbind(BaseAnos, get(paste("Ano",anoInicio, sep = "")))
         rm( list=c(paste("Ano",anoInicio, sep = "")) )
      
      
   }
   anoInicio = anoInicio+1

 }  
rm(BaseAnos)facet_grid(~Regiao)

unique(BaseAnos$SiglaIes)
unique(BaseAnos$NomePrograma)
unique(BaseAnos$GrandeAreaDescricao)
unique(BaseAnos$AreasConhecimento)
unique(BaseAnos$DataDefesa)

 # Figura 1: Número de Publicações por Nível
 setEPS()
 postscript("PorNivel.eps", width = 11.0, height = 9.0)
 ggplot(data = BaseAnos, mapping = aes( x = AnoBase, fill = Nivel)) + geom_bar() +
   labs(x="Anos", y="Número de Publicações", title="Publicações por Nível (1987-2012)") 
 dev.off()
 
 # Figura 1.1: Número de Publicações por Nível (Sem traçado)
 setEPS()
 postscript("PorNivel2.eps", width = 11.0, height = 9.0)
 ggplot(data = BaseAnos, mapping = aes(x = Nivel)) + geom_bar(aes(fill(Nivel))) +
   labs(x="Anos", y="Número de Publicações", title="Publicações por Nível (1987-2012)")
 dev.off()
 
 # Figura 1.2: Número Absoluto de Publicações por Nível
 setEPS()
 postscript("PorNivel3.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, colour=Nivel, fill=Nivel)) + 
   geom_histogram(stat = "count") + 
   labs(x="Níveis", y="Número de Publicações", title="Publicações por Nível (1987-2012)")
 facet_grid(~Nivel)
 dev.off()
 
 # Figura 2: Número de Publicações por Região
 setEPS()
 postscript("PorRegiao.eps", width = 11.0, height = 9.0)
 ggplot(data = BaseAnos, mapping = aes( x = AnoBase, fill = Regiao)) + geom_bar() +
   labs(x="Anos", y="Número de Publicações", title="Publicações por Região (1987-2012)")
 dev.off()
 
 # Figura 2.1: Número de Publicações por Nível e Região
 setEPS()
 postscript("PorNivelRegiao.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, colour=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 1000) + 
    labs(x="Níveis por Região", y="Número de Publicações", title="Publicações por Nível e Região (1987-2012)") + 
    facet_grid(~Regiao)
 dev.off()
 
 # Figura 2.2: Número de Publicações por Nível e Região
 setEPS()
 postscript("PorNivelRegiao2.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, colour=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 1000) + 
    labs(x="Níveis por Região", y="Número de Publicações", title="Publicações por Nível e Região (1987-2012)") + 
    facet_grid(~Regiao)
 dev.off()
 
 # Figura 2.3: Número de Publicações por Nível e Região
 setEPS()
 postscript("PorNivelRegiao3.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel , colour=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 1000) + 
    labs(x="Níveis por Região", y="Número de publicações", title="Publicações por Nível e Região (1987-2012)") + 
    facet_wrap(~Regiao, ncol=2)
 dev.off()
 
 # Figura 3: Número de Publicações por Grande Área de Conhecimento
 setEPS()
 postscript("PorGrandeAreaConhecimento.eps", width = 11.0, height = 9.0)
 ggplot(data = BaseAnos, mapping = aes( x = AnoBase, fill = GrandeAreaDescricao)) + geom_bar() +
   labs(x="Anos", y="Número de Publicações", title="Publicações por Grande Área de Conhecimento (1987-2012)")
 dev.off()
 
 # Figura 3.1: Número de Publicações por Grande Área de Conhecimento
 setEPS()
 postscript("PorGrandeAreaConhecimento2.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 10000) + 
    labs(x="Níveis por Grande Área de Conhecimento", y="Número de publicações",fill="Nível", title="1987-2012") + 
    facet_grid(~GrandeAreaDescricao) + ggtitle("Publicações por Nível e Grandes Áreas de Conhecimento (1987 - 2012)")
 dev.off()
 
 # Figura 4: Número de Publicações por Estado
 setEPS()
 postscript("PorEstado.eps", width = 11.0, height = 9.0)
 ggplot(data = BaseAnos, mapping = aes(x=Uf, fill = Nivel)) + geom_bar() + 
    labs(x="Níveis por Estado", y="Número de Publicações",fill="Nível", title="Publicações por Nível e Estado (1987-2012)")
 dev.off()
 
 # Figura 5: Número de Publicações por Instituição de Ensino Superior
 setEPS()
 postscript("PorSiglaIes.eps", width = 11.0, height = 9.0)
 ggplot(data = BaseAnos, mapping = aes( x = AnoBase, fill = SiglaIes)) + geom_bar() +
   labs(x="", y="Número de Publicações", title="Publicações por (1987-2012)")
 dev.off()
 
 setEPS()
 postscript("PorSiglaIes2.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, colour=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 1000) + 
    labs(x="Nível", y="Número de Publicações", title="Publicações por IES (1987-2012)") + 
    facet_grid(~SiglaIes)
 dev.off()
 
 # Figura 6: Número de Publicações por Nome do Programa
 setEPS()
 postscript("PorNomePrograma.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, colour=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 1000) + 
    labs(x="Nível", y="Número de Publicações", title="Publicações por Região (1987-2012)") + 
    facet_grid(~Regiao)
 dev.off()
 
 # Figura 7: Número de Publicações por Áreas do Conehcimento
 setEPS()
 postscript("PorAreasConhecimento.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, colour=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 1000) + 
    labs(x="Nível", y="Número de Publicações", title="Publicações por Região (1987-2012)") + 
    facet_grid(~Regiao)
 dev.off()
 
 # Figura 8: Número de Publicações por Data de Defesa
 setEPS()
 postscript("PorDataDefesa.eps", width = 11.0, height = 9.0)
 ggplot(BaseAnos, aes(x=Nivel, colour=Nivel, fill=Nivel)) + 
    geom_histogram(stat = "count", bins = 1000) + 
    labs(x="Nível", y="Número de Publicações", title="Publicações por Região (1987-2012)") + 
    facet_grid(~Regiao)
 dev.off()