library(rjson)
library(plyr)

json_df <- function(results){
  dat <- data.frame()
  for (eachresult in results){
    document <- data.frame(fromJSON(eachresult))
    dat <- rbind.fill(
      #lapply(document$features, function(x) data.frame(x$properties))
      dat, document
    )
  }
  return <- dat
}


### test ###
#data <- json_df(rawdata$result)
###
