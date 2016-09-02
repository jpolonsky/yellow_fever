zscoreOutput <- function(id){
  ns <- NS(id)
  
  tabPanel(
    'z-scores', icon = icon("sort-amount-asc"),
    
    fluidRow(
      
      shinyjs::useShinyjs(),
      
      actionButton(
        ns('button_z'), 
        label = "Click to calculate z-scores"),
      
      shinyjs::disabled(
        downloadButton(
          ns('dl_zscore'), 
          label = "Download z-scores")
      ),
      
      shinyjs::disabled(
        actionButton(
          ns('show_zdist'), 
          label = "Show z-score distribution")
      ),
      
      shinyjs::disabled(
        actionButton(
          ns('show_flags'), 
          label = "Show z-score flags")
      ),
      
      tags$style(type='text/css', "#dl_zscore {background-color:LightGrey; float:right; margin-bottom: 15px;}"),
      tags$head(tags$style("tfoot {display: table-header-group;}"))
    ),
    
    dataTableOutput(ns('z')),
    
    # shinyBS::bsModal(id = ns("modal_zdist"), title = "z-score distributions", trigger = "show_zdist", size = "large",
    VariablesInput(ns('id_variables_strat_z')),
    plotlyOutput(ns('plotly_zdist'), height = "600px")
    # uiOutput(ns("ui_z"))
    # )
    ,
    
    # shinyBS::bsModal(id = ns("modal_flag"), title = "% flagged z-scores", trigger = "show_flags", size = "large",
    plotlyOutput(ns('plotly_flag'), height = "600px")
    # )
    ,
    
    style = 'width: 95%'
  )
  
}

