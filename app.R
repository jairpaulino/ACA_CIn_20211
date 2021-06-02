library(shiny)

source("AStarAlgorithm.R")

ui = fluidPage(
  
  titlePanel("A* pathfinding algorithm"),
  
  numericInput(inputId = "Origin", label = "Origin",
               value = 1, min = 1, max = 14),
  
  numericInput(inputId = "Destiny", label = "Destiny",
               value = 14, min = 1, max = 14),
  
  
  tags$h4("The final route is: "),
  
  mainPanel(
    textOutput("Route")
  ),
  
  tags$h4("The total time (in hours) spent was: "),
  
  mainPanel(
    textOutput("timeSpent")
  ),
  
)

server = function(input, output, session){
  
  output$Route = renderText({ 
    AStarPath = getAStarPath(origin = input$Origin,
                             destiny =  input$Destiny,
                             distReal = distReal_df,
                             distConnection = distConnection_df)
    AStarPath[[1]]
  })
  
  output$timeSpent = renderText({ 
    AStarPath = getAStarPath(origin = input$Origin, 
                             destiny =  input$Destiny,
                             distReal = distReal_df, 
                             distConnection = distConnection_df)
    AStarPath$TimeSpent
  })

}

shinyApp(ui, server)
#shinyapps

