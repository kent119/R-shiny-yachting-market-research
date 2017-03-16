# clean NA, format price in USD, format loa, year

clean_data <- function(x, x_colnames){
  # constant
  EURO <- "\u20AC"
  SPACE <- "\u00A0"
  yachts_colnames <- c("builder", "name", "text_price", "text_year", "text_loa", "url")

  EUR_TO_USD <- 1.1
  # extract selected columns to make a new data frame 
  new_data <- data.frame(x[x_colnames])
  colnames(new_data) <- yachts_colnames

  #############################
  #####  clean "price"  #######
  #############################
  # remove "*" and ",", and convert the factor type price to numeric
  new_data$text_price <- gsub("\\*", "", new_data$text_price)
  new_data$price <- gsub(",","", new_data$text_price)
  new_data$price <- gsub(SPACE, "", new_data$price)
  new_data$price <- gsub(" ", "", new_data$price)
  new_data$price <- gsub("\\$", "", new_data$price)
  new_data$price <- gsub(EURO, "", new_data$price)
  new_data$price <- as.numeric(as.character(new_data$price))

  # add "currency" to new_data
  new_data$currency <- NA
  new_data$currency[grepl("\\$",new_data$text_price)] <- "USD"
  new_data$currency[grepl(EURO,new_data$text_price)] <- "EUR"
  new_data$currency <- as.factor(new_data$currency)

  # format the "price" to "price_usd"
  new_data$price_usd <- NA
  new_data$price_usd[grepl("USD",new_data$currency)] <- new_data$price[grepl("USD",new_data$currency)]
  new_data$price_usd[grepl("EUR",new_data$currency)] <- new_data$price[grepl("EUR",new_data$currency)] * EUR_TO_USD

  #############################
  ###### clean "year"  ########
  #############################
  new_data$year <- as.numeric(as.character(gsub(".*(\\d{4}).*","\\1",new_data$text_year)))

  #############################
  ####### clean "loa"  ########
  #############################
  new_data$loa <- gsub("[\\(\\)]","",regmatches(new_data$text_loa, gregexpr("\\(.*?\\)",new_data$text_loa)))
  new_data$loa <- gsub("m", "", new_data$loa)
  new_data$loa <- as.numeric(as.character(new_data$loa))

  #############################
  ####### clean "name"  ########
  #############################
  new_data$name <- gsub(".* \\- .* \\- ","", new_data$name)
 
  # final, delete NA in the price
  price_is_not_na <- !is.na(new_data$price) 
  new_data <- new_data[price_is_not_na,]
  currency_is_not_na <- !is.na(new_data$currency)
  new_data <- new_data[currency_is_not_na,]
  
  #############################
  ##########  test  ###########
  #############################
   #head(new_data)
  #str(new_data)
  #new_data$price
  #new_data$currency
  #new_data$year
  #new_data$loa
  #new_data$text_loa
  return <- new_data
}
