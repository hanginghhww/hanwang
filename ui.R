
shinyUI  (
  navbarPage (title = 'Bitcoin Data Visualization',
            id='nav',
   theme = shinytheme ('slate'),
   tabPanel('Realtime Transaction',
          tags$iframe(
             src = "http://www.bitlisten.com/",
             width='100%', height='900'
           )
   ),
   tabPanel('Bitcoin Map',
             div(class="outer",
                 tags$head(
                   includeCSS("styles.css"),
                   includeScript("gomap.js")),
             
            leafletOutput(outputId = "map", width = "100%", height = "100%"),
            absolutePanel(id='category',class='panel panel-default',fixed=TRUE,draggable=TRUE,
                          top=80,left='30',right='auto',bottom='auto',width=350,height='auto',
                          h4('Venues Accepting Bitcoin'),style = 'opacity: 0.5',
                          checkboxGroupInput(inputId='select_Cat',label=h4('Category'),
                                             choices=mapcat, selected = 'Atm'),
                          sliderInput("date",
                                      "Created On:",
                                      min = as.Date("2013-02-28"), max = Sys.Date(),
                                      value = c(as.Date("2013-02-28"), Sys.Date())),
            absolutePanel(id='forpiechart',class='panel panel-default',fixed= TRUE,draggable=TRUE,
                          top=320,lef=20,right='auto',bottom='auto',width=320,height='auto',
                          style = 'opacity: 1',
                          plotlyOutput(outputId='piechart1',height=150))

            )
)
 ),
   tabPanel('Price of Cryptocurrencies',
            fluidRow(
                     dygraph(newdata, main = "Price of Cryptocurrencies") %>% 
                            dyRangeSelector()) 
                     )
# tabPanel('Investment On Rturn',
#          fluidRow(
#            column(3, absolutePanel(id='roi',class='panel panel-default',fixed=TRUE,draggable=TRUE,
#                                          top=80,left='30',right='auto',bottom='auto',width=180,height='auto',
#                                          h4('Return On Investment'),style = 'opacity: 0.5',
#                                          checkboxGroupInput(inputId='roi',label=h4('Category'),
#                                                             choices=lines, selected = 'bitcoin'),
#                                          sliderInput("roidate",
#                                                "Hold Period:",
#                                                min = as.Date("2013-02-28"), max = Sys.Date(),
#                                                value = c(as.Date("2013-02-28"), Sys.Date())))),
#            column(9,offset=5,
#                  plotlyOutput('roi'))
#                                        
#                 
#                                        
#            
#          )
           ) 
)
    
            

    
  
