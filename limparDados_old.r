# Salvar lista de arquivos de dados em um vetor V
V = list.files("C:/Disciplinas/", pattern="*.csv");

# Iterar repetições com remoção de variáveis desnecessárias e
# salvar em novos arquivos
for(i in 1:25) {
  capes <- read.csv(v[i], sep=";");
  df = subset(capes[i], select = -c(IdPrograma, IdTese, Uf, NomeIes,
                                      GrandeAreaCodigo, AreasConhecimentoCodigo,
                                      AreaAvaliacao, DocumentoDiscente, Autor, 
                                      EmailAutor, TituloTese, PalavrasChave, Volume, 
                                      BibliotecaDepositaria, Idioma, ResumoTese, 
                                      IdLinhaPesquisa, URLTextoCompleto, 
                                      LinhaPesquisa) )
  
  # Salvando arquivo
  write.csv(df,'C:\\Disciplinas\\' + v[i] + 'Rdz.csv', row.names = FALSE)
}