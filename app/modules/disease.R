DiseaseInput <- function(id){
  ns <- NS(id)
  
  checkboxGroupInput(
    ns('disease'), 
    'Maladie(s):', 
    choices = c('FIEVRE JAUNE', 'CHOLERA'),
    selected = c('FIEVRE JAUNE', 'CHOLERA')
  )
  
}

Disease <- function(input, output, session, ...) reactive(input$disease)
