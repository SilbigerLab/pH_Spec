########################################################################
### This cleans raw spec data when exported "by plate" into a long format by wavelength
### Created by Danielle Barnas (modified original script by Dr. Nyssa Silbiger)
### Edited on 2/18/2021
#########################################################################

rm(list=ls())

#libraries
library(tidyverse)

## File names -------------------
foldername<-'DBarnas/20201109_BadRead' # folder of the day
filename<-'Plate3_Data.csv' # data
sampleID<-'Plate3_Template.csv' # template of sample IDs
platename<-'Plate3' # this will be the name of your file


# DONT CHANGE ANYTHING BELOW HERE ----------------------------------


# Read in the Sample IDs
sampleIDNames<-read.csv(paste0('Data/',foldername,'/',sampleID))
sampleIDNames<-sampleIDNames %>%
  select(Well.Location, Sample.Name) # pull out the location and the IDs

### format the 96 well plate data ################
#read in the rows
NoDye<-read_csv(paste0('Data/',foldername,'/',filename),skip = 2) %>%
  select(-X1) %>%
  rename(Temperature = contains("Temp")) %>%
  drop_na(Temperature)

# make the rownames a column
NoDye <- NoDye %>%
  mutate(Wavelength=c("WL750","WL664","WL647","WL630","WL449"))

# pivot
NoDye <- NoDye %>%
  pivot_longer(cols = A1:H12, names_to = "Well.Location", values_to = "Absorbance") %>%
  pivot_wider(names_from = Wavelength, values_from = Absorbance)

# add a 0 in front of single digits to keep the well name similar to how the instrument exports
AllData<-NoDye %>%
  separate(Well.Location, into=c("Rows", "Column"), sep = 1, remove = F)
AllData$Column<-as.numeric(AllData$Column)
AllData<-AllData %>%
  mutate(Column = ifelse(Column < 10, paste0("0",Column), Column)) %>% # only add a 0 in front of 1-9
  unite(Well.Location, c(Rows,Column), sep = "", remove = F)


AllData<-AllData %>%
  left_join(sampleIDNames) %>% # join with the sampleIDs
  drop_na() # remove the empty wells

### Export the data
## all the info
write_csv(AllData,paste0("Data/",foldername,"/Output/",platename,".csv"))


