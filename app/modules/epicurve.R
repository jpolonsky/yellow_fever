library(plotly)

EpiCurveOutput <- function(id){
  ns <- NS(id)
  
  tabPanel(
    "Courbes epidemiologiques", icon = icon("bar-chart"),
    plotOutput(ns('epi_curve'), height = "600px")
    # textOutput(ns('text_miss'))
  )
  
}

EpiCurve <- function(input, output, session, ...){
  
  output$epi_curve <- 
    renderPlot({
      
      df_epi <- 
        # reactive(
          df_filtered() %>%
            group_by(MALADIE, PROV, month_year, month) %>%
            summarise(n = sum(TOTALCAS, na.rm = TRUE)) %>% 
            ungroup %>% 
            select(-month_year) %>% 
            arrange(MALADIE, PROV, month)
        # )
      
      p <- 
        ggplot(df_epi) +
        geom_bar(aes(x = month, y = n, fill = MALADIE), stat = 'identity') +
        theme_bw() +
        facet_wrap(~ PROV)
      
      p <- 
        ggplot(df_epi) +
        geom_line(aes(x = month, y = n, group = MALADIE, colour = MALADIE), stat = 'identity') +
        theme_bw() +
        facet_wrap(~ PROV)
      
      print(p)
      
    })
  
}

