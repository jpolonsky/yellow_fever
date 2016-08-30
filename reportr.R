require( ggplot2 )
doc = docx( title = 'My document' )

doc = addTitle( doc , 'First 5 lines of iris', level = 1)
doc = addFlexTable( doc , vanilla.table(iris[1:5, ]), 
                    layout.properties= get.light.tableProperties())

doc = addTitle( doc , 'ggplot2 example', level = 1)
myggplot = qplot(Sepal.Length, Petal.Length, data = iris, color = Species, size = Petal.Width )
doc = addPlot( doc = doc , fun = print, x = myggplot )

doc = addTitle( doc , 'Text example', level = 1)
doc = addParagraph( doc, 'My tailor is rich.', stylename = 'Normal' )

writeDoc( doc, 'files/gettingstarted/my_first_doc.docx' )


###
library( ReporteRs )
require( ggplot2 )
require( magrittr )

mydoc <- pptx( title = "title" )

# Add a Title slide ------------------
mydoc <- mydoc %>% 
  addSlide( slide.layout = "Title Slide" ) %>% 
  addTitle( "Presentation title" ) %>% #set the main title
  addSubtitle( "This document is generated with ReporteRs.") #set the sub-title

# plot demo ------------------
myplot <- qplot(Sepal.Length, Petal.Length, 
                data = iris, color = Species, 
                size = Petal.Width, alpha = I(0.7) )

mydoc <- mydoc %>% 
  addSlide( slide.layout = "Title and Content" ) %>% 
  addTitle( "Plot examples" ) %>% 
  addPlot( function( ) print( myplot ) ) %>% 
  addPageNumber() %>% 
  addDate( ) %>% 
  addFooter( "Modify the graph within PowerPoint") 

# FlexTable demo ----------------------

options( "ReporteRs-fontsize" = 12 )
# Create a FlexTable with data.frame mtcars, display rownames
# use different formatting properties for header and body cells
MyFTable <- FlexTable( data = mtcars[1:15,], add.rownames = TRUE, 
                       body.cell.props = cellProperties( border.color = "#EDBD3E"), 
                       header.cell.props = cellProperties( background.color = "#5B7778" )
) %>% 
  setZebraStyle( odd = "#DDDDDD", even = "#FFFFFF" ) %>% # zebra stripes - alternate colored backgrounds on table rows
  setFlexTableWidths( widths = c(2, rep(.7, 11)) ) %>% 
  setFlexTableBorders( inner.vertical = borderProperties( color="#EDBD3E", style="dotted" ), 
                       inner.horizontal = borderProperties( color = "#EDBD3E", style = "none" ), 
                       outer.vertical = borderProperties( color = "#EDBD3E", style = "solid" ), 
                       outer.horizontal = borderProperties( color = "#EDBD3E", style = "solid" )
  ) # applies a border grid on table

mydoc <- mydoc %>% 
  addSlide( slide.layout = "Title and Content" ) %>% 
  addTitle( "FlexTable example" ) %>% 
  addFlexTable( MyFTable )

# Text demo ----------------------------

# set default font size to 26
options( "ReporteRs-fontsize" = 26 )

texts = c( "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", 
           "In sit amet ipsum tellus. Vivamus dignissim arcu sit amet faucibus auctor.", 
           "Quisque dictum tristique ligula." )

# format some of the pieces of text
pot1 = pot("My tailor" , textProperties(color="red" ) ) + " is " + pot("rich", textProperties(font.weight="bold") )
pot2 = pot("Cats", textProperties(color="red" ) ) + " and " + pot("Dogs", textProperties(color="blue" ) )

mydoc <- mydoc %>% 
  addSlide( slide.layout = "Two Content" ) %>% 
  addTitle( "Texts demo" ) %>% 
  addParagraph( value = texts  ) %>% 
  addParagraph( set_of_paragraphs( pot1, pot2 ) )

writeDoc( mydoc, file = "files/powerpoint/pp_long_demo.pptx" )

###
require( ReporteRs )
require( ggplot2 )

myplot = qplot(Sepal.Length, Petal.Length, 
               data = iris, color = Species, 
               size = Petal.Width, alpha = I(0.7) )

# Create a new document
mydoc = pptx( title = "EVG demo" )

mydoc = addSlide( mydoc, "Two Content" )
mydoc = addTitle( mydoc, "Vector graphics format versus raster format" )
mydoc = addPlot( mydoc, function( ) print( myplot ), vector.graphic = TRUE )
mydoc = addPlot( mydoc, function( ) print( myplot ), vector.graphic = FALSE )

writeDoc( mydoc, file = "files/evg/EVG_example.pptx" )
