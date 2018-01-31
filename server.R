shinyServer(function(input,output,session){
  
#load the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles('CartoDB.DarkMatter') %>%
      #leaflet::addLegend(position = "bottomright", pal=groupColors,values=mapcat,opacity = 0.1) %>%
      setView(lng = -73.9772, lat = 40.7527, zoom = 3) 
   
                     
   })
  
# reactivate data for location
   mapcoin=reactive({
           map1 %>%
            filter(.,Category %in% input$select_Cat) %>%
            filter(., Created.On>=input$date[1]&
                      Created.On<=input$date[2] )
                    
   })
#observe an event
     observe({
         leafletProxy('map', data = mapcoin()) %>%
          clearMarkerClusters() %>%
          clearMarkers() %>%
          #circle
         addCircleMarkers(lng=~latitude,lat=~longitude,radius=0.4,color=~groupColors(mapcat),
                          group='CIRCLE',
                          popup = ~paste('<b><font color="Black">','Name:', Name, '<br/>','</font></b><br/>',
                                         'Type:', Category,'<br/>',
                                         'Since:', Created.On,'<br/>'
                                         )
                           ) %>%
           

         # cluster
           addCircleMarkers(lng = ~latitude, lat = ~longitude, clusterOptions = markerClusterOptions(),
                           group = "CLUSTER",
                           popup = ~paste('<b><font color="Black">','Name:', Name, '<br/>','</font></b><br/>',
                                          'Type:', Category,'<br/>',
                                          'Since:', Created.On,'<br/>') 
                         ) %>%
         
           #circle/cluster panel
           addLayersControl(
            baseGroups = c('CIRCLE','CLUSTER'),
             options = layersControlOptions(collapsed=FALSE)
           )

      })
#reactive date for piechart for Category at certain time
     piechart=reactive({
       map1 %>%
         filter(.,Category %in% input$select_Cat) %>%
         filter(., Created.On>=input$date[1]&
                  Created.On<=input$date[2] ) %>%
         group_by(.,Category) %>%
         dplyr::summarise(.,total=n())
         
     })
     
#piechart graph
     output$piechart1=renderPlotly({
       pie1=plot_ly(data=piechart(),labels=~Category,values=~total) %>%
         add_pie(hole=0.6) %>%
         layout(title='',showlegend = F,
                xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
     })
     
     
     
     
     
     
     
     
# # # ##########------------------------------------------
   #reactive data for tab Price
     lines1=reactive({
      new %>%
         filter(  bch == input$lines |
                  bitcoin == input$lines |
                  btg == input$lines |
                  dash == input$lines |
                  dcr == input$lines |
                  dgb == input$lines |
                  doge == input$lines |
                  etc == input$lines |
                  eth == input$lines |
                  pivx == input$lines |
                  vertcoin == input$lines |
                  vtc == input$lines |
                  xem == input$lines |
                  xmr== input$lines |
                  xvg  == input$lines |
                  zec == input$lines 
                ) 
                
     })
     output$price=renderDygraph({
       dygraph(data=lines1(),main='Price of Cryptocurrencies ') %>%
         dyRangeSelector()
     })
#3
     
  
     


})


