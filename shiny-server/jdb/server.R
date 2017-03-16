library(shiny)
library(ggvis)
source("/srv/shiny-server/helper/mysql/json_df2.R")
source("/srv/shiny-server/yatco/cleaning/clean_data.R")
load("/srv/shiny-server/yatco/data/data.Rda")

#############################
########  constant  #########
#############################

BUILDER <- "Builder"
NAME <- "title"
PRICE <- "price"
YEAR <- "YearBuilt"
LOA <- "LOA"
URL <- "url" 

data_colnames <- c(BUILDER, NAME, PRICE, YEAR, LOA, URL)
#############################
yachts <- clean_data(data, data_colnames)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  ############################################
  # filter the yachts, return a dataframe
  yachts_filted <- reactive({
    # Due to dplyr issue #318, we need temp variables for input values
    selected_loa_min <- input$slider_loa[1]
    selected_loa_max <- input$slider_loa[2]
    selected_price_min <- input$slider_price[1] * 1e6
    selected_price_max <- input$slider_price[2] * 1e6
    selected_year_min <- input$slider_year[1]
    selected_year_max <- input$slider_year[2]
    # Apply filters: loa, price, year
    selected_yachts <- yachts %>% arrange(loa)
    # Apply filters: builder, model
    selected_yachts <- selected_yachts[selected_yachts$loa >= selected_loa_min,]
    selected_yachts <- selected_yachts[selected_yachts$loa <= selected_loa_max,] 
    selected_yachts <- selected_yachts[selected_yachts$price_usd >= selected_price_min,]
    selected_yachts <- selected_yachts[selected_yachts$price_usd <= selected_price_max,]
    selected_yachts <- selected_yachts[selected_yachts$year <= selected_year_max,]
    selected_yachts <- selected_yachts[selected_yachts$year >= selected_year_min,]

    selected_yachts <- as.data.frame(selected_yachts)
    
    #
    #print("debug_filter_sucess")
    selected_yachts
  })

  # Function for generating tooltip text
  yacht_tooltip <- function(x) {
    if (is.null(x)) text1 <- "x is null <br>" else text1 <- "x is not null <br>"#return(NULL)
    if (is.null(x$id)) text2<- toString(colnames(x)) else text2<- "x id is not null <br>"#return(NULL)

    # Pick out the yacht with this ID
    all_yachts <- isolate(yachts_filted())
    the_yacht <- all_yachts[all_yachts$price_usd == x$price_usd, ]
    debug1<-all_yachts$price_usd[1]
    the_yacht <- the_yacht[the_yacht$year == x$year, ]
    debug2<-the_yacht$price_usd[1]
    the_yacht <- the_yacht[the_yacht$loa == x$loa, ]
    the_yacht <- the_yacht[!is.na(the_yacht$price),]
    debug3<-nrow(the_yacht)
    debuging<-c(debug1, debug2, debug3)
    paste0("<b>", the_yacht$name, "</b><br>",
      #"debug1:", toString(summary(all_yachts)), "<br>",
      #"debug2:", toString(debuging), "<br>",
      the_yacht$text_loa, "<br>",
      the_yacht$text_price, "<br>",
      the_yacht$builder, " - ", the_yacht$text_year, "<br>"
    )
  }
  update_selection <- function(x,session){
    #if (is.null(x)) return(NULL)
    # Pick out the yacht with the price, year, loa
    all_yachts <- isolate(yachts_filted())
    if (is.null(x)) updateSelectInput(session, "selected_yacht_info", selected = all_yachts$url[1])

    the_yacht <- all_yachts[all_yachts$price_usd == x$price_usd, ]
    the_yacht <- the_yacht[the_yacht$year == x$year, ]
    the_yacht <- the_yacht[the_yacht$loa == x$loa, ]

    updateSelectInput(session, "selected_yacht_info", selected = the_yacht$url)
  }

  yacht_price <- reactive({
    # Lables for axes
    xvar_name <- "LOA (m)"
    yvar_name <- "Prince (USD)"

    yachts_filted %>%
      ggvis(~loa, ~price_usd) %>%
      layer_points(size := 50, size.hover := 200,
        fillOpacity := 0.2, fillOpacity.hover := 0.5,
        stroke = ~year) %>%
      add_tooltip(yacht_tooltip, "hover") %>%
#      handle_click(update_selection) %>%
      add_axis("x", title = xvar_name) %>%
      add_axis("y", title = yvar_name, title_offset = 100) %>%
      #add_legend("stroke", title = "Year of Build", values = factor(~year) ) %>%
      #scale_numeric("fill", domain = c(0,100),
        #range = c("red", "green")) %>%
      #scale_numeric("stroke", domain = c(0,100)) %>%
      #layer_text(text := ~selected_builder, x = ~loa+1, y = ~price-700000) %>%
      set_options(width = 1000, height = 800)
  })
  yacht_price %>% bind_shiny("yacht_price")

  yacht_info <- reactive({
    input_url <- input$selected_yacht_info
    all_yachts <- isolate(yachts_filted())
    the_yacht <- all_yachts[all_yachts$url == input_url, ]
    paste0(
#      "<b>", the_yacht$name, "</b><br>",
#      #toString(head(the_yacht)), "<br>",
#      #toString(summary(the_yacht)), "<br>",
#      the_yacht$text_loa, "<br>",
#      the_yacht$text_price, "<br>",
#      the_yacht$builder, " - ", the_yacht$text_year, "<br>",
#      a("Visit the webpage on Boat International", href = the_yacht$url)
       the_yacht$url
    )
  })
#  output$yacht_selected <- renderText({yacht_info()})
#   output$yacht_selected <- renderText({input$selected_yacht_info})
})
