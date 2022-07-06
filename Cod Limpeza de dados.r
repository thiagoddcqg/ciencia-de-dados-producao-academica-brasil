library(stringr)
library(ggplot2)
library(tidyverse)
options(max.print=5.5E5) 
 diretorio = '~/Dados/'
 setwd(diretorio)
 anoInicio = 1987
 
 LimpDatas = function(NomeDataAtual, NomeDataNovo, ano){
   
   NomeDataAtual<- rename(get(paste("Ano",ano, sep = "")) , AreasConhecimento = AreaConhecimento, AreasConhecimentoCodigo = AreaConhecimentoCodigo)
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
 
 for(w in 11:26){
  # nome1 <- paste("Ano",anoInicio, sep = "")
    if (w==1 || w == 4) assign(paste("Ano",anoInicio, sep = ""),read.csv(paste(diretorio,paste(w,".csv",sep = ""), sep = ""),sep=";", comment.char="#")) 
    else
   if(w<18 | w>26){  
   assign(paste("Ano",anoInicio, sep = ""),read.csv(paste(diretorio,paste(w,".csv",sep = ""), sep = ""),sep=";", comment.char="#")) 
         
   if(w>26){
      print("Passou")
      assign(paste("Ano",anoInicio, sep = ""), rename(get(paste("Ano",anoInicio, sep = "")), AnoBase = AN_BASE, Regiao = NM_REGIAO, SiglaIes = SG_ENTIDADE_ENSINO, NomePrograma = NM_PROGRAMA, GrandeAreaDescricao =  NM_GRANDE_AREA_CONHECIMENTO, AreaConhecimento = NM_AREA_CONHECIMENTO, Nivel = NM_GRAU_ACADEMICO, DataDefesa = DT_TITULACAO, Uf = SG_UF_IES, NomeIes = NM_ENTIDADE_ENSINO, GrandeAreaCodigo = CD_GRANDE_AREA_CONHECIMENTO, AreaConhecimentoCodigo = CD_AREA_CONHECIMENTO))
      
      }
   }
    else{
       assign(paste("Ano",anoInicio, sep = ""),read.csv(paste(diretorio,paste(w,".csv",sep = ""), sep = ""),sep=",", comment.char="#"))
    }
   print(paste("Ano",anoInicio, sep = ""))
   assign(paste("Ano",anoInicio, sep = ""),LimpDatas(get(paste("Ano", anoInicio, sep = "")), get(paste("AnoBase",anoInicio, sep = "")),anoInicio))
   if(w==1){
         BaseAnos <- get(paste("Ano",anoInicio, sep = ""))
         rm( list=c(paste("Ano",anoInicio, sep = "")) )
         
      }else{
         BaseAnos<-rbind(get(paste("Ano",anoInicio, sep = "")), BaseAnos)
         rm( list=c(paste("Ano",anoInicio, sep = "")) )
      
      
   }
   anoInicio = anoInicio+1

 } 

 ggplot(data = BaseAnos, mapping = aes( x = AnoBase, fill = Nivel)) + geom_bar()
 ggplot(data = BaseAnos, mapping = aes( x = AnoBase, fill = Regiao)) + geom_bar()
 ggplot(data = BaseAnos, mapping = aes( x = AnoBase, fill = GrandeAreaDescricao)) + geom_bar()
 ggplot(data = Ano1987, mapping = aes(x = Nivel)) + geom_bar(aes(fill(Nivel)))
 