zscore <- function(input, output, session, ...){
  
  variable_strat_z <- 
    callModule(Variables, 'id_variables_strat_z', label = 'Stratification variable', selected = 'None')
  
  # Run z-score calculations
  ## Only run calculations once button explicitly pressed
  observeEvent(input$button_z, {
    
    withProgress(
      message = 'Calculation in progress',
      value = 0.1, {
        
        df_zscores <<- 
          CalculateZScores(
            data = df_filtered(),
            sex = list_map_vars[['sex']](), age = list_map_vars[['age']](), 
            age.month = FALSE, weight = list_map_vars[['weight']](), 
            lenhei = list_map_vars[['lenhei']](), 
            lenhei_unit = list_map_vars[['lenhei_unit']](), sw = list_map_vars[['sw']](), 
            cluster = list_map_vars[['cluster']](), strata = list_map_vars[['strata']](), 
            typeres = list_map_vars[['typeres']](), gregion = list_map_vars[['gregion']](), 
            wealthq = list_map_vars[['wealthq']](), mothered = list_map_vars[['mothered']](), 
            othergr = list_map_vars[['othergr']](), headc = list_map_vars[['headc']](), 
            armc = list_map_vars[['armc']](), triskin = list_map_vars[['triskin']](), 
            subskin = list_map_vars[['subskin']](), oedema = list_map_vars[['oedema']]()
          ) %>% 
          select(-uid)
        
        incProgress(0.5)
        
        output$z <- renderDataTable(df_zscores, options = list(paging = TRUE, pageLength = 10))
        
        
      }) 
    
  })
  
  # Download table
  ## Only enable download button once z-score calculation button has been clicked
  # shinyjs::toggleState("dl_zscore", condition = exists('df_zscores'))
  observeEvent(input$button_z, {
    shinyjs::enable("dl_zscore") 
    shinyjs::enable("show_zdist")
    shinyjs::enable("show_flags")
  })
  
  output$dl_zscore <- downloadHandler(
    filename <- 'z_scores.csv',
    # content <- function(file) write.csv(df_zscores, file, row.names = FALSE)
    content <- function(file) readr::write_csv(df_zscores, file)
  )
  
  # Display z-score flags
  # observeEvent(input$button_z, shinyjs::enable("show_flags"))
  # observeEvent(input$show_flags, shinyBS::toggleModal(session, "modal_plot", "open"))
  
  observeEvent(input$show_zdist, {

    # shinyBS::toggleModal(session, "modal_zdist", "open")
    shinyjs::show('id_variables_strat_z') # doesn't work - may need renderUI!
    shinyjs::show('plotly_zdist')
    shinyjs::hide('plotly_flag')

    output$plotly_zdist <- renderPlotly({
    
      if(variable_strat_z() == 'None') {

        df_zdist <-
          CalculateZScores(
            data = df_filtered(), sex = list_map_vars[['sex']](), age = list_map_vars[['age']](),
            age.month = FALSE, weight = list_map_vars[['weight']](),
            lenhei = list_map_vars[['lenhei']](),
            lenhei_unit = list_map_vars[['lenhei_unit']](), sw = list_map_vars[['sw']](),
            cluster = list_map_vars[['cluster']](), strata = list_map_vars[['strata']](),
            typeres = list_map_vars[['typeres']](), gregion = list_map_vars[['gregion']](),
            wealthq = list_map_vars[['wealthq']](), mothered = list_map_vars[['mothered']](),
            othergr = list_map_vars[['othergr']](), headc = list_map_vars[['headc']](),
            armc = list_map_vars[['armc']](), triskin = list_map_vars[['triskin']](),
            subskin = list_map_vars[['subskin']](), oedema = list_map_vars[['oedema']]()
          ) %>%
          select(one_of(stringr::str_subset(names(.), '^z'))) %>%
          .[!grepl('flag', names(.))] %>%
          tidyr::gather(key, value)

        (ggplot(df_zdist) +
            geom_density(aes(x = value, y = ..density..), alpha = 0.4) +
            theme_bw() +
            facet_wrap(~ key)
        ) %>% ggplotly()

      } else {

        df_zdist <-
          CalculateZScores(
            data = df_filtered(), sex = list_map_vars[['sex']](), age = list_map_vars[['age']](),
            age.month = FALSE, weight = list_map_vars[['weight']](),
            lenhei = list_map_vars[['lenhei']](),
            lenhei_unit = list_map_vars[['lenhei_unit']](), sw = list_map_vars[['sw']](),
            cluster = list_map_vars[['cluster']](), strata = list_map_vars[['strata']](),
            typeres = list_map_vars[['typeres']](), gregion = list_map_vars[['gregion']](),
            wealthq = list_map_vars[['wealthq']](), mothered = list_map_vars[['mothered']](),
            othergr = list_map_vars[['othergr']](), headc = list_map_vars[['headc']](),
            armc = list_map_vars[['armc']](), triskin = list_map_vars[['triskin']](),
            subskin = list_map_vars[['subskin']](), oedema = list_map_vars[['oedema']]()
          ) %>%
          select_(variable_strat_z(), .dots = stringr::str_subset(names(.), '^z')) %>%
          ## NB. the below is an alternative approach worth remembering!
          # select(get(variable_strat_z()), one_of(stringr::str_subset(names(.), '^z'))) %>%
          .[!grepl('flag', names(.))] %>%
          tidyr::gather(key, value, -get(variable_strat_z()))

        (ggplot(df_zdist) +
            geom_density(aes(x = value, y = ..density..,
                             fill = factor(df_zdist[[variable_strat_z()]])), alpha = 0.4) +
            theme_bw() +
            facet_wrap(~ key)
        ) %>% ggplotly()

      }

    })

  })
  
  
  observeEvent(input$show_flags, {
    
    # shinyBS::toggleModal(session, "modal_flag", "open")
    shinyjs::show('plotly_flag')
    shinyjs::hide('plotly_zdist')
    shinyjs::hide('id_variables_strat_z')
    
    output$plotly_flag <- renderPlotly({
      
      df_flags <<- 
        CalculateZScores(
          data = df_filtered(), sex = list_map_vars[['sex']](), age = list_map_vars[['age']](), 
          age.month = FALSE, weight = list_map_vars[['weight']](), 
          lenhei = list_map_vars[['lenhei']](), 
          lenhei_unit = list_map_vars[['lenhei_unit']](), sw = list_map_vars[['sw']](), 
          cluster = list_map_vars[['cluster']](), strata = list_map_vars[['strata']](), 
          typeres = list_map_vars[['typeres']](), gregion = list_map_vars[['gregion']](), 
          wealthq = list_map_vars[['wealthq']](), mothered = list_map_vars[['mothered']](), 
          othergr = list_map_vars[['othergr']](), headc = list_map_vars[['headc']](), 
          armc = list_map_vars[['armc']](), triskin = list_map_vars[['triskin']](), 
          subskin = list_map_vars[['subskin']](), oedema = list_map_vars[['oedema']]()
        ) %>% 
        select(-uid) %>% 
        select(one_of(stringr::str_subset(names(.), 'flag'))) %>% 
        # summarise_each(funs(sum(. == 1, na.rm = TRUE))) %>% 
        summarise_each(funs(sum(. == 1, na.rm = TRUE)/n()*100)) %>% 
        plyr::ldply() %>% 
        setNames(c('key', 'value')) %>% 
        tbl_df
      
      PlotBar(data = df_flags, xvar = 'key', yvar = 'value', 
              yaxis = '% flagged', colscheme = colour_selected()) %>% 
        ggplotly(tooltip = c('x', 'y')) %>% 
        layout(showlegend = FALSE)
      
    })
    
  })
  
}

