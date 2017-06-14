###  This .R file makes API calls to the USPTO's PAIR Bulk Data API

library(jsonlite)
library(httr)
library(dplyr)

pair.bulk.url <- 'https://pairbulkdata.uspto.gov/api'  # This is the root URL for API


##   Function to return search fields for API queries

GetFieldsPAIR <- function(){
     fields <- pair.bulk.url %>%
          paste0('/search-fields') %>%
          httr::GET() %>%
          httr::content()
     
     return(fields)
}


GetFieldsPAIR()     # Test to see if it works

##   Function to make a POST request (make a query)
##   This function returns Status Code and Query ID

PostQueryPAIR <- function(search.text, query.fields) {
     
     query.request <- list(searchText = search.text, qf = query.fields)
     
     response <- pair.bulk.url %>%
          paste0('/queries') %>%
          httr::POST(body = query.request, encode ='json') 

     output <- list(response.body = response, query.id = 
                         httr::content(response)$queryId)
     
     return(output)
}


PostQueryPAIR('diabetes', 'patentTitle')     # Test using arguments from API documentation   


##   Function to make a GET request (retrieve query results)

GetQueryPAIR <- function(search.text, query.fields){
     
     ##   Retrieve relevant query ID
     post.response <- PostQueryPAIR(search.text, query.fields)
     
     query.id <- post.response$query.id
     
     ##   Issue a GET request
     response <- pair.bulk.url %>%
          paste0('/queries/', query.id, '?format=JSON') %>%
          httr::GET() %>%
          httr::content()
     
     ##   Take URL returned by GET request, download file
     
     data <- response$links[[2]]$href %>%
          fromJSON() 
     
     data <- data$queryResults$searchResponse$response$docs %>%
          data.frame()
     
     drops <- c("publishDocJson")   ## Should we drop these columns????
     
     data <- data[, !(names(data) %in% drops)]
     
     return(data)
}
