######### Cleaning and Graphing pH logger data #################

rm(list=ls())
library(tidyverse)
library(lubridate)
library(ggplot2)
library(seacarb)
library(ggpubr)


##################################
# Folder and file names
##################################
hobo.folder<- 'Data/HOBO_MX2501/hobo_logger/tidy_data' # path to hobo data folder
spec.folder<- 'Data/HOBO_MX2501/spec_data/20200303/pH_simple' # path to spec data folder
TempInSitu<- 'Data/HOBO_MX2501/spec_data/20200303/TrisTempInSitu.csv' # Temperature file
RunTime<- 'Data/HOBO_MX2501/spec_data/20200303/SpecRunTime.csv' # File containing time of spec start
output<-'Data/HOBO_MX2501/output/' # output folder for graphs
date<-'20200303' # today's date

##################################
# Bring in and join spec and hobo files
##################################
#options(na.action = "na.omit") 
#group pH data from all Hobo loggers together
hobo.ph.data <-
  list.files(path = hobo.folder,pattern = ".csv", full.names = TRUE) %>% # list files in directory following a particular pattern
 # set_names(.) %>% # get the column names
  map_dfr(read.csv, .id = "file.ID") %>% # join all files together in one data frame by file ID (path and file name)
  group_by(file.ID) %>%
  rename(Temp.hobo='Temp_degC',pH.hobo='pH',mV.hobo='mV')
hobo.ph.data$PST<-as.character(hobo.ph.data$PST) # parse column to character class
hobo.ph.data$PST<- hobo.ph.data$PST %>% parse_datetime(format = "%F %T %Z", 
                                                       na = character(), 
                                                       locale = default_locale(), 
                                                       trim_ws = TRUE) # format date and time, %F = %Y-%m-%d, %T = %H:%M:%S
# specific to each hobo serial number and file.ID
hobo.ph.data$file.ID[hobo.ph.data$file.ID=='1']<- "SN195"
hobo.ph.data$file.ID[hobo.ph.data$file.ID=='2']<- "SN197"
#View(hobo.ph.data)

spec.ph.data <-
  list.files(path = spec.folder,pattern = ".csv", full.names = TRUE) %>% # list files in directory following a particular pattern
#  set_names(.) %>% # get the column names
  map_dfr(read.csv, .id = "file.ID") %>% # join all files together in one data frame by file ID (path and file name)
  select(-file.ID) %>%
  add_column(ID='Spec')
Temp.data<-read_csv(TempInSitu,col_names = TRUE)
Time.data<-read_csv(RunTime,col_names = TRUE)
spec.ph.data<-spec.ph.data %>%
  left_join(Temp.data,spec.ph.data,by='Sample.Name') %>%
  left_join(Time.data,spec.ph.data,by='Sample.Name') %>%
  rename(pHmean.spec = pHmean,SE.spec=SE)
#View(spec.ph.data)

wide.data<-inner_join(hobo.ph.data,spec.ph.data,by='PST')
#View(wide.data)

#################################
# Graphing spec and hobo data (wide form)
#################################
hobo.195<-wide.data %>%
  filter(file.ID=='SN195')
hobo.197<-wide.data %>%
  filter(file.ID=='SN197')

PlotpH.wide<-ggplot(data=wide.data,aes(y=pHmean.spec,x=pH.hobo)),fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='HOBO pH',y='Mean Spec pH', fill='HOBO Logger')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
#PlotpH.wide
PlotmV.wide<-ggplot(data=wide.data,aes(x=pH.hobo,y=mV.hobo)),fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='HOBO pH',y='HOBO mV', fill='HOBO Logger')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
#PlotmV.wide

# multiple r-squared value for pH of hobos and spec
Model.all.ph<-lm(pHmean.spec~pH.hobo,data=wide.data)
summary(Model.all.ph)
Model.all.ph
Model.195<-lm(pHmean.spec~pH.hobo,data=hobo.195)                       
summary(Model.195)
Model.195
Model.197<-lm(mV.hobo~pH.hobo,data=hobo.197)                       
summary(Model.197)
Model.197

#################################
# Graphing spec and hobo data (long form)
#################################
spec.data<-spec.ph.data
hobo.data<-hobo.ph.data %>%
  left_join(spec.data,hobo.data,by='PST') %>%
  drop_na() %>%
  select(-c(Sample.Name,pHmean.spec,SE.spec,TempInSitu,ID)) %>%
  rename(pHmean='pH.hobo',Temp_degC='Temp.hobo')
spec.data<-spec.data %>%
  rename(file.ID='ID',pHmean='pHmean.spec',Temp_degC='TempInSitu') %>%
  select(-c(SE.spec,Sample.Name))
long.data<-bind_rows(hobo.data,spec.data)
#View(long.data)

# subset data
spec.195<-long.data %>% # data for spec and hobo 195
  filter(file.ID=='SN195'|file.ID=='Spec')
spec.197<-long.data %>% # data for spec and hobo 197
  filter(file.ID=='SN197'|file.ID=='Spec')
hobo.195.and.197<-long.data %>% # data for both hobos 195 and 197
  filter(file.ID=='SN195'|file.ID=='SN197')

# graphing
PlotTemp.long<-ggplot(data=long.data,aes(y=Temp_degC,x=PST,fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Time',y='Temp degC', fill='Logger')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "top", label.x = NULL,
                        label.y = NULL, output.type = "expression")
PlotTemp.long
PlotpHTemp.long<-ggplot(data=spec.197,aes(y=pHmean,x=Temp_degC,fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Temp',y='Mean pH', fill='Logger')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")
PlotpHTemp.long
PlotpHTime.long<-ggplot(data=spec.197,aes(y=pHmean,x=PST,fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Time',y='Mean pH', fill='Logger')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"pH-Time_specHOBO_",date,".png"))
PlotpHTime.long

# modeling
# comparing temperature data between and among hobo's and sensitive thermometer
Reg.Model<-lm(Temp_degC~PST,data=long.data)
summary(Reg.Model)
Reg.Model
# comparing pH of SN197 to spec ~ time
RegModel.time<-lm(pHmean~PST,data=spec.197) 
summary(RegModel.time)
RegModel.time
# comparing pH of SN197 to spec ~ temperature
RegModel.temp<-lm(pHmean~Temp_degC,data=spec.197) 
summary(RegModel.temp)
RegModel.temp

# seacarb pH conversion and plotting SN197
TS.spec<-spec.data %>%
  rename(pH_TS='pHmean')
hobo.convert<-hobo.195.and.197 %>% # dataframe of only spec and hobo 197 data, converting nbs to total scale pH
  group_by(pHmean) %>%
  mutate(pH_TS=pHconv(flag=1,pH=pHmean,S=34,T=Temp_degC,ks="d")) %>%
  filter(file.ID=='SN197'|file.ID=='Spec') %>%
  bind_rows(TS.spec)

PlotpH.TS<-ggplot(data=hobo.convert,aes(y=pH_TS,x=PST))+#,fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Time',y='Mean pH', fill='Logger')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")#+
  ggsave(paste0(output,"TotalScalepH_bestfit_",date,".png"))
PlotpH.TS
ConvertModel<-lm(pH_TS~PST,data=hobo.convert)
summary(ConvertModel)
