# Mudar local para diretório dos Dados
home = Sys.getenv("HOME")
worskpace = getwd()
datadir = paste(home,"/../../Public/Downloads/Educação/Produção Científica/Novos")
setwd(datadir)
diretorio = getwd()
print(diretorio)
