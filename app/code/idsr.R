library(dplyr)
# library(magrittr)
library(tidyr)
# library(lubridate)
library(ggplot2)
# library(plotly)
# source('code/functions_figures.R')

filename <- dir('app/data', full.names = TRUE) %>% stringr::str_subset('.MDB')
df <- Hmisc::mdb.get(filename) %>% tbl_df
# df %>% write.csv(paste0('df_', Sys.Date(), '.csv'))
glimpse(df)

unique(df$MALADIE)

# df %>% filter(MALADIE %in% c('FIEVRE JAUNE', 'CHOLERA')) %>% write.csv(paste0('df_', Sys.Date(), '.csv'))

df_tmp <- 
  df %>% 
  mutate(
    date = as.Date(DEBUTSEM, format = '%m/%d/%y'),
    month_year = format(date, "%b-%y"),
    month = lubridate::month(date, label = TRUE)
  ) %>% 
  filter(
    MALADIE %in% c('FIEVRE JAUNE', 'CHOLERA'), 
    date <= Sys.Date(),
    date >= as.Date('2016-01-01')
  ) %>%
  select_(.dots = c('PROV', 'ZS', 'POP', 'date', 'month_year', 'month', 'MALADIE', 'TOTALCAS', 'TOTALDECES')) %>% 
  arrange(MALADIE, date)

df_tmp2 <- 
  df_tmp %>% 
  group_by(MALADIE, PROV, month_year, month) %>%
  summarise(n = sum(TOTALCAS, na.rm = TRUE)) %>% 
  ungroup %>% 
  select(-month_year) %>% 
  arrange(MALADIE, PROV, month)

p <- 
  ggplot(df_tmp2) +
  geom_bar(aes(x = month, y = n, fill = MALADIE), stat = 'identity') +
  theme_bw() +
  facet_wrap(~ PROV)

p
# ggplotly(p, tooltip = c('fill', 'x', 'y')) %>% layout(showlegend = FALSE)

# ggplot(df_tmp2) +
#   geom_line(aes(x = month, y = n, group = paste0(PROV, MALADIE), colour = MALADIE), stat = 'identity') +
#   theme_bw() 

p <- 
  ggplot(df_tmp2) +
  geom_line(aes(x = month, y = n, group = MALADIE, colour = MALADIE), stat = 'identity') +
  theme_bw() +
  facet_wrap(~ PROV)

p
# ggplotly(p, tooltip = c('group', 'x', 'y')) %>% layout(showlegend = FALSE)


df_tmp2 %>% 
  tidyr::spread(key = month, value = n, fill = 0) %>% 
  knitr::kable()



df %>% 
  filter(MALADIE %in% 'FIEVRE JAUNE') %>% 
  # select(TOTALDECES) %>%
  select(TOTALCAS) %>%
  sum(na.rm = T)

