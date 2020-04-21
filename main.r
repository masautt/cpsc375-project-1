library(tidyverse)

# 1.a) Reading the Data using read_csv()
rawConfirmed <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/confirmed.csv")
rawDeaths <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/deaths.csv")
rawHospitalBeds <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/hospitalbeds.csv")
rawDemographics <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/demographics.csv")

# 1b) Tidying Tables if Needed
gatheredConfirmed <- rawConfirmed %>% gather(key="date", value="numConfirmed", -`Province/State`, -`Country/Region`, -`Lat`, -`Long`)
gatheredDeaths <- rawDeaths %>% gather(key="date", value="numDeaths", -`Province/State`, -`Country/Region`, -`Lat`, -`Long`)

# 1c) Filter hospital beds to recent year
filteredHospitalBeds <- rawHospitalBeds %>% filter(Year == 2015)

# 1d) Aggregate Confirmed and Deaths to country level
groupedConfirmed <- gatheredConfirmed
groupedDeaths