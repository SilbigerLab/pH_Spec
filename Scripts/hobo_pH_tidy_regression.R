######### Cleaning and Graphing pH logger data #################

rm(list=ls())
library(tidyverse)
library(lubridate)
library(ggplot2)
library(seacarb)
library(ggpubr)
library(broom)
library(car)
library(rstatix)


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

#group data from all Hobo logger files together
hobo.ph.data <-
  list.files(path = hobo.folder,pattern = ".csv", full.names = TRUE) %>% # list files in directory following a particular pattern #options(na.action = "na.omit") 
 # set_names(.) %>% # get the column names
  map_dfr(read.csv, .id = "file.ID") %>% # join all files together in one data frame by file ID (path and file name)
  group_by(file.ID) %>%
  rename(Temp.hobo='Temp_degC',pH.hobo='pH',mV.hobo='mV')
hobo.ph.data$PST<-as.character(hobo.ph.data$PST) # parse column to character class
hobo.ph.data$PST<- hobo.ph.data$PST %>% parse_datetime(format = "%F %T %Z", na = character(), locale = default_locale(), trim_ws = TRUE) # format date and time, %F = %Y-%m-%d, %T = %H:%M:%S

# specific to each hobo serial number and file.ID
hobo.ph.data$file.ID[hobo.ph.data$file.ID=='1']<- "SN195"
hobo.ph.data$file.ID[hobo.ph.data$file.ID=='2']<- "SN197"

# average hobo data every minute
hobo.ph.data <- hobo.ph.data %>%
  group_by(file.ID, PST=cut(PST, "60 sec")) %>%
  summarise(Temp.hobo = mean(Temp.hobo), 
            mV.hobo = mean(mV.hobo), 
            pH.hobo = mean(pH.hobo, na.rm = TRUE))
hobo.ph.data$PST<-as.character(hobo.ph.data$PST) # parse column to character class
hobo.ph.data$PST<- hobo.ph.data$PST %>% parse_datetime(format = "%F %T", na = character(), locale = default_locale(), trim_ws = TRUE) # format date and time, %F = %Y-%m-%d, %T = %H:%M:%S
#View(hobo.ph.data)

#group data from all spec files together
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

PlotpH.wide<-ggplot(data=hobo.197,aes(y=pHmean.spec,x=pH.hobo))+#,fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='HOBO pH (NBS)',y='Mean Spec pH (TS)')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "top", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"spec-hobo_pH_bestfit_",date,".png"))
PlotpH.wide #spec pH ~ hobo pH

PlotmV.wide<-ggplot(data=hobo.197,aes(y=pHmean.spec,x=mV.hobo))+#,fill=file.ID))+ # basic plot
  geom_point()+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='HOBO mV',y='Mean Spec pH (TS)')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"spec-hobo_mV_bestfit_",date,".png"))
PlotmV.wide #spec pH ~ hobo mV

# ANCOVA
# check homogeneity of regression slopes to make sure there is no significant interaction between the covariat and grouping variable
hobo.197 %>%
  anova_test(pHmean.spec~PST * pH.hobo) # yields p-value=NA for PST:pH.hobo ??? if group:pretest p is not significant, then we can assume homogeneity of regression slopes
# check normality of residuals
model.197<-lm(pHmean.spec~pH.hobo + PST,data=hobo.197) # fit the model, spec pH ~ hobo 197 pH
model.197.metrics <-augment(model.197) %>%
  select(-.hat,-.sigma,-.fitted,-.se.fit) # remove undeeded details
head(model.197.metrics,3)
# assess normality of residuals using shapiro wilk test
shapiro_test(model.197.metrics$.resid) # if p value was not significant, then we can assume normality of residuals
# use Levene's test to check homogeneity of variances
model.197.metrics %>%
  levene_test(.resid ~ PST)
# check for outliers
model.197.metrics %>%
  filter(abs(.std.resid) > 3) %>%
  as.data.frame() # if returns 0 rows or 0-length row.names then there were no outliers in the data, as assessed by no cases with standardized residuals greater than 3 in abs value
# run ancova to test significant diff between hobo and spec pH's
model.ancova<-hobo.197 %>%
  anova_test(pHmean.spec ~ pH.hobo + PST)
get_anova_table(model.ancova)
# having some issues
# no p value for PST:pH.hobo in first anova_test. returns "NA"
# no statistic or p value for levene_test. returns "NaN"
# ancova code adapted from https://www.datanovia.com/en/lessons/ancova-in-r/

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


