LimpDatas = function(NomeDataAtual, NomeDataNovo){
  NomeDataNovo <- subset(NomeDataAtual, Uf!= '' & AnoBase!= '' & IdPrograma!= '' & Regiao!= '' & SiglaIes!= '' & NomeIes!= '' & NomePrograma!= '' & GrandeAreaCodigo!= '' & AreasConhecimentoCodigo!= '' & AreasConhecimento!= '' & Nivel!= '', select = c(Uf, Regiao, AnoBase, SiglaIes, NomePrograma, GrandeAreaDescricao, AreasConhecimento, Nivel, DataDefesa))
  for(i in 1:length(NomeDataNovo$Nivel))
  {
   
    if(NomeDataNovo$DataDefesa[i] == 'Mestrado' | NomeDataNovo$DataDefesa[i] == 'Doutorado' ){
        NomeDataNovo$Nivel[i]=NomeDataNovo$DataDefesa[i]}
    
    if(NomeDataNovo$Nivel[i] != 'Mestrado' | NomeDataNovo$Nivel[i] != 'Doutorado'){
      
    }
  }
}

LimpDatas(AnoB1987, Ano19871)