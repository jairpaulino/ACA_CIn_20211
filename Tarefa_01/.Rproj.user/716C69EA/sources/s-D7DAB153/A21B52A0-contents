library(shiny)

source("AStarAlgorithm.R")

ui = fluidPage(
  
  titlePanel("A* pathfinding algorithm"),
  
  numericInput(inputId = "initialStation", label = "Initial Station",
               value = 1, min = 1, max = 14),
  
  numericInput(inputId = "finalStation", label = "Final Station",
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
    AStarPath = getAStarPath(initialStation = input$initialStation,
                             finalStation =  input$finalStation,
                             distReal = distReal_df,
                             distConnection = distConnection_df)
    AStarPath$Route
  })
  
  output$timeSpent = renderText({ 
     AStarPath = getAStarPath(initialStation = input$initialStation, 
                              finalStation =  input$finalStation,
                              distReal = distReal_df, 
                              distConnection = distConnection_df,
                              detailedPath = T)
    AStarPath$TimeSpent
  })

}

shinyApp(ui, server)
#shinyapps

