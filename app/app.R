# load packages
library(shiny)
library(dplyr)
library(ggplot2)

# # source the auxiliary functions
# source('code/functions_z.R')
# source('code/functions_prev.R')
# source('code/functions_figures.R')
# # source the core functions
# source('code/macro_z.R')
# source('code/macro_prev.R')

# source modules
source('modules/setup.R')
source('modules/upload.R')
source('modules/welcome.R')

# # source anthro standards
# source('code/standards.R')

## ui --------------------------------------------------------------------------
ui <- fluidPage(
  titlePanel('IDSR analyzer'), fluidRow(
    sidebarLayout(
      sidebarPanel(
        width = 2, 
        tags$style(type = "text/css", ".well {background-color: white; margin-left: 15px; margin-top: 40px;}"),
        UploadInput('tmp'),
        uiOutput('panel_side')
      ),
      mainPanel(
        width = 10, 
        tags$style(type = "text/css", ".row {margin-top: 15px;}"),
        uiOutput('panel_main')
      )
    )
  )
)


## server ----------------------------------------------------------------------
server <- function(input, output, session) {
  
  options(shiny.maxRequestSize = 50*1024^2) # increases upload size to 50MB
  session$onSessionEnded(stopApp)
  
  # initial setup
  data_uploaded <- callModule(Upload, 'tmp')
  
  # ui setup
  ui_setup <- callModule(SetUp, 'tmp')
  
  output$panel_side <- renderUI({
    data_uploaded() %>% need(message = FALSE) %>% validate
    ui_setup[['side']]
  })
  
  output$panel_main <- renderUI({
    if (data_uploaded() %>% is.null) callModule(Welcome, 'tmp')
    else ui_setup[['main']]
  })
  
  # call ui modules
  callModule(DFTable, 'tmp')
  callModule(EpiCurve, 'tmp')
  # callModule(zscore, 'tmp')
  # callModule(Prevalence, 'tmp')
  callModule(Report, 'id_report') # name is important here - links to setup.R
  
  # call colour picker module
  # colour_selected <<- callModule(ColourPicker, 'id_colour')
  disease_selected <<- callModule(Disease, 'id_disease')
  
  # upload data and return dataframes
  df <- reactive({
    
    inFile <- data_uploaded()
    if (is.null(inFile)) return()
    readr::read_csv(inFile$datapath)
    
  })
  
  ## this is an important step - can't easily work with df()
  df_raw <<- reactive(df())
  
  df_filtered <<- 
    reactive(
      df_raw() %>% 
        mutate(
          date = as.Date(DEBUTSEM, format = '%m/%d/%y'),
          month_year = format(date, "%b-%y"),
          month = lubridate::month(date, label = TRUE)
        ) %>% 
        filter(
          MALADIE %in% disease_selected(), 
          date <= Sys.Date(),
          date >= as.Date('2016-01-01')
        ) %>%
        select_(.dots = c('PROV', 'ZS', 'POP', 'date', 'month_year', 'month', 'MALADIE', 'TOTALCAS', 'TOTALDECES')) %>% 
        arrange(MALADIE, date)
    )
  
}

## run shinyapp ---------------------------------------------------------------
shinyApp(ui, server)
