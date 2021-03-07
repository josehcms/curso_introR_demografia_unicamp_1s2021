######################################################
### Curso Introducao ao R - 1s2021
### Programa de Pos-Graduacao em Demografia - Unicamp
### Instrutor: Jose H C Monteiro da Silva
### Aula 2
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

### Parte 1: Operacoes logicas #----------------------

## 1.1 Apresentando os operadores logicos
## == : igual
## != : diferente
## <  : menor
## <= : menor ou igual
## >  : maior
## >= : maior ou igual
## &  : e (and)
## |  : ou (or)
## !  : nao (no)

x = 4
y = 4
z = 8

## testando as operacoes
x == y
x != y
x < y
x <= y
x > z
z > x

## combinando
# x eh igual a y E y eh menor que z?
x == y & y < z

# x eh menor que 8 OU z eh menor que 5?
x < 8 | z < 5

# entendendo E (&) e OU (|)
TRUE & TRUE 
TRUE & FALSE
FALSE & FALSE

TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

! ( 31 > 30 )

## 1.2 Operacoes logicas em vetores

x <- c( 5, 8, 1, 10, 30, 20, 45 )
x < 5

# veja que o terceiro elemento (1) eh o unico menor que 5
# como retornar somente esse elemento?

# ja vimos que nos colchetes podemos selecionar os elementos de um vetor
# utilizando os operadoes logicos nos colchetes, teremos 
# somente os valores TRUE para as operacoes logicas
x[ x < 5 ]
x[ x > 1 ]
x[ x > 1 & x < 20 ]

x[ x > 1 & x > 20 ]
x[ x > 1 | x > 20 ]
######################################################

### Parte 2: Condicionais #---------------------------

## 2.1 Apresentacao
# if( condicao ){ comandos } : se condicao for verdadeira, execute os comandos

# else : caso contrario 

x = 3
if( x > 1 ){
  print( 'Maior que 1!' )
} 

x = 3
if( x > 5 ){
  print( 'Maior que 5!' )
} else{
  print( 'Menor que 5!')
}

## EXERCICIO como retornar o modulo de x usando if e else?
# Lembre-se modulo = valor absoluto (no r, funcao abs())
# modulo de x = |x|
# |2| = 2
# |-2| = 2


# Suponha que queremos classificar nossa corrida de 5km a partir do tempo gasto
# 30 minutos ou mais = lento
# entre 25 e 30 = satisfatorio 
# menor que 25 = rapido

tempo = 26

if( tempo >= 30 ){
  corrida_class <- 'lento'
} else if( tempo < 30 & tempo >= 25 ){
  corrida_class <- 'satisfatorio'
} else{
  corrida_class <- 'rapido'
}

corrida_class

######################################################

### Parte 3: Loops #----------------------------------

## 3.1 While
# while eh definido da seguinte forma while( condicao ){ comandos }
# o loop while executa os comandos repetidamente ENQUANTO (while)
# a condicao for verdadeira

x = 0
while( x < 10 ){
  print( x )
  x <- x + 1
}

# podemos colocar mais operacoes dentro do loop
# por exemplo, queremos imprimir somente os numeros 
# divisiveis por 2 entre 0 e 9 (resto da divisao por 2 = 0)

x = 0
while( x < 10 ){
  if( x %% 2 == 0 ){
    print( x )
  }
  x <- x + 1
}

## EXERCICIO: e se quisermos os numeros que nao sao divisiveis por 2?
## Adapte o codigo!

## 3.2 Loop for
# o loop while executa um codigo ate ter uma condicao atingida
# o loop for executa os comandos para cada elemento de um vetor definido

# para i de 1 ate 20, imprima i
for( i in 0:20){
  print( i )
}

# somente os pares
for( i in 0:20){
  if( i %% 2 == 0 ){
    print( i )
  }
}

# veja que 0:20 eh nada mais nada menos que um vetor

for( i in c( 1, 5, 10 ) ){
  print( i )
}

for( i in c( 'brasiliense', 'atletico-go', 'vasco' ) ){
  print( i )
  }

######################################################


## Parte 4: Funcoes #---------------------------------

## 4.1 Introducao
# Ja fizemos uso de uma serie de funcoes ate entao
# Lembre-se de max, min por exemplo

# As funcoes recebem um determinado argumento, operam esse argumento
# e retornam um valor

# Veja a funcao max: 
# 1) recebe um vetor
# 2) compara seus elementos a partir de algum criterio 
# 3) retorna o valor maximo

max( c( 1, 2, 3 ) )

## 4.2 Criando uma funcao

# cria-se uma funcao com o comando function( argumentos ){ comandos }
# vamos criar uma funcao que imprima 'Demografia-Unicamp'

imprime_demog <- 
  function(){
    print( 'Demografia-Unicamp' )
  }

# Apos criar a funcao e carrega-la no ambiente R, podemos executa-la
imprime_demog()

# Agora vamos criar uma funcao que imprima uma entrada qualquer

imprime_entrada <- 
  function( entrada ){
    print( entrada )
  }

imprime_entrada() # erro! nao definiu o valor para entrada
imprime_entrada( 'teste' )
imprime_entrada( 1 )

## 4.3 Mais funcoes
# utiliza-se return( objeto ) para retornar o objeto daquela funcao
# calculadora: calculando o quadrado
quadrado <- 
  function( x ){
    quad <- x * x
    return( quad )
  }

quadrado( 2 ) 
quadrado( 5 )

# comparando
quadrado( 13452 ) == 13452 ^ 2

# 2a lei de newton F = m * a
newton <- 
  function( m, a ){
    Forca = m * a
    return( Forca )
  }

# conversor horas para minutos
convert_min <- 
  function( t_horas ){
    t_min <- t_horas * 60
    return( t_min )
  }

convert_min( 2 )

### EXERCICIO: crie um conversor de meses para anos

### EXERCICIO: crie um conversor que converta tempo em dias ou meses para anos
### Dica:
### 1) defina a funcao com dois parametros ( t e tipo )
### tipo = 'dias' ou tipo = 'meses'; t = valor (em dias ou meses)
### 2) use if e/ou else para checar o valor de tipo e definir qual operacao
### deve ser feita

### EXERCICIO: Interpolacao linear
## Considere a equação da reta: 
## Y - Y0 = s * (X - X0)
## ( X0,Y0 ) eh o nosso ponto 0, inicial
## ( X1, Y1 ) eh o nosso ponto final
## Suponha que nao temos o valor de s (inclinacao da reta), mas queremos
## encontrar um valor de Y* para um determinado X* seguindo a reta definida
## por (X0,Y0) e (X1,Y1). Como fazemos?
## Dica: 
## 1) primeiro calcular s pela relacao apresentada utilizando  
## (X0,Y0) e (X1,Y1)
## 2) em seguida, calcular Y* a partir de (X0,Y0) OU (X1,Y1), s e X*
######################################################

### Fim!

