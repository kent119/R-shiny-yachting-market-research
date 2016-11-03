source("/srv/shiny-server/helper/mysql/con_mysql.R")
source("/srv/shiny-server/helper/mysql/json_df2.R")

#############################
########  constant  #########
#############################

DATA_TABLE <- "boatinternational_com"
 
BUILDER <- "Builder"
NAME <- "Name"
PRICE <- "price"
YEAR <- "Year.of.Build"
LOA <- "Length.Overall"

EURO <- "\u20AC"

#############################

#############################
##########  init  ###########
#############################
# connect to the mysql server, and read the table: DATA_TABLE
rawdata <- con_mysql(DATA_TABLE)

# convert the json to dataframe, the json files are in rawdata$result
data <- json_df(rawdata$result)

# extract selected columns to make a new data frame 
yachts <- data.frame("builder" = data[BUILDER], "name" = data[NAME], "text_price" = data[PRICE],"text_year" = data[YEAR],"text_loa" = data[LOA])
colnames(yachts) <- c("builder", "name", "text_price", "text_year", "text_loa")

#############################
#####  clean "price"  #######
#############################
# remove "*" and ",", and convert the factor type price to numeric
yachts$text_price <- gsub("\\*", "", yachts$text_price)
yachts$price <- gsub(",","", yachts$text_price)
yachts$price <- gsub("\\$", "", yachts$price)
yachts$price <- gsub(EURO, "", yachts$price)
yachts$price <- as.numeric(as.character(yachts$price))

# add "currency" to yachts
yachts$currency <- NA
yachts$currency[grepl("\\$",yachts$text_price)] <- "USD"
yachts$currency[grepl(EURO,yachts$text_price)] <- "EUR"
yachts$currency <- as.factor(yachts$currency)

#############################
###### clean "year"  ########
#############################
yachts$year <- as.numeric(as.character(yachts$text_year))

#############################
####### clean "loa"  ########
#############################
yachts$loa <- gsub("m \\(.*\\)", "", yachts$text_loa)
yachts$loa <- as.numeric(as.character(yachts$loa))

# final, delete NA in the price
price_is_not_na <- !is.na(yachts$price) 
yachts <- yachts[price_is_not_na,]
currency_is_not_na <- !is.na(yachts$currency)
yachts <- yachts[currency_is_not_na,]

#############################
##########  test  ###########
#############################
#head(yachts)
#str(yachts)
#yachts$price
#yachts$currency
#yachts$year
#yachts$loa
#yachts$text_loa

#save(yachts, file="/srv/shiny-server/boatinternational/data_boatinternational.Rda")
