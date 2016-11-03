library(shiny)
library(maps)
library(mapproj)
source("helpers.R")
countries <- readRDS("data/counties.rds")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$text1 <- renderText({
    paste("You have selected this",input$select1)
  })
  
  output$text_range <- renderText({
    paste("You have chosen a range that goes from ", input$slider1[1], " to ", input$slider1[2], " !")
  })
  
  output$map <- renderPlot({
    map_var <- switch(
      input$select1,
      "Percent White" = countries$white,
      "Percent Blank" = countries$black,
      "Percent Hispanic" = countries$hispanic,
      "Percent Asian" = countries$asian
    )
    map_color <- switch(
      input$select1,
      "Percent White" = "darkgreen",
      "Percent Blank" = "black",
      "Percent Hispanic" = "darkorange",
      "Percent Asian" = "darkviolet"
    )
    map_legend_title <- paste("Percentage of ", switch(
      input$select1,
      "Percent White" = "White",
      "Percent Blank" = "Black",
      "Percent Hispanic" = "Hispanic",
      "Percent Asian" = "Asian"
    ))
    map_min <- input$slider1[1]
    map_max <- input$slider1[2]
    
    percent_map(
      var = map_var,
      color = map_color,
      legend.title = map_legend_title,
      min = map_min,
      max = map_max
    )
  })
})