######################################################
### Curso Introducao ao R - 1s2021
### Programa de Pos-Graduacao em Demografia - Unicamp
### Instrutor: Jose H C Monteiro da Silva
### Aula 3
######################################################

### Parte 0: Preparando a area de trabalho #----------

## Uma boa pratica de programacao e fazer sempre a 
## limpeza da area de trabalho antes de iniciar a 
## execucao dos codigos

## remocao dos objetos
rm( list = ls( ) )

## fechar graficos abertos
graphics.off()

######################################################

### Parte 1: Data Frames #----------------------------

## data frames sao objetos que representam um conjunto de dados em linhas e colunas
## seguem a forma data.frame[ linha, coluna ]
## as colunas podem ser acessadas pelo operador $

## Exemplo: populacao e nascimentos por UF 2000 e 2010

## 1.1 leitura de csv
dat_nasc <- 
  read.csv( file = 'aula_3/nascimentos_populacao_uf.csv', # caminho do arquivo
            sep = ';'  # separador (no caso ponto e virgula)
            )

# visualizando os dados:
View( dat_nasc )

# 5 primeiras obsercacoes
head( dat_nasc )

# 10 primeiras
head( dat_nasc, 10 )

# inspecionando o data.frame
str( dat_nasc ) # detalha as variaveis (colunas)
summary( dat_nasc ) # apresenta estatisticas descritivas das variaveis

# para selecionar uma variavel do data.frame usamos o operador $
dat_nasc$ufcod
dat_nasc$ano

# para filtrar elementos repetidos: unique()
unique( dat_nasc$ufname )
unique( dat_nasc$ano )

# contando linhas
nrow( dat_nasc )

# contando colunas
ncol( dat_nasc )

# visualizando os nomes
names( dat_nasc )

# ver linha 1 coluna 1
dat_nasc[ 1, 1 ]

# ver o que ha na linha 1
dat_nasc[ 1, ]

# linhas 2 a 10
dat_nasc[ 2:10,]

# coluna 4
dat_nasc[ , 4 ]
dat_nasc$nascimentos
dat_nasc[ , 'nascimentos' ]

dat_nasc[ , 4 ] == dat_nasc$nascimentos

# colunas 1, 4 e 5
dat_nasc[ , c( 'ufcod', 'nascimentos', 'populacao'  ) ]
dat_nasc[ , c( 1, 4, 5 ) ]

## 1.2 Filtros

# como selecionamos somente os dados para o ano de 2000?

# lembrando... ao usar operadores logicos no vetor, teremos para cada elemento
# que atenda a condicao o valor TRUE
dat_nasc$ano == 2000
# assim, se incluirmos essa condicao para cada linha filtramos somente os anos 2000
dat_nasc[ dat_nasc$ano == 2000, ]

# ou usando a funcao which: which retorna os elementos do vetor( no caso as linhas )
# que atendem a condicao mencionada
which( dat_nasc$ano == 2000 ) 
dat_nasc[ which( dat_nasc$ano == 2000 ), ]

# criando uma nova base:
dat_nasc2000 <- 
  dat_nasc[ which( dat_nasc$ano == 2000 ), ]

# ifelse
dat_nasc$pop10mi_mais <- ifelse( dat_nasc$populacao >= 10000000,
                                 'Sim',
                                 'Nao' )
### EXERCICIO: 
### Construa uma base somente com os estados que em 2010 tinham mais de 
### 14 milhoes de habitantes
### ATENCAO: a base deve conter os dados para os anos de 2000 e 2010
### Dica: 
### 1) identifique primeiro as UFs que cumpram com as condicoes

## 1.3 Operando nas linhas e nas colunas

# para a base 2000 podemos calcular a soma NAS colunas nascimentos e populacao
colSums( dat_nasc2000[ , c( 'nascimentos', 'populacao' ) ] )

# para 2010:
colSums( dat_nasc[ dat_nasc$ano == 2010 , c( 'nascimentos', 'populacao' ) ] )

# criando uma nova coluna/variavel
dat_nasc$taxa_natalidade <- 
  1000 * dat_nasc$nascimentos / dat_nasc$populacao

### EXERCICIOS: 
### 1) quais UFs em 2010 tinha taxa bruta de natalidade 
### maior que 20 nascimentos / 1000 habitantes?

### 2) Crie uma coluna com o codigo da regiao 
### (codigo da regiao = primeiro digito de coduf). 
### Dica: use a ideia de divisao inteira ou a funcao substr - ver ?substr

### 3) Qual a populacao total da regiao Nordeste nos anos 2000 e 2010?

### 4) Qual a media da taxa bruta de natalidade da regiao Sul em 2010?

### 5) Qual eh a taxa bruta de natalidade da regiao Sudeste nos anos 2000 e 2010?

######################################################

### Pre - aula 4: instalar pacotes
install.packages( c( 'dplyr', 'ggplot2', 'data.table', 'readxl', 'readr' ) )


### Fim!