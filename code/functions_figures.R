PlotBar <- function (data, xvar = "key", yvar = "value", fill = "fill_var", colscheme = "Blues",  yaxis = "", legend = "") {
  
  tmp <- 
    data %>%
    count_(vars = c(xvar, yvar)) %>%
    mutate(freq = n / sum(n))
  
  tmp[[xvar]] <- factor(tmp[[xvar]], levels = rev(unique(tmp[[xvar]])))
  # Convert NAs to "Unknown"
  tmp[[fill]][is.na(tmp[[fill]])] <- "Unknown"
  tmp[[fill]] <- factor(tmp[[fill]], levels = rev(unique(tmp[[fill]])))
  
  ggplot(tmp, aes_string(x = xvar, y = "n", fill = fill)) + 
    geom_bar(stat = "identity", colour = "black", size = .25) + 
    scale_fill_manual(
      values = colScheme(colscheme)(tmp[[fill]] %>% unique %>% length),
      guide = guide_legend(reverse = TRUE), # not working!
      na.value = 'lightgrey'
    ) +
    # scale_y_continuous(labels = scales::percent) +
    coord_flip() + 
    theme_bw() +
    theme(
      panel.border = element_blank(), 
      plot.title = element_text(size = 12, face = "bold", color = "darkblue"), 
      # legend.key = element_blank(),
      # legend.position = "",
      # legend.position = as.character(legend),
      axis.text = element_text(size = 7, angle = 0, hjust = 1, colour = "black"), 
      axis.title = element_text(size = 8, face = 'bold'),
      axis.ticks = element_blank()
    ) + 
    labs(title = "", x = "", y = yaxis)
  
}  

PlotlyBar <- function (data, xvar = "key", yvar = "value", fill = "fill_var", colscheme = "Blues",  yaxis = "", show_legend = TRUE, legend = "") {
  
  tmp <- 
    data %>%
    count_(vars = c(xvar, yvar)) %>%
    mutate(freq = n / sum(n))
  
  tmp[[xvar]] <- factor(tmp[[xvar]], levels = rev(unique(tmp[[xvar]])))
  # Convert NAs to "Unknown"
  tmp[[fill]][is.na(tmp[[fill]])] <- "Unknown"
  tmp[[fill]] <- factor(tmp[[fill]])
  
  gg <- 
    ggplot(tmp, aes_string(x = xvar, y = "n", fill = fill)) + 
    geom_bar(stat = "identity", colour = "black", size = .25) + 
    scale_fill_manual(
      values = colScheme(colscheme)(tmp[[fill]] %>% unique %>% length),
      # guide = guide_legend(reverse = TRUE), # not working!
      na.value = 'lightgrey'
    ) +
    # scale_y_continuous(labels = scales::percent) +
    coord_flip() + 
    theme_bw() +
    theme(
      panel.border = element_blank(), 
      plot.title = element_text(size = 12, face = "bold", color = "darkblue"), 
      # legend.key = element_blank(),
      # legend.position = "",
      # legend.position = as.character(legend),
      axis.text = element_text(size = 7, angle = 0, hjust = 1, colour = "black"), 
      axis.title = element_text(size = 8, face = 'bold'),
      axis.ticks = element_blank()
    ) + 
    labs(title = "", x = "", y = yaxis)
  
  ggplotly(gg, tooltip = c('x', 'fill', 'y')) %>% 
    layout(showlegend = show_legend)
  
}  

colScheme <- function(colscheme = 'Blues') {
  colorRampPalette(RColorBrewer::brewer.pal(9, colscheme))
}
