###  This .R file makes API calls to the USPTO's PAIR Bulk Data API


library(jsonlite)
library(httr)
library(dplyr)

pair.bulk.url <- 'https://pairbulkdata.uspto.gov/api/'  # This is the root URL for API


# Return links to resources available in HATEOAS style

resources <- pair.bulk.url %>%
    GET() 

http_type(resources)    # data format
print(resources)        # return R list
str(resources)          # see structure of list


# Return schema fields, as well as frequency and sample values

search.fields <- pair.bulk.url %>%
    modify_url(path = '/search-fields') %>%
    GET()

http_type(search.fields)    # data format
print(search.fields)        # return R list
str(search.fields)          # see structure of list




