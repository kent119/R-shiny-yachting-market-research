library(rjson)
library(dplyr)

json_df <- function(result){
  # read the json to documnet
  document <- data.frame()
  '%!in%' <- function(x,y)!('%in%'(x,y))

  # process for each json
  for (eachresult in result){
    # change reachresult to reachjson
    eachjson <- fromJSON(eachresult)

    # check col, if the colname is not in the dataframe, then add the colname with NA
    for (eachcol in colnames(eachjson)){
      if (eachcol %!in% colnames(document)){
        document$eachcol <- NA
      }
    }
    for (eachcol2 in colnames(document)){
      if (eachcol2 %!in% colnames(eachjson)){
        eachjson$eachcol2 <- NA
      }
    }
    # 2. add row: after add new col, it's ok to add new row 
    document <- rbind(document, eachjson)
  }
  return <- document
}


### test ###

data <- json_df(rawdata$result)

head(data)
str(data)
data$"Max Draught"
data$"Cruising Speed"
data
doc1 <- fromJSON(rawdata$result[1])
doc2 <- fromJSON(rawdata$result[2])
doc3 <- fromJSON(rawdata$result[3])
###
