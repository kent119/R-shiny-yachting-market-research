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
        max = 108,
        value = c(2.74, 108)
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
        max = 195,
        value = c(0, 195)
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
