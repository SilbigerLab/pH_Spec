########################################################################
### This calculates the Chlorophyll from a 96 well plate in corals from teh SpectraMax iD5
### 
### Created by Dr. Nyssa Silbiger
### Edited on 07/10/2025
#########################################################################

## create a folder for your day of sampling (foldername below) and put your plate.csv files in there. All your data will be exported to that folder

#libraries
library(here)
library(tidyverse)


## File names -------------------
foldername<-'test_chl' # folder of the day
filename<-'testchl2.csv' # data
sampleID<-'Chl_template_test.csv' # template of sample IDs
platename<-'plate1_test' # this will be the name of your file

## What is the path length?
PL<-0.71 # pathlength for donahue lab plate

## Temp and Salinity ----------
#Temeperataure pH was run at IN THE LAB
Temperature<-22.9
Salinity<-34 # note if you have a range of salinities then import a file with all salinities and modify script below (add a column with sample IDs and left_join with AllData Df)

### Temperature in situ (either in the aquarium or in the field)#####
## If you want to calculate insitu pH then enter TRUE in the statement below and the filename with the temperature files, if not enter FALSE
CalculateInSitu<-FALSE
TempInSituFileName<-'TempInSitu.csv' #file name of the in situ temperatures. (enter the sample IDs identical to the pH sample ID template)  

# Change slope and intercept with each new batch of dye --------------
# Dye created by: Jenn Fields
# Date created: 7-08-2022
dye_intercept<-14.504
dye_slope<--0.5663

# Change slope and intercept with each new batch of dye --------------
# Dye created by: Jenn Fields
# Slope recreated by Robert Dellinger
# Date created: 8-09-2022
#dye_intercept<-18.825
#dye_slope<--0.581

# Second Dye created by Deme Panos
# Use the following intercept and slope for Moorea spec runs
#dye_intercept<-14.653
#dye_slope<--0.5694

# DONT CHANGE ANYTHING BELOW HERE ----------------------------------

# read in the in situ temp data if true
if(CalculateInSitu==TRUE){
  TempInSitu<-read.csv(paste0('Data/',foldername,'/',TempInSituFileName))
}


# Read in the Sample IDs
sampleIDNames<-read_csv(here('Data',foldername,sampleID))
sampleIDNames<-sampleIDNames %>%
  select(Well.Location, Sample.Name) # pull out the location and the IDs

### format the 96 well plate data ################
#read in the rows w/o the dye
ChlPlate<-read.csv(here('Data',foldername,filename), row.names = c("A","B","C","D","E","F","G","H"),nrows = 8, fileEncoding="latin1", skip = 2)
# make the rownames a column
ChlPlate$Rows<-rownames(ChlPlate)

## Pull out each of the wavelengths to make own column
#630 wavelength
ChlPlate_630<-ChlPlate %>%
  select(Rows,X1:X12)%>%
  pivot_longer(cols = X1:X12, values_to =  "ChlPlate_630", names_to = "Column")

#663 wavelength
ChlPlate_663<-ChlPlate %>%
  select(Rows,X1.1:X12.1)%>% # pull out the 663 columns
  pivot_longer(cols = X1.1:X12.1, values_to =  "ChlPlate_663", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .1

#750 wavelength
ChlPlate_750<-ChlPlate %>%
  select(Rows,X1.2:X12.2)%>% # pull out the 750 columns
  pivot_longer(cols = X1.2:X12.2, values_to =  "ChlPlate_750", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .2


## bring everything to one dataframe (reduce allows me to use the left_join function multiple times at once)
AllData<-Reduce(function(...) left_join(...), list(ChlPlate_630,ChlPlate_663,ChlPlate_750))

# remove the X in the column name and add a 0 in front of single digits to keep the well name similar to how the instrument exports
AllData<-AllData %>%
  mutate(Column = as.numeric(str_remove(AllData$Column, pattern = "X")))%>% # remove the X
  mutate(Column = ifelse(Column<10, gsub("(\\d)+", "0\\1", Column),Column))%>% # only add a 0 in front of 1-9
  mutate(Well.Location = paste0(Rows,Column)) # paste with row name

### Run pH Analysis ##################
# chl from Jeffry and Humphreys
ChlData<-AllData %>%
  mutate(chla = 11.43*(ChlPlate_663 - ChlPlate_750 / PL) - 0.64*(ChlPlate_630 - ChlPlate_750/PL),
         chlc = 27.09*(ChlPlate_630 - ChlPlate_750 / PL) - 3.63*(ChlPlate_663 - ChlPlate_750/PL),
         Totalchl = chla+chlc,
           daterun = Sys.Date()) %>%
  left_join(sampleIDNames) %>% # join with the sampleIDs
  drop_na(Sample.Name)

# averaged data by sample ID
ChlData_ave<-ChlData %>%
  group_by(Sample.Name) %>%
  summarise_at(vars(chla:Totalchl), .funs = list(function(x){mean(x, na.rm = TRUE)},
                                                 function(x){sd(x, na.rm = TRUE)}/sqrt(n()))) %>%
  rename(chla_mean = chla_fn1, chlc_mean=chlc_fn1, TotalChl_mean = Totalchl_fn1,
         chla_SE = chla_fn2, chlc_SE = chlc_fn2, Totalchl_SE = Totalchl_fn2) %>%
  select(Sample.Name,chla_mean,chla_SE,chlc_mean,chlc_SE,TotalChl_mean,Totalchl_SE) # put in a better order
  

### rename the columns to be easier!

# run this block if calculating in situ pH
  if(CalculateInSitu==TRUE){
    pHData<-pHData %>%
      mutate(pHinsitu = pHinsi(pH = pH_in_lab, Tinsi = TempInSitu, Tlab = Temperature, pHscale = "T")) # calculate insitu pH
  }

### Export the data
## all the info
write.table(pHData,paste0("Data/",foldername,"/pHoutputFull",platename,".csv"),sep=",", row.names=FALSE)

## only the pH data with means and SE of triplicates
if(CalculateInSitu==TRUE){
  pHData %>% 
  select(Sample.Name, pHinsitu)%>% 
  group_by(Sample.Name)%>%
  summarise(pHmean = mean(pHinsitu, na.rm=TRUE), SE = sd(pHinsitu, na.rm=TRUE)/n())%>%
  write.table(.,paste0("Data/",foldername,"/pH_simple",platename,".csv"),sep=",", row.names=FALSE)
}

if(CalculateInSitu==FALSE){
  pHData %>% 
    select(Sample.Name, pH_in_lab)%>% 
    group_by(Sample.Name)%>%
    summarise(pHmean = mean(pH_in_lab, na.rm=TRUE), SE = sd(pH_in_lab, na.rm=TRUE)/n())%>%
    write.table(.,paste0("Data/",foldername,"/pH_simple",platename,".csv"),sep=",", row.names=FALSE)
}

