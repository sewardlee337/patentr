###  This .R file makes API calls to the USPTO's PAIR Bulk Data API


library(jsonlite)
library(httr)
library(dplyr)

pair.bulk.url <- 'https://pairbulkdata.uspto.gov/api/'  # This is the root URL for API


# Return schema fields, as well as frequency and sample values

GetFieldsPAIR <- function(){
     search.fields <- pair.bulk.url %>%
          paste0('/search-fields') %>%
          GET() %>%
          content()
     
     return(search.fields)
}

