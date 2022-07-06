# Exemplo 3 - Estatística Básica

# sum() - soma de valores
sum(1:5) # vetor de soma
sum(1, 2, 3, 4, 5) # soma de conjunto
sum(1:2, 3:5) # soma de subconjuntos
sum(1:5, NA) # vetor de soma com indeterminação
sum(1:5, NA, na.rm = TRUE) # vetor de soma com exclusão de indeterminações

# mean() média
x <- c(0:10, 50) # Combinação de vetor com última posição 50
xm <- mean(x) # Média
c(xm, mean(x, trim = 0.10)) # Combinação de média com média truncada

# var() variância
var(1:10)
var(1:5, 1:5)

# median() mediana
median(1:4) # 2.5 [número par]
median(c(1:3, 100, 1000)) # 3 [ímpar, robusto]

# summary() resumo estatístico
summary(attenu, digits = 4)
summary(attenu $ station, maxsum = 20)

# quantile() quantis
quantile(x <- rnorm(1001))
quantile(x, probs = c(0.1, 0.5, 1, 2, 5, 10, 50, NA)/100)