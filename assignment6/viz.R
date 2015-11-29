library(ggplot2)
library(ggmap)

setwd("~/git/data-at-scale/assignment6/")
d <- read.csv("seattle_incidents_summer_2014.csv", stringsAsFactors = FALSE)

head(d)
str(d)
unique(d$Summarized.Offense.Description)
d$Date.Reported <- strptime(d$Date.Reported, format="%m/%d/%Y %I:%M:%S %p")
d$hour <- d$Date.Reported$hour

unique(d$Summarized.Offense.Description)

theft_func <- function(x) {
  if(x %in% c("BURGLARY", "ROBBERY")) {
    return(1)
  } else {
    return(0)
  }
}

d$theft <- as.numeric(lapply(d$Summarized.Offense.Description, theft_func))

seattle_map <- qmap("seattle", zoom = 12, source="stamen", maptype="toner")
seattle_map + geom_point(data=d, aes(x=Longitude, y=Latitude, color=as.factor(theft)), alpha=.5, size=1.5)
