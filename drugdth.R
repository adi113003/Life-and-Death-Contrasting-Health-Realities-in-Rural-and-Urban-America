#Libraries
library(readxl)
library(tidyverse)
library(sf)
library(tidycensus)
#Loading data
SDOH_2014 <- read_xlsx("SDOH_2014_COUNTY_1_0.xlsx",sheet = 2)
SDOH_2018 <- read_xlsx("SDOH_2018_COUNTY_1_1.xlsx",sheet = 2)
View(SDOH_2014)
View(SDOH_2018)
#Self drug Cols
SDOH_2014 <- SDOH_2014 |> select(COUNTYFIPS,STATEFIPS,STATE,COUNTY,REGION,CDCW_DRUG_DTH_RATE)
SDOH_2018 <- SDOH_2018 |> select(COUNTYFIPS,STATEFIPS,STATE,COUNTY,REGION,CDCW_DRUG_DTH_RATE)
#renaming cols
SDOH_2014 <- SDOH_2014 |> rename(Drug14 = CDCW_DRUG_DTH_RATE)
SDOH_2018 <- SDOH_2018 |> rename(Drug18 = CDCW_DRUG_DTH_RATE)
#removing states
SDOH_2014<-SDOH_2014|>filter(STATE != "District of Columbia" &
                               STATE != "Hawaii" &
                               STATE!= "Puerto Rico" & 
                               STATE != "Alaska")

SDOH_2018<-SDOH_2018|>filter(STATE != "District of Columbia" &
                               STATE != "Hawaii" &
                               STATE!= "Puerto Rico" & 
                               STATE != "Alaska")
#Merging 2014 and 2018
dt = left_join(SDOH_2014,SDOH_2018)

pop14<- get_acs(geography = "county", 
                variables = "B01003_001", year = 2014
                ,geometry = TRUE)
pop14<-pop14|>filter(NAME != "District of Columbia" &
                       NAME != "Hawaii" &
                       NAME != "Puerto Rico" & 
                       NAME != "Alaska")
# Joining County and State col
dt = unite(dt,col = "NAME",c(COUNTY,STATE),sep = ", ", remove = TRUE)
dt<- dt|> rename(GEOID = COUNTYFIPS)


#merge
mergeddt= left_join(pop14,dt)

#Removing states
mergeddt = mergeddt|> filter(as.numeric(GEOID) < 72000 | as.numeric(GEOID) > 72153)
mergeddt = mergeddt|> filter(as.numeric(GEOID) < 15000 | as.numeric(GEOID) > 15009)
mergeddt = mergeddt|> filter(as.numeric(GEOID) <  2000 | as.numeric(GEOID) >  2999)
mergeddt = mergeddt|> filter(as.numeric(GEOID) != 11001)

View(mergeddt)

#County Classification
library(readxl)
CountyC <- read_excel("CountyClassification.xlsx")
View(CountyC)
CountyC<-CountyC|>filter(`State Name` != "District of Columbia" &
                           `State Name` != "Hawaii" &
                           `State Name` != "Puerto Rico" & 
                           `State Name` != "Alaska")
CountyC = CountyC|> select(`FIPS State Code`,`FIPS County Code`,`Metropolitan/Micropolitan Statistical Area`)
CountyC = unite(CountyC,col = "GEOID",c(`FIPS State Code`,`FIPS County Code`),sep = "", remove = TRUE)

#merged data for county classification and drugdthrate
finaldrugdata<-left_join(mergeddt,CountyC)
ggplot(data = finaldrugdata,aes(fill = finaldrugdata$`Metropolitan/Micropolitan Statistical Area`))+geom_sf()
finaldrugdata <- finaldrugdata %>%
  mutate(`Metropolitan/Micropolitan Statistical Area` = ifelse(is.na(`Metropolitan/Micropolitan Statistical Area`), "Rural Areas", `Metropolitan/Micropolitan Statistical Area`))
ggplot(data = finaldrugdata,aes(fill = `Metropolitan/Micropolitan Statistical Area`))+geom_sf()

finaldrugdata<-finaldrugdata|>select(-c(moe,estimate))
finaldrugdata<-finaldrugdata|>drop_na()

finaldrugdata|>group_by(`Metropolitan/Micropolitan Statistical Area`)|>summarise(n=n())

finaldrugdata|>group_by(`Metropolitan/Micropolitan Statistical Area`)|>summarise(n=mean(Drug14))

ggplot(data = finaldrugdata,aes(x = finaldrugdata$Drug14,y = finaldrugdata$`Metropolitan/Micropolitan Statistical Area`,fill = `Metropolitan/Micropolitan Statistical Area`))+geom_boxplot()
ggplot(data = finaldrugdata,aes(x = finaldrugdata$Drug18,y = finaldrugdata$`Metropolitan/Micropolitan Statistical Area`,fill = `Metropolitan/Micropolitan Statistical Area`))+geom_boxplot()

modselfdrug14 = lm(Drug14~`Metropolitan/Micropolitan Statistical Area`,data = finaldrugdata)

summary.aov(modselfdrug14)
modselfdrug18 = lm(Drug18~`Metropolitan/Micropolitan Statistical Area`,data = finaldrugdata)
summary.aov(modselfdrug18)
ggplot(data = finaldrugdata, aes(fill = Drug14)) +
  geom_sf() +
  scale_fill_viridis_c(option = "magma",direction=-1)

ggplot(data = finaldrugdata, aes(fill = Drug18)) +
  geom_sf() +
  scale_fill_viridis_c(option = "magma",direction = -1)

