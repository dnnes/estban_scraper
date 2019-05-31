library(httr)
library(rvest)

estban <- httr::GET("https://www4.bcb.gov.br/fis/cosif/estban.asp?frame=1")
html_estban <- content(estban, 'text')

xpath = '//label [@for="ESTBAN_MUNICIPIO"]'

lista_dados <- read_html(html_estban) %>% 
  rvest::html_nodes(xpath = '//*[@id = "ESTBAN_MUNICIPIO"]') %>%
  rvest::html_nodes('option') %>% 
  rvest::html_attr('value') 
  

substr(lista_dados, start = 34, stop = 50)

paste0('https://www4.bcb.gov.br',lista_dados)
download.file(paste0('https://www4.bcb.gov.br',lista_dados) %>% head(), mode = "wb")
