# Preprocessing script for hobo logger data
# Brings in sinlge raw .csv files and exports tidy files into both a general tidy folder for temporary storage and an output folder

rm(list=ls())
library(tidyverse)
library(lubridate)
########################
# File Names
########################
foldername<-'20200303' # folder of the day
date <- '20200303' # today's date
filename<-'SN 20719197 2020-03-03 15_20_41 -0800.csv' # data file
serial<-'SN197' # serial ID for the probe
Launch<-'2020-03-03 10:43:00' # Maintain date time format "2020-03-04 14:15:00"
Retrieval<-'2020-03-03 15:19:00' # Maintain date time format "2020-03-04 21:30:00"

# Tidy the data for processing
pH_probe<-read_csv(paste0('Data/HOBO_MX2501/hobo_logger',foldername,'/',filename),
  col_names = TRUE,
  skip=2, #skips top rows containing instrument information
  col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
pH_probe<-pH_probe %>%
  drop_na(pH) %>% #remove empty rows
  rename( #rename column headings
    PST=contains("Date"),
    Temp_degC=contains("Temp"))
# Convert PST to date and time vector type
pH_probe$PST <- pH_probe$PST %>%
  parse_datetime(format = "%m/%d/%y %H:%M", na = character(),
                 locale = default_locale(), trim_ws = TRUE)
# Filter data to only include deployment data
Launch <- Launch %>%
  parse_datetime(format = "%Y-%m-%d %H:%M:%S", na = character(),
                 locale = default_locale(), trim_ws = TRUE)
Retrieval <- Retrieval %>%
  parse_datetime(format = "%Y-%m-%d %H:%M:%S", na = character(),
                 locale = default_locale(), trim_ws = TRUE)
pH_probe <- pH_probe %>%
  filter(between(PST,Launch,Retrieval))
View(pH_probe)
write_csv(pH_probe,paste0('Data/HOBO_MX2501/hobo_logger/tidy_data/pH_',serial,'_',date,'.csv'))
write_csv(pH_probe,paste0('Data/HOBO_MX2501/hobo_logger/output/pH_',serial,'_',date,'.csv'))
