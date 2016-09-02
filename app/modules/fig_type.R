FigTypeInput <- function(id){
  ns <- NS(id)
  
  checkboxInput(
    ns('fig_type'), 
    'Toggle bar/density chart'
  )
  
}

FigType <- function(input, output, session, ...) reactive(input$fig_type)
