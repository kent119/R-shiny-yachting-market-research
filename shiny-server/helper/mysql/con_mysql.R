library(dplyr)
library(RMySQL)

con_mysql <- function(table, db_user = "root", db_password = "", db_host = "172.17.0.12", db_name = "resultdb"){
  # open a connection
  con <- dbConnect(MySQL(), user=db_user, password=db_password,host=db_host, dbname=db_name)

  # read the table to dataframe
  dframe <- dbReadTable(con, table)

  # analyze the df
  # summary(dframe)

  # clean up
  dbDisconnect(con)
  rm(con)

  return <- dframe
}

### test ###
#rawdata <- con_mysql("boatinternational_com")
###
