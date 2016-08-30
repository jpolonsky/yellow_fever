library(dplyr)
library(ggplot2)
library(plotly)
source('code/functions_figures.R')

filename <- dir('data', full.names = TRUE) %>% stringr::str_subset('.mdb')
df <- Hmisc::mdb.get(filename) %>% tbl_df

# df_classification_by_province <- 
#   df %>%
#   count(ProvinceOfresidence, FinalClassification) %>%
#   mutate(freq = n / sum(n) * 100)
# 
# PlotBar(
#   data = df, xvar = 'ProvinceOfresidence', yvar = 'FinalClassification', 
#   fill = 'FinalClassification', yaxis = '# cases by final classification', colscheme = 'Blues'
# )
# 
# PlotlyBar(
#   data = df, xvar = 'ProvinceOfresidence', yvar = 'FinalClassification', 
#   fill = 'FinalClassification', yaxis = '# cases by final classification', colscheme = 'Blues', show_legend = TRUE
# )


df %>%
  filter(FinalClassification == 1) %>% 
  count(Categorisation) %>%
  mutate(freq = n / sum(n) * 100)

PlotBar(
  data = df, xvar = 'Categorisation', yvar = 'FinalClassification', 
  fill = 'FinalClassification', yaxis = '# cases by final classification', colscheme = 'Blues'
)

df %>% filter(Labid %in% '16FJ2393')
df %>% filter(IdNumber %in% 'RDC-KIN-LIM-16-086')
