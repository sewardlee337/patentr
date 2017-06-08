library(jsonlite)
library(httr)

##  URL to USPTO PAIR Bulk API
##  This provides info to all the possible stuff you can do with this particular API

url <- 'https://pairbulkdata.uspto.gov/api/v2/api-docs?group=pair-public-api'

operations <- fromJSON(url)