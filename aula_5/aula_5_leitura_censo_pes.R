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

# cria um diretorio temporario para download dos dados
dir.create('aula_5/temp')

# download do zip com microdados do Amazonas
download.file( 
  url = 'https://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/AM.zip',
  destfile = 'aula_5/temp/AM.zip' 
)

# download do zip com microdados do Espirito Santo
download.file( 
  url = 'https://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/ES.zip',
  destfile = 'aula_5/temp/ES.zip' 
)

unzip( zipfile = 'aula_5/temp/AM.zip',
       exdir = 'aula_5/temp/' )
file.remove( 'aula_5/temp/AM.zip' )

unzip( zipfile = 'aula_5/temp/ES.zip',
       exdir = 'aula_5/temp/' )
file.remove( 'aula_5/temp/ES.zip' )

######################################################

### Parte 2: leitura base pessoas #-------------------

# leitura do arquivo xls com o layout (dicionario de variaveis)
layout_pes <- 
  read_excel( 'aula_5/Layout_microdados_Amostra.xls',
              sheet = 'PESS',
              skip = 1 ) %>%
  setDT

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


# ja filtramos aqui as variaveis que vamos usar
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
    file = 'aula_4/temp/ES/Amostra_Pessoas_32.txt',
    col_positions = pos_col_pes
  ) %>%
  setDT

### Parte 3: Manipulacao da base e ajuste de variaveis #-----
# ajuste de variaveis
dat_pes_es[ , peso_amostral := as.numeric( V0010 ) / 10 ^ 13 ]
dat_pes_es[ , sexo := ifelse( V0601 == 1, 'Homens', 'Mulheres' ) ]
dat_pes_es[ , idade := as.numeric( V6036 ) ]
dat_pes_es[ , idade5 := ifelse( idade >= 80, 80, idade - idade %% 5 ) ]
dat_pes_es[ , ufcod := V0001 ]

# calcula total populacional por idade e sexo
dat_pes_es <- 
  dat_pes_es[ , .( pop = sum( peso_amostral ) ), 
              .( ufcod, sexo, idade5 ) ]  %>%
  setorder( ufcod, sexo, idade5 )

dat_pes_es$pop %>% sum

######################################################