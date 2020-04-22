library(tidyverse)


Confirmed <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/confirmed.csv") 
    %>% gather(key="Date", value="NumConfirmed", -`Province/State`, -`Country/Region`, -`Lat`, -`Long`) 
    %>% select(`Province/State`, `Country/Region`, `Date`, `NumConfirmed`) 
    %>% group_by(`Country/Region`, `Date`) 
    %>% summarise(NumConfirmed = sum(NumConfirmed))

Deaths <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/deaths.csv") 
    %>% gather(key="Date", value="NumDeaths", -`Province/State`, -`Country/Region`, -`Lat`, -`Long`) 
    %>% select(`Province/State`, `Country/Region`, `Date`, `NumDeaths`) 
    %>% group_by(`Country/Region`, `Date`) 
    %>% summarise(NumDeaths = sum(NumDeaths))


Beds <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/hospitalbeds.csv") 
    %>% filter(Year == 2015) 
    %>% select(`Country`, `Hospital beds (per 10 000 population)`)

Demographics <- read_csv("https://raw.githubusercontent.com/masautt/cpsc375-project-1/master/demographics.csv")
    %>% select(`Country Name`, `Series Code`, `YR2015`) 
    %>% spread(key = `Series Code`, value = `YR2015`)
    %>% replace(is.na(.), 0)
    %>% rename(`POP TOTAL` = `SP.POP.TOTL`)
    %>% rename(`LIFE EXT` = `SP.DYN.LE00.IN`)
    %>% rename(`POP URBAN` = `SP.URB.TOTL`)
    %>% mutate(`MORT RATE` = reduce(select(., starts_with("SP.DYN.AMRT")), `+`))
    %>% mutate(`POP 0TO14` = reduce(select(., starts_with("SP.POP.0014")), `+`))
    %>% mutate(`POP 15TO65` = reduce(select(., starts_with("SP.POP.1564")), `+`))
    %>% mutate(`POP 65UP` = reduce(select(., starts_with("SP.POP.65UP")), `+`))
    %>% mutate(`POP 80UP` = reduce(select(., starts_with("SP.POP.80UP")), `+`))

    
    