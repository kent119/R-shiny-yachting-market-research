library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$text1 <- renderText({
    paste("You have selected this",input$select1)
  })
  
  output$text_range <- renderText({
    paste("You have chosen a range that goes from ", input$slider1[1], " to ", input$slider1[2], " !")
  })
})