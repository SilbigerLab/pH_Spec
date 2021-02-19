########################################################################
### This cleans raw spec data when exported "by plate" into a long format by wavelength
### Created by Danielle Barnas (modified original script by Dr. Nyssa Silbiger)
### Edited on 2/18/2021
#########################################################################

rm(list=ls())

#libraries
library(tidyverse)

## File names -------------------
foldername<-'DBarnas/20210218' # folder of the day
filename<-'DI_Test2.csv' # data
sampleID<-'DI_Test2_Template.csv' # template of sample IDs
platename<-'DI_Test2' # this will be the name of your file


# DONT CHANGE ANYTHING BELOW HERE ----------------------------------


# Read in the Sample IDs
sampleIDNames<-read.csv(paste0('Data/',foldername,'/',sampleID))
sampleIDNames<-sampleIDNames %>%
  select(Well.Location, Sample.Name) # pull out the location and the IDs

### format the 96 well plate data ################
#read in the rows w/o the dye
NoDye<-read.csv(paste0('Data/',foldername,'/',filename), row.names = c("A","B","C","D","E","F","G","H"),nrows = 8, fileEncoding="latin1", skip = 2)
# make the rownames a column
NoDye$Rows<-rownames(NoDye)

## Pull out each of the wavelengths to make own column
#750 No Dye
NoDye_750<-NoDye %>%
  select(Rows,X1:X12)%>%
  pivot_longer(cols = X1:X12, values_to =  "NoDye_750", names_to = "Column")

#664 No Dye
NoDye_664<-NoDye %>%
  select(Rows,X1.1:X12.1)%>% # pull out the 664 columns
  pivot_longer(cols = X1.1:X12.1, values_to =  "NoDye_664", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .1

#647 No Dye
NoDye_647<-NoDye %>%
  select(Rows,X1.2:X12.2)%>% # pull out the 647 columns
  pivot_longer(cols = X1.2:X12.2, values_to =  "NoDye_647", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .2

#630 No Dye
NoDye_630<-NoDye %>%
  select(Rows,X1.3:X12.3)%>% # pull out the 630 columns
  pivot_longer(cols = X1.3:X12.3, values_to =  "NoDye_630", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .2

#449 No Dye
NoDye_449<-NoDye %>%
  select(Rows,X1.4:X12.4)%>% # pull out the 449 columns
  pivot_longer(cols = X1.4:X12.4, values_to =  "NoDye_449", names_to = "Column") %>%
  separate(col = Column, extra = "drop", into = 'Column') # remove the .2



## bring everything to one dataframe (reduce allows me to use the left_join function multiple times at once)
AllData<-Reduce(function(...) left_join(...), list(NoDye_750,NoDye_664,NoDye_647,NoDye_630,NoDye_449))

# remove the X in the column name and add a 0 in front of single digits to keep the well name similar to how the instrument exports
AllData<-AllData %>%
  mutate(Column = as.numeric(str_remove(AllData$Column, pattern = "X")))%>% # remove the X
  mutate(Column = ifelse(Column<10, gsub("(\\d)+", "0\\1", Column),Column))%>% # only add a 0 in front of 1-9
  mutate(Well.Location = paste0(Rows,Column)) # paste with row name


AllData<-AllData %>%
  left_join(sampleIDNames) %>% # join with the sampleIDs
  drop_na() # remove the empty wells

### Export the data
## all the info
write_csv(AllData,paste0("Data/",foldername,"/Output/",platename,".csv"))


