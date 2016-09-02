list_colours <- 
  RColorBrewer::brewer.pal.info %>% 
  subset(category %in% c("seq", "div")) %>% 
  rownames(.)

list_colours <- c( 'Blues', 'Spectral', 'YlOrRd')

ColourPickerInput <- function(id, selected = 'Blues'){
  ns <- NS(id)
  selectInput(ns('colours'), 'Colour Scheme', list_colours, selected = selected)
}

ColourPicker <- function(input, output, session, ...) reactive(input$colours)
