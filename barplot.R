library(tidycensus)
#Loading data
SDOH_2014 <- read_xlsx("SDOH_2014_COUNTY_1_0.xlsx",sheet = 2)
SDOH_2018 <- read_xlsx("SDOH_2018_COUNTY_1_1.xlsx",sheet = 2)
View(SDOH_2014)
View(SDOH_2018)
SDOH_2014 <- SDOH_2014 |> select(COUNTYFIPS,STATE,COUNTY,REGION,
                                 CDCW_INJURY_DTH_RATE,CDCW_TRANSPORT_DTH_RATE,CDCW_SELFHARM_DTH_RATE,CDCW_ASSAULT_DTH_RATE,
                                 CDCW_MATERNAL_DTH_RATE,CDCW_OPIOID_DTH_RATE,CDCW_DRUG_DTH_RATE,CDCA_STROKE_DTH_RATE_ABOVE35,
)

SDOH_2018<- SDOH_2018 |> select(COUNTYFIPS,STATE,COUNTY,REGION,CDCA_HEART_DTH_RATE_ABOVE35,
                                CDCW_INJURY_DTH_RATE,CDCW_TRANSPORT_DTH_RATE,CDCW_SELFHARM_DTH_RATE,CDCW_ASSAULT_DTH_RATE,
                                CDCW_MATERNAL_DTH_RATE,CDCW_OPIOID_DTH_RATE,CDCW_DRUG_DTH_RATE,CDCA_STROKE_DTH_RATE_ABOVE35
)
SDOH_2014<-SDOH_2014|>filter(STATE != "District of Columbia" &
                               STATE != "Hawaii" &
                               STATE!= "Puerto Rico" & 
                               STATE != "Alaska")

SDOH_2018<-SDOH_2018|>filter(STATE != "District of Columbia" &
                               STATE != "Hawaii" &
                               STATE!= "Puerto Rico" & 
                               STATE != "Alaska")

SDOH_2014 <- SDOH_2014|>drop_na()
SDOH_2018 <- SDOH_2018|>drop_na()
SDOH_2014 <- SDOH_2014|>
SDOH_2014 <- SDOH_2014|>select(-CDCA_STROKE_DTH_RATE_ABOVE35)
SDOH_2018 <- SDOH_2018|>select(-CDCA_HEART_DTH_RATE_ABOVE35)
nowLong = pivot_longer(data = SDOH_2014,
                       cols = !c(COUNTYFIPS,STATE,COUNTY,REGION),
                       names_to = c("Variable"),
                       #names_sep = "_",
                       values_to = "Value")
ggplot(data=nowLong, aes(x=Variable, y=log(Value))) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=Variable), vjust=1.6, color="white", size=3.5)+
  theme_minimal()
nowLong1 = pivot_longer(data = SDOH_2018,
                       cols = !c(COUNTYFIPS,STATE,COUNTY,REGION),
                       names_to = c("Variable"),
                       #names_sep = "_",
                       values_to = "Value")
ggplot(data=nowLong1, aes(x=Variable, y=Value)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=Variable), vjust=1.6, color="white", size=3.5)+
  theme_minimal()