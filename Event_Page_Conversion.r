library(RGA)
library(dplyr)

#Authorization for RGA
authorize()

##Enter your view ID here
profile <- 82787986

start.date = "2016-07-01"
end.date = "2016-07-01"

gasessions <- get_ga(profile, start.date, end.date,
                     metrics = "ga:sessions")

##RGA script
gaevents <- get_ga(profile, start.date, end.date, 
             metrics = "ga:uniqueEvents",
             dimensions = "ga:eventCategory,ga:eventAction,ga:eventLabel,ga:pagePath")

gapages <- get_ga(profile, start.date, end.date, 
                   metrics = "ga:pageviews",
                   dimensions = "ga:pagePath")

gaevents2 <- inner_join(gaevents, gapages, by = "pagePath")

gaevents2$pageconv <- round(gaevents2$uniqueEvents/gaevents2$pageviews,4)
