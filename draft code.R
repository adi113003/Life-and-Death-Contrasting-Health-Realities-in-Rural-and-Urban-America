library(readxl)
library(tidyverse)
library(sf)
SDOH_2014 <- read_xlsx("SDOH_2014_COUNTY_1_0.xlsx",sheet = 2)
SDOH_2018 <- read_xlsx("SDOH_2018_COUNTY_1_1.xlsx",sheet = 2)
View(SDOH_2014)
View(SDOH_2018)
#filtering
SDOH_2014 <- SDOH_2014 |> select(COUNTYFIPS,STATE,COUNTY,REGION,CDCA_HEART_DTH_RATE_ABOVE35,
                                 CDCW_INJURY_DTH_RATE,CDCW_TRANSPORT_DTH_RATE,CDCW_SELFHARM_DTH_RATE,CDCW_ASSAULT_DTH_RATE,
                                 CDCW_MATERNAL_DTH_RATE,CDCW_OPIOID_DTH_RATE,CDCW_DRUG_DTH_RATE,CDCA_STROKE_DTH_RATE_ABOVE35,
                                 )

SDOH_2018<- SDOH_2018 |> select(COUNTYFIPS,STATE,COUNTY,REGION,CDCA_HEART_DTH_RATE_ABOVE35,
                                CDCW_INJURY_DTH_RATE,CDCW_TRANSPORT_DTH_RATE,CDCW_SELFHARM_DTH_RATE,CDCW_ASSAULT_DTH_RATE,
                                CDCW_MATERNAL_DTH_RATE,CDCW_OPIOID_DTH_RATE,CDCW_DRUG_DTH_RATE,CDCA_STROKE_DTH_RATE_ABOVE35,
                                )
SDOH_2014<-SDOH_2014|>filter(STATE != "District of Columbia" &
                               STATE != "Hawaii" &
                               STATE!= "Puerto Rico" & 
                               STATE != "Alaska")

SDOH_2018<-SDOH_2018|>filter(STATE != "District of Columbia" &
                               STATE != "Hawaii" &
                               STATE!= "Puerto Rico" & 
                               STATE != "Alaska")
#Map Work
usmapd <- st_read("C:/Users/adith/OneDrive/Desktop/Project DRP/gadm41_USA_shp (1)/gadm41_USA_2.shp")
usmapd<-usmapd|>filter(NAME_1 != "District of Columbia" &
                         NAME_1 != "Hawaii" &
                         NAME_1!= "Puerto Rico" & 
                         NAME_1 != "Alaska")
usmapd<- usmapd|>select(NAME_2,geometry)
SDOH_2014$COUNTY<-gsub("County","", SDOH_2014$COUNTY)
SDOH_2014<-SDOH_2014|>rename(NAME_1 = STATE)
SDOH_2014<-SDOH_2014|>rename(NAME_2 = COUNTY)
SDOH_2014<-SDOH_2014|>select(-c(COUNTYFIPS,REGION))
dt1 = left_join(usmapd,SDOH_2014)
#dt5 = full_join(usmapd, SDOH_2014)
# View(dt3)

#dt3 <- dt3|>select(NAME_2,geometry)

#dt6 <- merge(dt5, SDOH_2014, by = "NAME_2")
#View(dt6)

nowLong = pivot_longer(data = SDOH_2014,
                       cols = !c(COUNTYFIPS,STATE,COUNTY,REGION),
                       names_to = c("Variable"),
                       #names_sep = "_",
                       values_to = "Value")
nowLong = nowLong|>
ggplot(data=nowLong, aes(x=Variable, y=Value)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=Variable), vjust=1.6, color="white", size=3.5)+
  theme_minimal()
SDOH_2014<-SDOH_2014|>drop_na()
