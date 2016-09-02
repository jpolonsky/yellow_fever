VariablesInput <- function(id){
  ns <- NS(id)
  
  uiOutput(ns("ui_variables"))
  
}

Variables <- function(input, output, session, label = NULL, multiple = FALSE, 
                      choices = c(names(df_raw()), 'None'), selected = NULL, ...) {
  
  output$ui_variables <- renderUI({
    ns <- session$ns
    
    selectInput(
      ns("slct_variables"), 
      label = label,
      selected = selected,
      choices = choices,
      multiple = multiple
    )
    
  })
  
  reactive(input$slct_variables)
  
}
