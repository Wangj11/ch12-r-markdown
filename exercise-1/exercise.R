# load relevant libraries
library(httr)
library(jsonlite)

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("../../ch11-apis/exercise-2/apikey.R")

movie_name <- "Hunt for the Wilderpeople"


# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie.name` variable as the search query!
query_params <- list("api-key" = nty_apikey, "query" = movie_name)
response <- GET("https://api.nytimes.com/svc/movies/v2/reviews/search.json", query = query_params)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response_content <- content(response, "text")

# What kind of data structure did this produce? A data frame? A list?
body_data <- fromJSON(response_content)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(body_data)
str(body_data)
# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(body_data$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
headline <- reviews$headline
short_summary <- reviews$summary_short
link_to_article <- reviews$link.url
# Create a list of the three pieces of information from above. 
# Print out the list.
review_list <- list(c(headline, short_summary, link_to_article))
review_list
