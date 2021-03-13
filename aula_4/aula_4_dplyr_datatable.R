######################################################
### Curso Introducao ao R - 1s2021
### Programa de Pos-Graduacao em Demografia - Unicamp
### Instrutor: Jose H C Monteiro da Silva
### Aula 4
######################################################

### Parte 0: Preparando a area de trabalho #----------

## Uma boa pratica de programacao e fazer sempre a 
## limpeza da area de trabalho antes de iniciar a 
## execucao dos codigos

## remocao dos objetos
rm( list = ls( ) )

## fechar graficos abertos
graphics.off()

## carrega pacotes
require( dplyr )
require( data.table )

######################################################

### Parte 1: dplyr #----------------------------------

## dplyr eh um pacote do grupo tidyverse que eh amplamente utilizado
## na manipulacao de bases de dados por conta de sua praticidade

## 1.1 Comando %>% (pipe)

# o comando pipe eh usado para aplicar uma funcao em um objeto
x <- c( 5, 5, 5, 4, 9, 1, 0, 8 )

unique( x )
x %>% unique

sort( unique( x ) ) 
x %>% unique %>% sort
x %>% max

x %>% sum

## 1.2 Bases de dados
# voltemos a base de nascimentos da aula anterior
dat_nasc <- 
  read.csv( file = 'aula_3/nascimentos_populacao_uf.csv', # caminho do arquivo
            sep = ';'  # separador (no caso ponto e virgula)
  )

# podemos aplicar os filtros de ano com dplyr na funcao filter, de forma mais
# pratica:
dat_nasc %>%
  filter( ano == 2000 )

# modificar variaveis com mutate
dat_nasc %>%
  mutate( regcod  = ufcod %/% 10,
          regname = ifelse( regcod == 1, 
                            'Norte',
                            ifelse( regcod == 2,
                                    'Nordeste',
                                    ifelse( regcod == 3,
                                            'Sudeste',
                                            ifelse( regcod == 4,
                                                    'Sul',
                                                    'Centro-Oeste' ) ) ) ) ) 

# fazer calculos agregados com group_by e summarise
dat_nasc %>%
  group_by( ufcod, ano ) %>%
  summarise( total_nasc = sum( nascimentos ),
             total_pop  = sum( populacao ) )
######################################################

### Parte 2: data.table #-----------------------------

## como mencionado provavelmente varias vezes ao longo do curso,
## seu instrutor tem uma predilecao pelo data.table 
## motivos: velocidade de processamento e sintaxe mais simples

# podemos ler uma base diretamente para o formato data.table com a funcao
# fread

dat_nasc <- 
  fread( file = 'aula_3/nascimentos_populacao_uf.csv', # caminho do arquivo
         sep = ';'  # separador (no caso ponto e virgula)
  )

# ou fazemos setDT( dat_nasc ), tambem funciona

# filtros:
dat_nasc[ ano == 2000 & ufcod < 20 ]
dat_nasc[ ano == 2000  ]
dat_nasc[ ano == 2010 & ufcod > 30 & ufcod < 40 ]

# nova variavel:
dat_nasc[ , taxa_natalidade := 1000 * nascimentos / populacao ]
dat_nasc[ , regcod := ufcod %/% 10 ]

# calculos por grupos
dat_nasc[ , 
          list(
            total_nasc = sum( nascimentos ),
            total_pop  = sum( populacao )
            ),
          by = list( regcod, ano )
          ]

# merge de bases
# vamos separar as bases de populacao e nascimentos

nasc2000 <- 
  dat_nasc[ ano == 2000,
            list( ufcod, nascimentos ) ]

pop2000 <- 
  dat_nasc[ ano == 2000,
            list( ufcod,  populacao ) ]

# fazemos um merge das bases com o comando merge
merge(
  pop2000,
  nasc2000,
  by = 'ufcod'
)

# com mais de um identificador

nasc <- 
  dat_nasc[ , list( ufcod, ano, nascimentos ) ]

pop <- 
  dat_nasc[ , list( ufcod, ano,  populacao ) ]

merge(
  pop,
  nasc,
  by = c( 'ano', 'ufcod' )
)
######################################################
