Welcome <- function(input, output, session){
  
  paste("Bienvenue au...", 
        "Please upload your dataset using the Upload Data button", 
        img(src = "arrow.png", width = "5%"),
        sep = '<br/>') %>% 
    HTML
  
}
