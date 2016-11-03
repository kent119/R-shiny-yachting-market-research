library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with information from the 2010 US Census."),
      
      selectInput(
        "select1",
        label = "Choose a variable to display",
        choices = c(
          "Percent White",
          "Percent Blank",
          "Percent Hispanic",
          "Percent Asian"
        ),
        selected = "Percent White"
      ),
      
      sliderInput(
        "slider1",
        label = "Range of interest:",
        min = 0,
        max = 100,
        value = c(0, 100)
      )
    ),
    
    mainPanel(
      textOutput("text1"),
      textOutput("text_range"),
      plotOutput("map")
    )
  )


))