# Graphing Temperature of spec and hobos to Time
Temp_Loggers<-long.data$file.ID
PlotTemp.long<-ggplot(data=long.data,aes(y=Temp_degC,x=PST,fill=Temp_Loggers))+ # basic plot
  geom_point(aes(colour=Temp_Loggers))+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Time',y='Temp degC', fill='Temp_Loggers')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(colour=Temp_Loggers, label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "top", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"Temperature_",date,".png"))
PlotTemp.long # spec and hobo temp ~ time
Temp_Loggers<-long.data$file.ID
PlotTemp.long<-ggplot(data=long.data,aes(y=Temp_degC,x=PST))+ # basic plot
  geom_point(aes(colour=Temp_Loggers))+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Time',y='Temp degC')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "top", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"Temperature_bf_",date,".png"))
PlotTemp.long # spec and hobo temp ~ time
# comparing temperature data between and among hobo's and sensitive thermometer ~ time
model.Temp<-lm(Temp_degC~PST,data=long.data)
summary(model.Temp)


# Graphing pH of hobo and spec to Temperature
pH_Temp_Loggers<-spec.197$file.ID
PlotpHTemp.long<-ggplot(data=spec.197,aes(y=pHmean,x=Temp_degC,fill=pH_Temp_Loggers))+ # basic plot
  geom_point(aes(colour=pH_Temp_Loggers))+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Temp',y='Mean pH', fill='pH_Temp_Loggers')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(colour=pH_Temp_Loggers,label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"raw_pH-Temp_",date,".png"))
PlotpHTemp.long # spec and raw hobo 197 pH ~ temp
PlotpHTemp.bflong<-ggplot(data=spec.197,aes(y=pHmean,x=Temp_degC))+ # basic plot
  geom_point(aes(colour=pH_Temp_Loggers))+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Temp',y='Mean pH')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"raw_pH-Temp_bestfit_",date,".png"))
PlotpHTemp.bflong # spec and raw hobo 197 pH ~ temp
# comparing pH of SN197 to spec ~ temperature
model.ph.temp<-lm(pHmean~Temp_degC,data=spec.197)
summary(model.ph.temp)


# Graphing pH of hobo and spec to Time
pH_Time_Loggers<-spec.197$file.ID
PlotpHTime.long<-ggplot(data=spec.197,aes(y=pHmean,x=PST,fill=pH_Time_Loggers))+ # basic plot
  geom_point(aes(colour=pH_Time_Loggers))+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Time',y='Mean pH', fill='pH_Time_Loggers')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(colour=pH_Time_Loggers,label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"raw_pH-Time_",date,".png"))
PlotpHTime.long # spec and raw hobo 197 pH ~ time
PlotpHTime.bflong<-ggplot(data=spec.197,aes(y=pHmean,x=PST))+ # basic plot
  geom_point(aes(colour=pH_Time_Loggers))+ # adds data points to plot
  geom_smooth(method="lm")+ # linear regression
  labs(x='Time',y='Mean pH', fill='Logger')+ # axis labels
  theme_bw()+ # removes gridlines
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  stat_regline_equation(mapping = aes(label=paste(..eq.label.., ..rr.label.., sep = "~~~~")), formula = y~x,
                        label.x.npc = "left", label.y.npc = "bottom", label.x = NULL,
                        label.y = NULL, output.type = "expression")+
  ggsave(paste0(output,"raw_pH-Time_bestfit_",date,".png"))
PlotpHTime.bflong # spec and raw hobo 197 pH ~ time
# comparing pH of SN197 to spec ~ time
model.ph.time<-lm(pHmean~PST,data=spec.197)
summary(model.ph.time)


# seacarb pH conversion and plotting SN197
TS.spec<-spec.data %>%
  rename(pH_TS='pHmean')
hobo.convert<-hobo.195.and.197 %>% # dataframe of only spec and hobo 197 data, converting nbs to total scale pH
  group_by(pHmean) %>%
  mutate(pH_TS=pHmean) %>% #pH(Ex=mV.hobo,Etris=mV.hobo,S=34,T=Temp_degC)) %>% # thus far unable to find a useful conversion
  filter(file.ID=='SN197') %>%
  bind_rows(TS.spec)
#View(hobo.convert)

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
  #ggsave(paste0(output,"TotalScalepH_bestfit_",date,".png"))
PlotpH.TS
# comparing pH of spec and hobo 197 ~ time
model.phts<-lm(pH_TS~PST,data=hobo.convert)
summary(model.phts)
