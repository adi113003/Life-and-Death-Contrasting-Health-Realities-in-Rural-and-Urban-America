# Life and Death: Contrasting Health Realities in Rural and Urban America

This project analyzes **health disparities between rural and urban counties in the United States** by examining causes of death across counties. Using Social Determinants of Health (SDOH) data, the study compares self-harm, drug-related deaths, opioid deaths, and maternal mortality across counties classified as metropolitan, micropolitan, or rural.

---

## 📊 Project Overview
The main goals of this project are:
- To compare **different causes of death** at the county level between 2014 and 2018.
- To evaluate **rural vs. urban disparities** in mortality causes such as:
  - Self-harm
  - Drug overdose
  - Opioid-related deaths
  - Maternal mortality
- To conduct statistical tests (ANOVA) to check differences in mortality rates across county classifications.
- To visualize results with **boxplots and maps**.

---

## 📂 Repository Structure
- **`CountyClassification.xlsx`** → Defines county classification into metropolitan, micropolitan, or rural.
- **`SDOH_2014_COUNTY_1_0.xlsx`** → Social Determinants of Health dataset (2014).
- **`SDOH_2018_COUNTY_1_1.xlsx`** → Social Determinants of Health dataset (2018).
- **`census-cbsas.xlsx`** → Census Bureau classification for metro/micro areas.
- **`barplot.R`** → Script for generating barplots of death causes by county type.
- **`selfharm.R`** → Analysis and visualization of self-harm death rates (2014 vs. 2018).
- **`drugdth.R`** → Analysis and visualization of drug-related death rates (2014 vs. 2018).
- **`opioiddth.R`** → Analysis and visualization of opioid death rates (2014 vs. 2018).
- **`draft.R` / `draft code.R`** → Work-in-progress scripts for testing statistical analysis.
- **`Life and Death.pptx`** → Presentation summarizing project insights.
  
---

## 📈 Key Insights
- **Self-harm**: Rates vary significantly between rural and urban counties; trends differ from 2014 to 2018.
- **Drug and opioid deaths**: Increased notably in many counties, with rural areas experiencing unique vulnerabilities.
- **Maternal mortality**: Also displayed disparities when comparing metro vs. rural counties.
- **ANOVA tests** showed significant differences in mortality rates between county types, highlighting structural inequities:contentReference[oaicite:0]{index=0}.

---

## 🛠️ Tools & Libraries
The analysis is conducted in **R** with the following libraries:
- `tidyverse`, `dplyr` → Data manipulation
- `ggplot2` → Visualization (boxplots, barplots, maps)
- `readxl` → Reading Excel datasets
- `stats` → Running ANOVA tests

---

## 📊 Data Sources
- **Social Determinants of Health (SDOH) Database** (AHRQ)  
  [AHRQ SDOH Data](https://www.ahrq.gov/sdoh/data-analytics/sdoh-data.html)  
- **U.S. Census Bureau** (County classification glossary)  
  [Census.gov Glossary](https://www.census.gov/programs-surveys/metro-micro/about/glossary.html)  

---

## 🚀 How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/Life-and-Death-Analysis.git
