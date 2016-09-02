SelectInput <- function(id, label = NULL){
  ns <- NS(id)
  
  uiOutput(ns("ui_select"))
  
}

Select <- function(input, output, session, label = NULL, selected = NULL, ...) {
  
  output$ui_select <- renderUI({
    ns <- session$ns
    
    selectInput(
      ns("slct_select"), 
      label = 'Select filters',
      selected = selected,
      choices = names(df_raw()),
      multiple = TRUE
    )
    
  })
  
  reactive(input$slct_select)
  
}
