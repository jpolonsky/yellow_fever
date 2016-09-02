library(dplyr)
library(ggplot2)
library(plotly)
source('app/code/functions_figures.R')

filename <- dir('app/data', full.names = TRUE) %>% stringr::str_subset('.mdb')
df <- Hmisc::mdb.get(filename) %>% tbl_df
df %>% glimpse

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

df$DateOfonset <- as.Date(df$DateOfonset, format = '%m/%d/%y')

ggplot(filter(df, FinalClassification %in% 1)) +
  geom_bar(aes(x = DateOfonset))

# df %>% filter(Labid %in% '16FJ2393')
# df %>% filter(IdNumber %in% 'RDC-KIN-LIM-16-086')

df %>%
  filter(!FinalClassification %in% 1) %>%
  # group_by(FinalClassification) %>%
  count(Outcome) %>%
  mutate(freq = n / sum(n) * 100)



## Delay distributions
df$DateOfonset <- as.Date(df$DateOfonset, format = '%m/%d/%y')
df$DateSeenHealthFacility <- as.Date(df$DateSeenHealthFacility, format = '%m/%d/%y')
df$DateSpecimencollected <- as.Date(df$DateSpecimencollected, format = '%m/%d/%y')
df$DateSpecimenSenttolab <- as.Date(df$DateSpecimenSenttolab, format = '%m/%d/%y')
df$DateLabReceivedSpecimen <- as.Date(df$DateLabReceivedSpecimen, format = '%m/%d/%y')
df$DateLabSentresulttodistrict <- as.Date(df$DateLabSentresulttodistrict, format = '%m/%d/%y')

df_epi <- 
  df %>% 
  mutate(
    delay_onset_facility = DateSeenHealthFacility - DateOfonset,
    delay_facility_collect = DateSpecimencollected - DateSeenHealthFacility,
    delay_collect_lab = DateSpecimenSenttolab - DateSpecimencollected,
    delay_lab_received = DateLabReceivedSpecimen - DateSpecimenSenttolab, 
    delay_received_results = DateLabSentresulttodistrict - DateLabReceivedSpecimen,
    delay_total = DateLabSentresulttodistrict - DateOfonset
  ) %>% 
  select(
    one_of('ProvinceOfresidence', 'Urbanrural'),
    starts_with('delay_')
  )

ggplot(
  filter(df_epi, delay_onset_facility >= 0)
) +
  # geom_jitter(aes(x = ProvinceOfresidence, y = delay_onset_facility, colour = ProvinceOfresidence)) +
  geom_jitter(aes(x = Urbanrural, y = delay_onset_facility, colour = Urbanrural), width = .3) +
  facet_wrap(~ ProvinceOfresidence) +
  theme_bw() +
  coord_flip()



df_epi_long <- 
  df %>% 
  filter(
    ProvinceOfresidence %in% c('Kwango', 'Kinshasa', 'KINSHASA', 'Kongo Central')
  ) %>% 
  mutate(
    delay_onset_facility = DateSeenHealthFacility - DateOfonset,
    delay_facility_collect = DateSpecimencollected - DateSeenHealthFacility,
    delay_collect_lab = DateSpecimenSenttolab - DateSpecimencollected,
    delay_lab_received = DateLabReceivedSpecimen - DateSpecimenSenttolab, 
    delay_received_results = DateLabSentresulttodistrict - DateLabReceivedSpecimen,
    delay_total = DateLabSentresulttodistrict - DateOfonset
  ) %>% 
  select(
    one_of('ProvinceOfresidence', 'Urbanrural'),
    starts_with('delay_')
  ) %>% 
  tidyr::gather(key, value, starts_with('delay'))

p <- 
  ggplot(
    filter(df_epi_long, value < 200, value >=0)
  ) +
  geom_jitter(aes(x = key, y = value, colour = Urbanrural)) +
  facet_wrap(~ ProvinceOfresidence) +
  # geom_jitter(aes(x = Urbanrural, y = value, colour = ProvinceOfresidence), width = .4, alpha = 0.6) +
  # facet_wrap(~ key) +
  theme_bw() +
  coord_flip()

plotly::ggplotly(p)


(
  ggplot(
    filter(df_epi_long, value < 200, value >=0)
  ) +
    geom_density(aes(x = value, y = ..density.., fill = key), alpha = 0.5) +
    facet_wrap(~ ProvinceOfresidence) +
    theme_bw()
) %>% 
  plotly::ggplotly()

