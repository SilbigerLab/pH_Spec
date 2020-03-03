########################################################################
### This calculates the pH using the m-cresol spec method: Dickson SOP6a
### NOTE: you MUST use the pHinsi function from seacarb to calculate the in situ pH at in situ temperature during sample collection.
### This script only exports the pH in the lab.
### Created by Dr. Nyssa Silbiger
### Edited on 1/9/2020
#########################################################################

## create a folder for your day of sampling (foldername below) and put your plate.csv files in there. All your data will be exported to that folder

#libraries
library(tidyverse)
library(seacarb)

## File names -------------------
foldername<-'Katie_20200117' # folder of the day
filename<-'TrisPlate_2-25-2020.csv' # data
sampleID<-'TrisPlate_2-25-2020_Template.csv' # template of sample IDs
platename<-'TrisPlate20200225' # this will be the name of your file

## Temp and Salinity ----------
#Temeperataure pH was run at IN THE LAB
Temperature<-25
Salinity<-34 # note if you have a range of salinities then import a file with all salinities and modify script below (add a column with sample IDs and left_join with AllData Df)

### Temperature in situ (either in the aquarium or in the field)#####
## If you want to calculate insitu pH then enter TRUE in the statement below and the filename with the temperature files, if not enter FALSE
CalculateInSitu<-TRUE
TempInSituFileName<-'TrisTempInSitu.csv' #file name of the in situ temperatures. (enter the sample IDs identical to the pH sample ID template)  

# Change slope and intercept with each new batch of dye --------------
# Dye created by: Katherine Hannibal
# Date created: 1-20-20
dye_intercept<-17.228
dye_slope<--0.5959

# DONT CHANGE ANYTHING BELOW HERE ----------------------------------

# read in the in situ temp data if true
if(CalculateInSitu==TRUE){
  TempInSitu<-read.csv(paste0('Data/',foldername,'/',TempInSituFileName))
}


# Read in the Sample IDs
sampleIDNames<-read.csv(paste0('Data/',foldername,'/',sampleID))
sampleIDNames<-sampleIDNames %>%
  select(Well.Location, Sample.Name) # pull out the location and the IDs

### format the 96 well plate data ################
#read in the rows w/o the dye
NoDye<-read.csv(paste0('Data/',foldername,'/',filename), row.names = c("A","B","C","D","E","F","G","H"),nrows = 8, fileEncoding="latin1", skip = 2)
# make the rownames a column
NoDye$Rows<-rownames(NoDye)

## read in the rows with the dye
Dye<-read.csv(paste0('Data/',foldername,'/',filename), row.names = c("A","B","C","D","E","F","G","H"),nrows = 8, fileEncoding="latin1", skip = 14)
Dye$Rows<-rownames(Dye)

## Pull out each of the wavelengths to make own column
#730 No Dye
NoDye_730<-NoDye %>%
  select(Rows,X1:X12)%>%
  pivot_longer(cols = X1:X12, values_to =  "NoDye_730", names_to = "Column")

#578 No Dye
NoDye_578<-NoDye %>%
  select(Rows,X1.1:X12.1)%>% # pull out the 578 columns
  pivot_longer(cols = X1.1:X12.1, values_to =  "NoDye_578", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .1

#434 No Dye
NoDye_434<-NoDye %>%
  select(Rows,X1.2:X12.2)%>% # pull out the 578 columns
  pivot_longer(cols = X1.2:X12.2, values_to =  "NoDye_434", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .2

## with dye
#730 Dye
Dye_730<-Dye %>%
  select(Rows,X1:X12)%>%
  pivot_longer(cols = X1:X12, values_to =  "Dye_730", names_to = "Column")

#578 Dye
Dye_578<-Dye %>%
  select(Rows,X1.1:X12.1)%>% # pull out the 578 columns
  pivot_longer(cols = X1.1:X12.1, values_to =  "Dye_578", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .1

#434 Dye
Dye_434<-Dye %>%
  select(Rows,X1.2:X12.2)%>% # pull out the 578 columns
  pivot_longer(cols = X1.2:X12.2, values_to =  "Dye_434", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .2

## bring everything to one dataframe (reduce allows me to use the left_join function multiple times at once)
AllData<-Reduce(function(...) left_join(...), list(NoDye_730,NoDye_578,NoDye_434,Dye_730,Dye_578,Dye_434))

# remove the X in the column name and add a 0 in front of single digits to keep the well name similar to how the instrument exports
AllData<-AllData %>%
  mutate(Column = as.numeric(str_remove(AllData$Column, pattern = "X")))%>% # remove the X
  mutate(Column = ifelse(Column<10, gsub("(\\d)+", "0\\1", Column),Column))%>% # only add a 0 in front of 1-9
  mutate(Well.Location = paste0(Rows,Column)) # paste with row name

### Run pH Analysis ##################

pHData<-AllData %>%
  mutate(A1_A2 = (Dye_578-NoDye_578-(Dye_730-NoDye_730))/(Dye_434-NoDye_434-(Dye_730-NoDye_730)), #A1/A2
         A1_A2_corr = A1_A2+(dye_intercept+(dye_slope*A1_A2))*0.005,  #correct for the dye
         pH_in_lab = as.numeric(pHspec(S = rep(Salinity,96), T = rep(Temperature,96), R = A1_A2_corr)),# calculate the pH
         pHtris = as.numeric(tris(S= rep(Salinity,96),T=rep(Temperature,96))), ## calculate pH of tris,
         pHtris_error = abs(((pHtris-pH_in_lab)/pHtris)*100), # calculate error from tris
         daterun = Sys.Date()) %>%
  left_join(sampleIDNames)%>% # join with the sampleIDs
  left_join(TempInSitu) %>% # join with the temperature data
  drop_na() # remove the empty wells

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

