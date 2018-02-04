library(readr)
library(dplyr)
library(tidyr)
setwd("~/Documents/School/Springboard/Data Wrangling/Exercise 2")
titanic <- read.csv("titanic_original.csv", header = TRUE, stringsAsFactors = FALSE)
#for some reason last row is blank so we are removing it.
titanic <- titanic[1:1309,]
#Create a tbl
titanic <- tbl_df(titanic)
#View the data frame
View(titanic)


#Check the values in embarked variable
unique(titanic$embarked)

#1 The embarked column has some missing values, which are known to correspond to passengers 
#who actually embarked at Southampton. Find the missing values and replace them with S. 
#(Caution: Sometimes a missing value might be read into R as a blank or empty string.)

#Selecting a few columns so we know if there is data associated with embarked variable
#once the data has been filtered
titanic %>% 
  select(pclass, survived, name, embarked) %>%
  filter(embarked == "")

sum(titanic$embarked=="")

#Assign S to missing value in embarked 
titanic$embarked[titanic$embarked==""]<- "S"

#changing emabrked into a factor
titanic$embarked <- factor(titanic$embarked) 


#2 Age 
#Calculate the mean of age and use that value to populate the missing values

#find if there are NA values in age variable
is.na(titanic$age)

#find the mean value of age. Ignore NA to calculate mean then rounding to nearest whole number.
x <- mean(titanic$age, na.rm = TRUE)

#Replacing all NA with mean which is 30
titanic$age[is.na(titanic$age)] <- x

#view if NA are replaced
titanic$age

#3 Lifeboat
#many passengers did not make it to a boat :-( This means that there are a lot of missing values in the boat column. 
#Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'
#view different values of boat variable
unique(titanic$boat)

#find all "" in boat
titanic %>%
  select(pclass, survived, sex, boat) %>%
  filter(boat == "")

sum(titanic$boat=="")

#replace all "" with NA
titanic$boat[titanic$boat==""]<- "NA"

#view "" was replaced by NA
titanic %>%
  select(pclass, survived, sex, boat) %>%
  filter(boat == "NA")
  
################################
#4 Cabin
#Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise
unique(titanic$cabin)

titanic$cabin[titanic$cabin==""] <- "NA"
titanic$has_cabin_number  <- ifelse(titanic$cabin == "NA", 0, 1)

#5 Export clean CSV
write.csv(titanic, "titanic_clean.csv")
  
  
  
  
  
  
  
  



