library(RGA)
library(dplyr)

#Authorization for RGA
authorize()

##Enter your view ID here
profile <- XXXXXXXX

##Enter you start and end date here
start.date = "2016-07-01"
end.date = "2016-07-01"

##RGA script
gasessions <- get_ga(profile, start.date, end.date,
                     metrics = "ga:sessions")

gaevents <- get_ga(profile, start.date, end.date, 
             metrics = "ga:uniqueEvents",
             dimensions = "ga:eventCategory,ga:eventAction,ga:eventLabel,ga:pagePath")

gapages <- get_ga(profile, start.date, end.date, 
                   metrics = "ga:pageviews",
                   dimensions = "ga:pagePath")

gaevents <- inner_join(gaevents, gapages, by = "pagePath")

gaevents$pageconv <- round(gaevents$uniqueEvents/gaevents$pageviews,4)
