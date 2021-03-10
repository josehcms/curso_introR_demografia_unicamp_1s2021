######################################################
### Curso Introducao ao R - 1s2021
### Programa de Pos-Graduacao em Demografia - Unicamp
### Instrutor: Jose H C Monteiro da Silva
### Aula 1
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

### Parte 1: Calculadora #----------------------------

## 1.1 Adicao
5 + 5
10 + 35 + 9
10 + 6 + 6.99

## 1.2 Subtracao 
9 - 4
85 - 9
123 - 158

## 1.3 Multiplicacao
5 * 8

## 1.4 Operacoes de Divisao

## Lembrem-se que a divisao segue o inverso da multiplicacao e 
## opera da seguinte forma:
## dividendo = divisor * quociente + resto

# 1.4.1 Divisao
10 / 4
10 / 3

# 1.4.2 Divisao inteira (sem resto)
10 %/% 3

# 1.4.3 Resto
10 %% 3

# 1.5 Uso de parenteses e ordem de operacoes

10 / 2 * 3

( 10 / 2 ) * 3

10 / ( 2 * 3 )

10 + 4 / 2

( 10 + 4 ) / 2

10 + ( 4 / 2 )

## 1.6 Potencia

10 ^ 2

3 ^ 3

## 1.7 Raiz

sqrt( 25 )

# Lembre - se: raiz quadrada nada mais e do que 
# o numero elevado a 1/2
25 ^ ( 1 / 2 )

# raiz cubica = numero ^ ( 1 / 3 )
27 ^ ( 1 / 3 )

# Importancia dos parenteses!!!
27 ^ 1 / 3 # veja que a potencia e feita primeiro

######################################################

### Parte 2: Criacao e atribuicao de variaveis #------

## No R podemos criar variaveis com os comandos 
## '=' ou '<-' ( alt + 'traco/underline' )

x <- 63
## Ver o que se tem armazenado no objeto x
x
# ou
print( x )

## operando com 2 variaveis
y = 8

y + x
x - y
x / y

## armazenando em outra

z1 <- x + y
z1

z2 <- x - y + x ^ 2 
z2

######################################################

### Parte 3: Classes de objetos #---------------------

## Considere os tres objetos abaixo x, y e z
x = 80
y = 'Vasco'
z = FALSE
w = TRUE

## vejamos as classes de cada um
class(x)
class(y)
class(z)
class(w)

## e se tentarmos operar entre eles?
x + y # Erro! Nao podemos operar entre caracteres e numeros

# e se eu tiver o seguinte caso? 
'4' + 4 # Tambem nao!
# como resolver?
as.numeric( '4' ) + 4 # agora sim!

# e com o tipo logico?
x + z # EIN?!
x + w 

# tipos logicos operam com numericos, sendo
# TRUE = 1 e FALSE = 0
as.numeric( TRUE )
as.numeric( FALSE )

# podem ser representados como T ou F simplesmente

T
F
T + T + F

######################################################

### Parte 4: Vetores #--------------------------------

## 4.1 Criando vetores - funcao c()

# vetor de numeros
vetor1 <- c( 0, 1, 2, 3, 4 )
class( vetor1 ) 

# vetor de caracteres
vetor2 <- c( 'a', 'b', 'c' )
class( vetor2 )

# e se misturar?
vetor3 <- c( 'a', 2, 'c' )
class( vetor3 )
vetor3

vetor4 <- c( 1, 3, TRUE )
class( vetor4 )
vetor4

## 4.2 Operacoes com vetores

# Tamanho
length( vetor1 )
length( vetor2 )

# Ordenar
sort( c( 10, 540, 1, 20, 14, 99, 89, 70, 40, 35, 2, 0, 1 ) )
sort( c( 'z', 'a', 'c', 'b', 'w', 'm', 'l' ) )

# para ordem decrescente:
sort( c( 10, 540, 1, 20, 0 ), decreasing = TRUE )

# Soma elementos do vetor
sum( c( 5, 10, 20, 30, 100 ) )

# Maximo e minimo
max( c( 10, 540, 1, 20, 14, 99, 89, 70, 40, 35, 2, 0, 1 ) )
min( c( 10, 540, 1, 20, 14, 99, 89, 70, 40, 35, 2, 0, 1 ) )

max( c( 'z', 'a', 'c', 'b', 'w', 'm', 'l' ) )
min( c( 'z', 'a', 'c', 'b', 'w', 'm', 'l' ) )

# Media
mean( c( 5, 15, 20 ) )

# Mediana
median( c( 5, 15, 20 ) )

# Variancia
var( c( 5, 15, 20 ) )

# desvio padrao
sd( c( 5, 15, 20 ) )

# quantis
quantile( c( 5, 15, 20 ) )

## 4.3 Outros...

# gerando vetores sequenciais ou com intervalo especifico
# podemos gerar vetores sequenciais de varias formas

# utilizando a estrutura 'inicio:fim'
1:5 # crescente
10:3 # decrescente

# utilizando a funcao seq
seq( 1, 5 )
seq( 10, 3 )

# podemos especificar tanto o tamanho dos passos de uma sequencia
# quanto o numero de elementos que queremos gerar entre os 
# dois numeros especificados

# 0 a 10 de 2 em 2
seq( from = 0, to = 10, by = 2 )
seq( 0, 10, 2 )

# 100 a 50, de 5 em 5 
# -5 em by pois estamos indo de 100 para 50
seq( from = 100, to = 50, by = -5 ) 
seq( 100, 50, -5 )

# 5 elementos entre 0 e 100 (com o mesmo intervalo entre eles!)
seq( from = 0, to = 100, length.out = 5 )

# 20 elementos entre 0 e 1
seq( 0, 1, length.out = 20 )

# nomeando os elementos dos vetores
vetor <- c( 0, 20, 50, 10, 20 )
names( vetor ) <- c( 'e1', 'e2', 'e3', 'e4', 'e5' )

# acesando posicoes especificas do vetor
vetor[ 1 ] # posicao 1
vetor[ 3 ] # posicao 3
vetor[ c( 1, 3 ) ] # posicoes 1 e 3 

# podemos acessar usando os nomes
vetor[ 'e5' ]
vetor[ c( 'e2', 'e4' ) ]
######################################################

### Parte 5: Fatores #--------------------------------

# fatores podem ser definidos como variaveis categoricas ordinais
# ou seja, seguem uma ordem

# considere o vetor abaixo com classificacoes de conceitos de notas
# de 5 alunos

conceitos <- c( 'Bom', 'Otimo', 'Regular', 'Bom', 'Otimo' )
class(conceitos)

# se ordenarmos o vetor, a operacao sera feita pela ordem alfabetica
sort(conceitos)

# se quisermos ordenar por conceito, devemos devinir os niveis

conceitos_fator <- 
  factor( conceitos,
          levels = c( 'Regular', 'Bom', 'Otimo' ) )

conceitos_fator
sort( conceitos_fator )

# podemos mudar os labels 
conceitos_short <- 
factor( conceitos,
        levels = c( 'Regular', 'Bom', 'Otimo' ),
        labels = c( 10, 50, 100 ) )

conceitos_short
# se convertermos faotres para numericos, isso nos retorna
# o indice correspondente ao respectivo nivel, no caso:
# 1 - Regular, 2 - Bom, 3 - Otimo
as.numeric( conceitos_fator )
######################################################

### Fim!

