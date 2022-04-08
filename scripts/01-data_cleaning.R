#### Preamble ####
# Purpose: Clean the survey data downloaded from Canadian GSS
# Author: -Zihan Zhang
# Data: 15 March 2021
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!



#### Workspace setup ####

library(janitor)
library(tidyverse)
# Read in the raw data. 
raw_data <- readr::read_csv("inputs/data/raw data.csv")
# Just keep some variables that may be of interest (change 
# this depending on your interests)



         
# Fix the names
cleandata <- raw_data %>% 
  clean_names() %>%
  rename(age_group = agegr10,
         marital_status = marstat,
         number_of_children= chh0014c,
         ourdoor_activities = oda_01m,
         hours_worked = whw120gr,
         stresslevel = smg_01,
         source_of_stress= smg_02,
         alcohol_consumption = drr_110,
         smoking_status=smk_05,
         job_satisfaction = jsr_02,
         discrimination_Frequency=dbh_02,
         living_standard = dos_01,
         health_level= dos_02,
         personal_relationship_level=dos_04,
         appearance_level = dos_05)

clean_data <- cleandata %>%
  filter(stresslevel <= '5') %>%
  filter(smoking_status <= '3') %>%
  filter(alcohol_consumption <= '7') %>%
  filter(source_of_stress <= '7') %>%
  filter(living_standard <= '10') %>%
  mutate(stress = case_when(stresslevel == '1' ~"Not at all stressful",
                            stresslevel == '2' ~ "Not very stressful",
                            stresslevel == '3' ~ "A bit stressful",
                            stresslevel == '4' ~ "Quite A bit stressful",
                            TRUE ~ "Extremely stressful")) 



write_csv(clean_data, "inputs/data/clean data.csv")

         
