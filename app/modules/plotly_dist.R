library(plotly)

PlotlyDistOutput <- function(id){
  ns <- NS(id)
  
  tabPanel(
    'Distributions', icon = icon("area-chart"),
    VariablesInput(ns('id_variables_x')),
    VariablesInput(ns('id_variables_strat_dist')),
    FigTypeInput(ns('id_fig_type')),
    plotlyOutput(ns('plotly_dist'), height = "600px"),
    
    # actionButton(ns('show_data_raw'), label = "Show z-score flags"),
    # shinyBS::bsModal(id = ns("modal_table"), title = "Raw data", trigger = "show_data_raw", size = "large",
    #                  DT::dataTableOutput(ns('table'))),
    
    style = 'width: 95%'
  )
  
}


PlotlyDist <- function(input, output, session, ...){
  
  # shinyBS::toggleModal(session, "modal_table", "open")
  # output$table <- DT::renderDataTable(df_filtered(), filter = 'top', options = list(paging = TRUE))
  
  x_choices <- reactive(c('age_group', list_map_vars[['weight']](), list_map_vars[['lenhei']]()))
  
  ## The observer below looks at when x_choices is changed and updates the options for the selectInput
  observe({
    variable_x <<- 
      callModule(Variables, 'id_variables_x', label = 'Variable', choices = x_choices(), selected = 'None')
    
    updateSelectInput(session, 'id_variables_x', choices = x_choices())
  })
  
  variable_strat_dist <- 
    callModule(Variables, 'id_variables_strat_dist', label = 'Stratification variable', selected = 'None')
  
  fig_type <- callModule(FigType, 'id_fig_type')
  
  output$plotly_dist <- renderPlotly({
    
    tmp <- df_filtered()
    
    if(variable_strat_dist() == 'None') {
      
      plot_tmp <- 
        
        if(fig_type()) {
          
          # density plot
          ggplot(tmp) +
            geom_density(aes(x = tmp[[variable_x()]], y = ..density..)) +
            theme_bw()
          
        } else {
          
          # bar plot
          ggplot(tmp) +
            geom_bar(aes(x = tmp[[variable_x()]])) +
            theme_bw() 
          
        }
      
    } else {
      
      tmp[[variable_strat_dist()]] <- factor(tmp[[variable_strat_dist()]], levels = unique(tmp[[variable_strat_dist()]]) %>% sort)
      
      plot_tmp <- 
        
        if(fig_type()) {
          
          # density plot
          ggplot(tmp) +
            geom_density(aes(x = tmp[[variable_x()]], y = ..density.., 
                             fill = factor(tmp[[variable_strat_dist()]])), alpha = 0.4) +
            theme_bw() +
            scale_fill_manual(
              name = variable_strat_dist(),
              values = colScheme(colour_selected())(length(tmp[[variable_strat_dist()]] %>% unique))
            )
          
        } else {
          
          # bar plot
          ggplot(tmp) +
            geom_bar(aes(x = tmp[[variable_x()]], fill = factor(tmp[[variable_strat_dist()]]))) +
            theme_bw() +
            scale_fill_manual(
              name = variable_strat_dist(),
              values = colScheme(colour_selected())(length(tmp[[variable_strat_dist()]] %>% unique))
            )
          
        }
      
    }
    
    plot_tmp %>% ggplotly()
    
  })
  
}

