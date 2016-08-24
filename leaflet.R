library(dplyr)
library(leaflet)
library(rgdal)

## Get layer info
rgdal::ogrListLayers("data/whoworld.topo.json")
rgdal::ogrInfo("data/whoworld.topo.json", 'detailed_2013')

## Read in layer of interest
map_world_base <- rgdal::readOGR("data/whoworld.topo.json", "detailed_2013")
# map_world_lakes <- rgdal::readOGR("data/whoworld.topo.json", "maskline_detailed_2013")
map_world_disputed <- rgdal::readOGR("data/whoworld.topo.json", "maskpoly_detailed_2013")
# map_world_3@data$id <- 1:nrow(map_world_3@data)

map_world_base@data$value <- nrow(map_world_base@data) %>% rnorm(mean = 100, sd = 70) %>% round

pal <- colorQuantile('YlOrRd', map_world_base@data$value, n = 5)
popup <- paste0("<b>", map_world_base@data$id, "</b>:<br>", map_world_base@data$value)


leaflet() %>%
  addPolygons(
    data = map_world_base,
    stroke = TRUE, weight = 1, color = "black", opacity = 1,
    fillColor = ~pal(value),
    popup = ~popup,
    fillOpacity = 0.5, smoothFactor = 0.5
  ) %>% 
  addPolygons(
    data = map_world_disputed, fillColor = 'steelblue',
    stroke = TRUE, weight = 1, color = "black", 
    fillOpacity = 1, smoothFactor = 0.5
  ) %>% 
  addLegend(
    position = 'bottomleft',
    pal = pal, values = map_world_base$value,
    ## below changes default from % to values
    # labFormat = function(type, cuts, p) {
    #   n = length(cuts)
    #   paste0(cuts[-n], " &ndash; ", cuts[-1])
    # },
    title = 'Legend',
    na.label = 'No data',
    opacity = .5
  ) %>% 
  setView(12.862807, 30.217636, zoom = 4)



leaflet(map_world) %>%
  addPolylines(
    stroke = TRUE, weight = 1, color = "black",
    fillOpacity = 0.1, smoothFactor = 0.5
  ) %>% 
  addPolylines(data = map_world_3, lng = ~coordinates(map_world)[,1], lat = ~coordinates(map_world)[,2])

map_world <- readLines("data/whoworld.topo.json") %>% paste(collapse = "\n")

leaflet() %>%
  addTopoJSON(map_world,
    stroke = TRUE, weight = 1, color = "black",
    fillOpacity = 0.1, smoothFactor = 0.5
  )

## Combine layers into 1 geojson file
# geojson_write(map_world, geometry = 'polygon', file = 'map_world')
# geojson_write(map_world_3, geometry = 'polygon', file = 'map_world_3')
## Merge geojson layers at the terminal! Doesn't work (no unique FIDs & huge file!)
# geojson-merge map_world.geojson map_world_3.geojson > map_world_who.geojson
# rgdal::ogrListLayers("data/map_world_who.geojson")
# rgdal::ogrInfo("data/map_world_who.geojson", 'OGRGeoJSON')
# map_world_who <- rgdal::readOGR("data/map_world_who.geojson", "OGRGeoJSON")

# topojson -o map_world.topo.json -- map_world_1.geojson map_world_3.geojson
rgdal::ogrListLayers("data/map_world.topo.json")
map_world_who <- rgdal::readOGR("data/map_world.topo.json", "map_world_3")
leaflet(map_world_who) %>%
  # addTiles() %>%
  addPolygons(
    stroke = TRUE, weight = 1, color = "#444444",
    fillOpacity = 0.5, smoothFactor = 0.5
  )


map_world@data$value <- nrow(map_world@data) %>% rnorm(mean = 100, sd = 70)

pal <- colorQuantile('YlOrRd', map_world@data$value)
popup <- paste0("<b>", map_world@data$id, "</b>:<br>", map_world@data$value)

leaflet(map_world) %>%
  addTiles() %>%
  addPolygons(
    stroke = TRUE, weight = 1, color = "#444444",
    fillOpacity = 0.5, smoothFactor = 0.5,
    fillColor = ~pal(value),
    popup = ~popup
  ) %>% 
  addLegend(position = 'bottomleft',
            colors = ~unique(pal(sort(value))), 
            labels = ~unique(sort(value)),
            title = 'Legend',
            na.label = 'No data',
            opacity = .5
  ) %>%
  setView(-0.118092, 51.509865, zoom = 3)



## Get layer info
rgdal::ogrListLayers("data/countries.geojson")
rgdal::ogrInfo("data/countries.geojson", 'OGRGeoJSON')
# topojson -o countries.topo.json -- countries.geojson
# rgdal::ogrListLayers("data/countries.topo.json")
# rgdal::ogrInfo("data/countries.topo.json", 'countries')

## Read in layer of interest
map_world <- rgdal::readOGR("data/countries.geojson", "OGRGeoJSON")
map_world@data$gdp_per_pop <- with(map_world@data, gdp_md_est/pop_est*100000) %>% round

pal <- colorFactor('Greens', unique(map_world@data$region_wb))
pal <- colorQuantile('YlOrRd', map_world@data$gdp_per_pop, n = 5)

popup <- paste0("<b>", map_world@data$region_wb, "</b>:<br>", 
                map_world@data$admin, '<br>GDP per 100,000: $', map_world@data$gdp_per_pop)

leaflet(map_world) %>%
  addPolygons(
    stroke = TRUE, weight = 1, color = "#444444",
    fillOpacity = 0.5, smoothFactor = 0.5,
    # fillColor = ~pal(region_wb),
    fillColor = ~pal(gdp_per_pop),
    popup = ~popup
  ) %>% 
  addLegend(position = 'bottomleft',
            # pal = pal, values = ~region_wb,
            pal = pal, values = ~gdp_per_pop,
            # below changes default from % to values
            # labFormat = function(type, cuts, p) {
            #   n = length(cuts)
            #   paste0(cuts[-n], " &ndash; ", cuts[-1])
            # },
            title = 'Legend',
            na.label = 'No data',
            opacity = .5
  ) %>%
  setView(-0.118092, 51.509865, zoom = 3)



rgdal::ogrListLayers("data/BASEMAPDATA.gdb")
map_world <- rgdal::readOGR("data/BASEMAPDATA.gdb", "GLOBAL_ADM0")
# map_world <- rgdal::readOGR("data/BASEMAPDATA.gdb", "AFRO_EMRO_ADM1")
# map_world <- rgdal::readOGR("data/BASEMAPDATA.gdb", "AFRO_EMRO_ADM2")
geojsonio::geojson_write(map_world)

leaflet(map_world) %>%
  addPolygons(
    stroke = TRUE, weight = 1, color = "#444444",
    # fillColor = ~pal(gdp_per_pop),
    # popup = ~popup
    fillOpacity = 0.5, smoothFactor = 0.5
  )
