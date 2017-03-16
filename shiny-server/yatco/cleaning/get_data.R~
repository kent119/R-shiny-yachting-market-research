source("/srv/shiny-server/helper/mysql/con_mysql.R")
source("/srv/shiny-server/helper/mysql/json_df2.R")

#############################
########  constant  #########
#############################

DATA_TABLE <- "boatinternational_com"
 
EURO <- "\u20AC"

#############################

#############################
##########  init  ###########
#############################
# connect to the mysql server, and read the table: DATA_TABLE
rawdata <- con_mysql(DATA_TABLE)

# convert the json to dataframe, the json files are in rawdata$result
data <- json_df(rawdata$result)
save(data, file="/srv/shiny-server/boatinternational/data/data.Rda")
