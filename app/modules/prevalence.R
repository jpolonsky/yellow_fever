PrevalenceOutput <- function(id){
  ns <- NS(id)
  
  tabPanel(
    'Prevalence', icon = icon("bar-chart"),
    
    fluidRow(
      
      shinyjs::useShinyjs(),
      
      shinyjs::disabled(
        actionButton(
          ns('button_prev'), 
          label = "Click to calculate prevalences")
      ),
      
      shinyjs::disabled(
        downloadButton(
          ns('dl_prevalence'), 
          label = "Download prevalences")
      ),
      
      tags$style(type='text/css', "#dl_prevalence {background-color:LightGrey; float:right; margin-bottom: 15px;}")
    ),
    
    DT::dataTableOutput(ns('prev')),
    style = 'width: 95%'
  )
  
}

Prevalence <- function(input, output, session, ...){
  
  # Run prevalence calculations
  ## Only enable calculation button once z-score calculation button has been clicked
  observeEvent(input$button_z, shinyjs::enable("button_prev"))
  
  ## Only run calculations once button explicitly pressed 
  observeEvent(input$button_prev, {
    
    withProgress(message = 'Calculation in progress',
                 detail = 'Please be patient - This may take a while...',
                 value = 0.1, {
                   
                   df_prevs <<- 
                     # CalculatePrev(data = df_zscores, sex = sex(), age = age(), age.month = FALSE, 
                     #               weight = weight(), lenhei = lenhei(), lenhei_unit = lenhei_unit(), 
                     #               sw = sw(), cluster = cluster(), strata = strata(), typeres = typeres(), 
                     #               gregion = gregion(), wealthq = wealthq(), mothered = mothered(), othergr = othergr(),
                     #               headc = headc(), armc = armc(), triskin = triskin(), subskin = subskin(), oedema = oedema()
                     CalculatePrev(
                       data = df_zscores, sex = list_map_vars[['sex']](), 
                       age = list_map_vars[['age']](), age.month = FALSE, 
                       weight = list_map_vars[['weight']](), lenhei = list_map_vars[['lenhei']](), 
                       lenhei_unit = list_map_vars[['lenhei_unit']](), sw = list_map_vars[['sw']](), 
                       cluster = list_map_vars[['cluster']](), strata = list_map_vars[['strata']](), 
                       typeres = list_map_vars[['typeres']](), gregion = list_map_vars[['gregion']](), 
                       wealthq = list_map_vars[['wealthq']](), mothered = list_map_vars[['mothered']](), 
                       othergr = list_map_vars[['othergr']](), headc = list_map_vars[['headc']](), 
                       armc = list_map_vars[['armc']](), triskin = list_map_vars[['triskin']](), 
                       subskin = list_map_vars[['subskin']](), oedema = list_map_vars[['oedema']]()
                     )
                   
                   incProgress(0.5)
                   
                   output$prev <- 
                     DT::renderDataTable(df_prevs, options = list(paging = FALSE))
                   
                 })
    
  })
  
  
  # Download table
  ## Only enable download button once z-score calculation button has been clicked
  observeEvent(input$button_prev, shinyjs::enable("dl_prevalence"))
  
  output$dl_prevalence <- downloadHandler(
    filename <- 'prevalences.csv',
    # content <- function(file) write.csv(df_prevs, file, row.names = FALSE)
    content <- function(file) readr::write_csv(df_prevs, file)
  )
  
  
}

