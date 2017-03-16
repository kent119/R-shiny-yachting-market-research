library(shiny)
library(ggvis)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Boat International - Latest Infomation: Yacht Model, LOA, Price, Year of Build"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create scatter plot with daily updated iinformation from the Boat International."),
     
      sliderInput(
        "slider_loa",
        label = "LOA (m):",
        min = 11.58,
        max = 120,
        value = c(11.58, 120)
      ),

      sliderInput(
        "slider_year",
        label = "Year of Build:",
        min = 1900,
        max = 2020,
        value = c(1900, 2020),
        sep = ""
      ),

      sliderInput(
        "slider_price",
        label = "Price (in million USD):",
        min = 0.25,
        max = 255,
        value = c(0.25, 255)
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
