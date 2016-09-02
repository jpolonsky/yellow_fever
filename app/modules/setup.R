# load modules
## sidebar
source('modules/disease.R')
# source('modules/filter.R')
source('modules/report.R')
## main page
source('modules/datatable.R')
# source('modules/zscore.R')
# source('modules/prevalence.R')
## graphics
# source('modules/colours.R')
# source('modules/fig_type.R')
# source('modules/plotly_dist.R')
source('modules/epicurve.R')

SetUp <- function(input, output, session, ...){
  
  panel_side <-
    list(
      actionButton("apply_filter", "Display/update data"), # filter button
      tags$style(type='text/css', "#apply_filter { background-color:LightGrey; }"),
      hr(),
      
      ## Filter modules
      hr(),
      DiseaseInput('id_disease'),
      
      hr(),
      
      ## Report
      hr(),
      # br(),
      ReportInput('id_report'),
      hr(),
      a(href = "http://www.who.int/nutrition/en/", img(src = "logo_who.jpg", width = "100%")),
      tags$a(href="mailto:borghie@who.int", "Comments & suggestions")
    )
  
  panel_main <-
    tabsetPanel(
      DFTableOutput('tmp'),
      EpiCurveOutput('tmp')
      # zscoreOutput('tmp'),
      # PrevalenceOutput('tmp')
    )
  
  list(panel_side, panel_main) %>% setNames(c('side', 'main'))
  
}
