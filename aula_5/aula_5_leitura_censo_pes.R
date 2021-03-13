######################################################
### Curso Introducao ao R - 1s2021
### Programa de Pos-Graduacao em Demografia - Unicamp
### Instrutor: Jose H C Monteiro da Silva
### Aula 5
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
install.packages( c( 'tidyverse', 'readxl', 'data.table' ) )
require( dplyr ) # para manipulacao de bases
require( data.table ) # para manipulacao de bases
require( readr ) # para leitura de bases
require( readxl ) # para leitura de arquivos xls e xlsx

######################################################

### Parte 1: Download dos dados #--------------------

## Os microdados do censo demografico de 2010 podem ser encontrados no caminho
## https://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/

## Recomendo fortemente a leitura da documentacao, para entender como cada 
## variavel eh construida e categorizada

## no arquivo Documentacao, na pasta layout, tem-se o dicionario das variaveis
## com a descricao de cada variavel


getwd()
setwd("REPOSITORIO ONDE ESTAO OS DADOS")

# cria um diretorio temporario para download dos dados
dir.create('temp')

# download do zip com microdados do Amazonas
download.file( 
  url = 'https://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/AM.zip',
  destfile = 'temp/AM.zip' 
)

# download do zip com microdados do Espirito Santo
download.file( 
  url = 'https://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/DF.zip',
  destfile = 'temp/DF.zip' 
)

unzip( zipfile = 'temp/AM.zip',
       exdir = 'temp' )
#file.remove( 'temp/AM.zip' )

unzip( zipfile = 'temp/ES.zip',
       exdir = 'temp' )
#file.remove( 'temp/ES.zip' )

######################################################

### Parte 2: leitura base pessoas #-------------------

# leitura do arquivo xls com o layout (dicionario de variaveis)
layout_pes <- 
  read_excel( 'Layout_microdados_Amostra.xls',
              sheet = 'PESS',
              skip = 1 ) %>%
  setDT

View(layout_pes)
# ajusta base de dados e nomes de variaveis
layout_pes <- 
  layout_pes[ , 
              list(
                var = VAR,
                pos_inicial = `POSIÇÃO INICIAL`,
                pos_final   = `POSIÇÃO FINAL`,
                inteiros    = INT,
                decimais    = DEC
              ) ]

View(layout_pes)

# ja filtramos aqui as variaveis que vamos usar
# V0001: codigo UF 
# V0300: controle 
# V0010: peso amostral ( 13 digitos decimais )
# V0601: sexo ( 1 - masc, 2 - fem )
# V6036: idade em anos

layout_pes <- 
  layout_pes[ var %in% c( 'V0001', 'V0300', 'V0010', 'V0601', 'V6036' ) ]

# primeiro utiliza-se a funcao fwf_positions para definir inicio e fim
# de cada variavel
pos_col_pes <- 
  fwf_positions( start = layout_pes$pos_inicial, 
                 end   = layout_pes$pos_final, 
                 col_names = layout_pes$var 
  )

# leitura da base
dat_pes_es <- 
  read_fwf( 
    file = 'temp/ES/Amostra_Pessoas_32.txt',
    col_positions = pos_col_pes
  ) %>%
  setDT

### Parte 3: Manipulacao da base e ajuste de variaveis #-----
# ajuste de variaveis
dat_pes_es[ , peso_amostral := as.numeric( V0010 ) / ( 10 ^ 13 ) ]
dat_pes_es[ , sexo := ifelse( V0601 == 1, 
                              'Homens', 
                              'Mulheres' ) ]
dat_pes_es[ , idade := as.numeric( V6036 ) ]

dat_pes_es[ , idade5 := ifelse( idade >= 80, 80, idade - idade %% 5 ) ]

dat_pes_es[ , ufcod := V0001 ]

# calcula total populacional por idade e sexo
tab_pes_es <- 
  dat_pes_es[ , 
              list( pop = sum( peso_amostral ) ), 
              by = list( ufcod, sexo, idade5 ) ]  %>%
  setorder( ufcod, sexo, idade5 )

tab_pes_es$pop %>% sum

######################################################

### Graficos 

# Plot eh a funcao basica de graficos do R
plot( 
  x = tab_pes_es[sexo == 'Mulheres']$idade5, # eixo x idade
  y = tab_pes_es[sexo == 'Mulheres']$pop,    # eixo y populacao
  type = 'l', # tipo l (linhas)
  col = 'red' # cor vermelha
  )
# adiciona linhas ao grafico atual com o comando lines
# se der outro plot ele cria outro arquivo plot
lines( 
  x = tab_pes_es[ sexo == 'Homens' ]$idade5, # eixo x idade
  y = tab_pes_es[ sexo == 'Homens' ]$pop,    # eixo y populacao
  type = 'l',  # tipo l (linhas)
  col = 'blue' # cor azul
  )

### Fazemos agora com ggplot
require( ggplot2 )

# Para fazer a piramide etaria primeiro calculamos
# a distribuicao etaria da populacao 
# percentual de pessoas em cada grupo etario
tab_pes_es[ , pop_perc := 100 * pop / sum( pop ) ]
# colocamos os homens no lado esquerdo do eixo (negativo)
tab_pes_es[ sexo == 'Homens', pop_perc := - pop_perc ]

# criamos o ggplot com linhas e pontos
# usar o + para adicionar elementos ao grafico 
# (ajustar escala, cor, adicionar pontos )
ggplot( tab_pes_es ) +
  # geom_point para pontos
  # em aes definem as coordenadas 
  # e se quiser aloca elementos do grafico a uma variavel especifica
  # color, shape (tipo de ponto), linetype (tipo de linha)
  # color no caso vai variar conforme o sexo (Homens e Mulheres)
  geom_point( aes( x = idade5, 
                   y = pop_perc, 
                   color = sexo ) ) +
  # geom_line para linhas
  # em aes definem as coordenadas 
  # e se quiser aloca elementos do grafico a uma variavel especifica
  # color, shape (tipo de ponto), linetype (tipo de linha)
  # color no caso vai variar conforme o sexo (Homens e Mulheres)
  geom_line( aes( x = idade5, 
                  y = pop_perc, 
                  color = sexo ) ) +
  coord_flip() + # inverte o eixo
  # vamos ajustar o eixo x - percentual da populacao
  # breaks para os pontos que queremos apresentar no grafico
  # labels para como esses pontos serao representados
  # limit para o limite xmax e xmin
  scale_y_continuous( breaks = seq( -5, 5, 0.5 ), # -5, -4.5, ... 0,..., 4.5, 5
                      labels = abs( seq( -5, 5, 0.5 ) ), # valor em modulo 
                      limits = c( -5, 5 ),
                      name   = 'População (%)'
                      ) +
  scale_x_continuous( breaks = seq( 0, 80, 5 ),
                      name   = 'Idade (grupos quinquenais)' ) +
  labs( title = 'Piramide Etaria - Espirito Santo, 2010',
        subtitle = 'Fonte: IBGE, Censo Demografico 2010' ) +
  theme_bw() # tema simples black and white


######################################################
