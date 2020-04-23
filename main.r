library(tidyverse)

Confirmed <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/confirmed.csv") 
    %>% gather(key="Date", value="NumConfirmed", -`Province/State`, -`Country/Region`, -`Lat`, -`Long`) 
    %>% select(`Country` = `Country/Region`, `Date`, `NumConfirmed`)
    %>% filter(Country != "US")
    %>% mutate(Country = replace(Country, Country == "Republic of Korea", "South Korea"))

Deaths <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/deaths.csv") 
    %>% gather(key="Date", value="NumDeaths", -`Province/State`, -`Country/Region`, -`Lat`, -`Long`) 
    %>% select(`Country` = `Country/Region`, `Date`, `NumDeaths`) 
    %>% filter(Country != "US") 
    %>% mutate(Country = replace(Country, Country == "Republic of Korea", "South Korea"))

Beds <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/hospitalbeds.csv") 
    %>% filter(Year == 2015) 
    %>% filter(Country != "United States of America")
    %>% select(`Country`, `NumBeds` = `Hospital beds (per 10 000 population)`)
    %>% mutate(Country = replace(Country, Country == "Republic of Korea", "South Korea"))
    %>% mutate(Country = replace(Country, Country == "Iran (Islamic Republic of)", "Iran"))
    %>% mutate(Country = replace(Country, Country == "United Kingdom of Great Britain and Northern Ireland", "United Kingdom"))

Demographics <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/demographics.csv") 
    %>% select(`Country Name`, `Series Code`, `YR2015`) 
    %>% spread(key = `Series Code`, value = `YR2015`) 
    %>% replace(is.na(.), 0) 
    %>% mutate(`MORT RATE` = reduce(select(., starts_with("SP.DYN.AMRT")), `+`)) 
    %>% mutate(`POP 0TO14` = reduce(select(., starts_with("SP.POP.0014")), `+`)) 
    %>% mutate(`POP 15TO65` = reduce(select(., starts_with("SP.POP.1564")), `+`)) 
    %>% mutate(`POP 65UP` = reduce(select(., starts_with("SP.POP.65UP")), `+`)) 
    %>% mutate(`POP 80UP` = reduce(select(., starts_with("SP.POP.80UP")), `+`)) 
    %>% select(`Country` = `Country Name`,`LIFE EXT` = `SP.DYN.LE00.IN`, `MORT RATE`,  `POP TOTAL` = `SP.POP.TOTL`, `POP URBAN` = `SP.URB.TOTL`, `POP 0TO14`, `POP 15TO65`, `POP 65UP`, `POP 80UP`)
    %>% mutate(Country = replace(Country, Country == "Korea, Dem. Peopleâ€™s Rep.", "South Korea"))
    %>% mutate(Country = replace(Country, Country == "Korea, Rep.", "South Korea"))
    %>% mutate(Country = replace(Country, Country == "Iran, Islamic Rep.", "Iran"))
    %>% filter(Country != "United States")

Confirmed_PLUS_Deaths <- Confirmed %>% inner_join(Deaths)
Demographics_PLUS_Beds = Demographics %>% inner_join(Beds)
MainTable = Demographics_PLUS_Beds %>% inner_join(Confirmed_PLUS_Deaths)