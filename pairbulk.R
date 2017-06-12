###  This .R file makes API calls to the USPTO's PAIR Bulk Data API

library(jsonlite)
library(httr)
library(dplyr)

pair.bulk.url <- 'https://pairbulkdata.uspto.gov/api/'  # This is the root URL for API


##   Function to return search fields for API queries

GetFieldsPAIR <- function(){
     fields <- pair.bulk.url %>%
          paste0('/search-fields') %>%
          httr::GET() %>%
          httr::content()
     
     return(fields)
}


GetFieldsPAIR()     ## Test to see if it works

##   Function to make a POST request

PostPAIR <- function(search.text, query.fields) {
     
     query.request <- list(searchText = search.text, qf = query.fields)
     
     response <- pair.bulk.url %>%
          paste0('/queries') %>%
          httr::POST(body = query.request, encode ='json') %>%
          httr::content()
     
     return(response)
}


PostPAIR('diabetes', 'patentTitle')     # Test using arguments from API documentation   
