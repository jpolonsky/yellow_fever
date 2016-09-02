UploadInput <- function(id) {
  ns <- NS(id)
  fileInput(ns('data_upload'), 'Telecharger vos donnees', accept = c('.csv', '.MDB'))
}

Upload <- function(input, output, session, ...) reactive(input$data_upload)
