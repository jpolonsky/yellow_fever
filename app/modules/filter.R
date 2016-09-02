FilterInput <- function(id, label = NULL){
  ns <- NS(id)
  
  uiOutput(ns("ui_filter"))
  
}

Filter <- function(input, output, session, label = NULL, selected = NULL, var_num = NULL, ...) {
  
  # this list of reactive values does the bookkeeping of input values
  in_memory_database <- reactiveValues()
  in_memory_database[["selected_filter_values"]] <- list()
  
  # this renders the global filters box
  output$ui_filter <- renderUI({
    # first we read the filters from the filter select box
    filters <- filter_variables()
    
    # in this slot we store the current selected value for each filter
    # this needs to happen as we have to redraw the UI elements whenever the filters are changed
    in_memory_database[["selected_filter_values"]] <-
      isolate(in_memory_database[["selected_filter_values"]][filters])
    
    # this stores the current filters; this is used in get_current_dataset() and triggers a reload
    in_memory_database[["current_filters"]] <- filters
    
    lapply(filters, function(name) {
      
      control_name <- paste0("filter_", name)
      row_values <- df_raw()[[name]]
      selected_value <- isolate(in_memory_database[["selected_filter_values"]][[name]])
      choices <- sort(unique(as.character(df_raw()[[name]])))
      selectInput(control_name, name, choices, multiple = TRUE, selected = selected_value)
      
    })
    
  })
  
  # # Observers
  # # Whenever a user selects a filter, this observer redraws the select boxes,
  # # keeping the previous entries in place!!
  # observe({
  #   # one observer per filter element
  #   filters <- filter_variables()
  #   
  #   # for each of the previous filters we had an observer
  #   # we first need to make sure these observers are being destroyed before creating new ones
  #   if (!is.null(isolate(in_memory_database[["filters_update_observers"]]))) {
  #     isolate(in_memory_database[["filters_update_observers"]]) %>% lapply(function(x) x$destroy())
  #   }
  #   
  #   # for each filter we create a new observer that takes care of the selected value bookkeeping
  #   in_memory_database[["filters_update_observers"]] <- filters %>% lapply(function (f) {
  #     element_name <- paste0("filter_", f)
  #     observe({
  #       in_memory_database[["selected_filter_values"]][[f]] <- input[[element_name]]
  #       in_memory_database[["filters_value_changed"]] <- Sys.time()
  #     })
  #   })
  # })
  # 
  # 
  # # filter the data only if the button is clicked
  # # data_tmp <- eventReactive(input$apply_filter, {
  # df_filtered <- eventReactive(input$apply_filter, {
  #   if (is.null(isolate(in_memory_database[["current_filters"]]))) {
  #     df_raw()
  #   } else {
  #     Reduce(f = function(dataset, filter_name) {
  #       filter_vals <- input[[paste0("filter_", filter_name)]]
  #       if (length(filter_vals) == 0 || is.null(filter_vals) ||
  #           is.na(filter_vals) || all(filter_vals == "")) {
  #         return(dataset)
  #       }
  #       eval(substitute(filter(dataset,
  #                              stringr::str_detect(col_name, filter_vals)),
  #                       list(col_name = as.symbol(filter_name))))
  #     }, init = df_raw(),
  #     x = isolate(in_memory_database[["current_filters"]]))
  #   }
  # })
  # 
  # 
  # output$test_table <-
  #   renderDataTable({
  #     input$apply_filter # trgger when clicked
  #     if (is.null(isolate(in_memory_database[["current_filters"]]))) {
  #       df_raw()
  #     } else {
  #       df_filtered()
  #       # filter_values()
  #     }
  #   })
  
  # selectInput(
  #   ns("slct_filter"),
  #   label = label,
  #   selected = selected,
  #   choices =
  #     if(filter_variables() %>% length > 0) df_raw()[[filter_variables()]] %>% unique
  #   # if(filter_variables() %>% length > 0) df_raw()[[filter_variables()[var_num]]] %>% unique
  #   else(NULL),
  #   multiple = TRUE
  # )
  #     
  # 
  # reactive(input$slct_filter)
  
}
