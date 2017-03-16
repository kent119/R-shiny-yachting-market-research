library(shiny)
library(ggvis)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Yatco - Latest Infomation: Yacht Model, LOA, Price, Year of Build"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create scatter plot with daily updated iinformation from http://www.yatco.com/."),
     
      sliderInput(
        "slider_loa",
        label = "LOA (m):",
        min = 2.74,
        max = 110,
        value = c(2.74, 110)
      ),

      sliderInput(
        "slider_year",
        label = "Year of Build:",
        min = 1897,
        max = 2020,
        value = c(1897, 2020),
        sep = ""
      ),

      sliderInput(
        "slider_price",
        label = "Price (in million USD):",
        min = 0,
        max = 200,
        value = c(0, 200)
      ),

      textInput("text_builder", "Yacht Builder - Find yachts built by: (e.g., Kingship)"),
      textInput("text_name", "Yacht Model - Find the model name contains: (e.g. Star)")
    ),
    
    mainPanel(
      ggvisOutput("yacht_price"),
      wellPanel(textOutput("yacht_selected"))
      )
    )
  )


)
