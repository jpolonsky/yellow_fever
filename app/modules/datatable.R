DFTableOutput <- function(id){
  ns <- NS(id)
  
  tabPanel(
    'Dataset', icon = icon("table"),
    tags$style(type = "text/css", ".row {margin-top: 15px;}"),
    tags$head(tags$style("tfoot {display: table-header-group;}")),
    
    DT::dataTableOutput(ns('table')),
    style = 'width: 95%'
  )
  
}

DFTable <- function(input, output, session, ...){
  
  output$table <- DT::renderDataTable(df_filtered(), options = list(paging = TRUE, pageLength = 10))

}
