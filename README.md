# Introdução ao R - Demografia UNICAMP - 1s2021

**Responsável:** José H C Monteiro da Silva

**Local:** Google Meet

**Data:** 08-Março-2021 à 12-Março-2021

**Horário:** 20:00-22:00

# Proposta do curso

O curso tem como objetivo *apresentar* ferramentas básicas do R que possam ser úteis na área de demografia. 

A proposta inicial é dividir o curso em cinco etapas, sendo elas:

* Apresentação dos recursos e funções básicas do R e do RStudio;

* Introdução aos recursos básicos de programação (operadores lógicos, _loops_, criação de funções);

* Leitura e manipulação de bases de dados utilizando os recursos básicos do R;

* Introdução à manipulação de bases de dados utilizando o pacote `data.table`;

* Introdução à visualização de dados utilizando o pacote `ggplot2`.

Trabalharemos as duas últimas partes do curso de forma aplicada utilizando os [microdados do Censo Demográfico de 2010](https://ftp.ibge.gov.br/Censos/Censo_Demografico_2010/Resultados_Gerais_da_Amostra/Microdados/) e os [dados da COVID-19 divulgados pela Organização Mundial da Saúde](https://covid19.who.int/table).

# Materiais

### [Instalação e passos iniciais](https://github.com/josehcms/curso_introR_demografia_unicamp_1s2021/blob/main/aula_0/)

* [**aula_0**](https://github.com/josehcms/curso_introR_demografia_unicamp_1s2021/blob/main/aula_0/instalacao.md): passo a passo da instalação do **R** e **RStudio**

### Parte 1 - Introdução e conceitos básicos

* [**aula_1**](https://github.com/josehcms/curso_introR_demografia_unicamp_1s2021/blob/main/aula_1/aula_1_intro.R): funcionalidades básicas.

### Parte 2 - Ferramentas básicas de programação

* [**aula_2**](https://github.com/josehcms/curso_introR_demografia_unicamp_1s2021/blob/main/aula_2/aula_2_programacao_basica.R): operadores lógicos, condicionais, _loops_ e funcções.

### Parte 3 - Leitura e manipulação de bases de dados

* [**aula_3**](https://github.com/josehcms/curso_introR_demografia_unicamp_1s2021/blob/main/aula_3/aula_3_manipulacao_bases_df.R): introdução aos comandos básicos de manipulação de bases de dados.

### Parte 4 - Manipulação de bases de dados com `data.table` 

* [**aula_4**](https://github.com/josehcms/curso_introR_demografia_unicamp_1s2021/blob/main/aula_4/aula_4_dplyr_datatable.R): introdução aos comandos de manipulação e filtragem de bases de dados usando os pacotes `dplyr` e `data.table`.

### Parte 5 - Visualização de dados com `ggplot2`

* [**aula_5**](https://github.com/josehcms/curso_introR_demografia_unicamp_1s2021/blob/main/aula_5): leitura de dados do Censo Demográfico de 2010 utilizando os pacotes `readr`, `dplyr` e `data.table`; construção de pirâmide etária com o pacote `ggplot2`.

# Referências

A parte introdutória do curso (Partes 1 a 3) foi inspirada nos materiais de [Leonardo Barone](https://github.com/leobarone) e na apostila [Introdução ao uso do programa R](https://cran.r-project.org/doc/contrib/Landeiro-Introducao.pdf) de [Victor Lemes Landeiro](https://sites.google.com/site/vllandeiror/).

As partes 4 e 5 foram pensadas a partir de experiência própria lidando com manipulação de bases e com os dados do Censo Demográfico de 2010.

