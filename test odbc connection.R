#testing r connection to DIDC and test database in same place

library(tidyverse)
library(odbc)
library(dbplyr)
library(DBI)

#Note with DairyNZ architecture, Access is 32bit, so you need to run a 32bit version of R 
#(need recent version of Rstudio, pre-release as of September 2019 to selct 32 bit option)
#also need to have 32 bit odbc data source administrator set up with system DSN and drivers (32 bit versions) 
#(need 32bit "Microsoft Access Database Engine 2010 Redistributable" installed)
#install from here (32 bit version!)
#https://www.microsoft.com/en-nz/download/details.aspx?id=13255

#Because DIDC links to sql database, also need  a User DSN setup (Sam Tighe or replacement)
#can copy entries from Mark's computer under OBDC 32 bit drivers
#On windows, Search for OBDC
#Edit User DSN, and Edit Systems DSN
#PCResale on C: is one easy check
#then this should all work

#test database, using a pretend db that was copied from web - all works
#Local version, assuming on C:
tcon <- dbConnect(odbc::odbc(), "PCResaleRemote") #this is on network drive
tdbTables <- dbListTables(tcon)
data <- dbReadTable(tcon, "CustomerT")
data

#possible error - have you installed redistributable (32bit!)

#Another possible error Message
#Error: nanodbc/nanodbc.cpp:983: IM014: [Microsoft][ODBC Driver Manager] The specified DSN contains an architecture mismatch between the Driver and Application 
#Solution, Change to R 32 bit version - Tools, Global options, R version


#this is assuming on network drive
tcon <- dbConnect(odbc::odbc(), "PCResaleRemote") 
tdbTables <- dbListTables(tcon)
data <- dbReadTable(tcon, "CustomerT")
data


#DIDC
dcon <- dbConnect(odbc::odbc(), "DIDC_Appn") #works
dbTables <- dbListTables(dcon)               #works
data <- dbReadTable(dcon, "MainTables")      #works
data <- dbReadTable(dcon, "CommodityPrices") #now works
data <- as.tbl(dbGetQuery(dcon, "SELECT * from MainTables"))            #works
data <- as.tbl(dbGetQuery(dcon, "SELECT * from AverageCompanyPayouts")) #now works

# These errors will occur if you do not have access to the server SNSVSQL01. In this case email Lee.
# > data <- dbReadTable(dcon, "CommodityPrices") #now works
# Error: nanodbc/nanodbc.cpp:1617: HY000: [Microsoft][ODBC Microsoft Access Driver] ODBC--connection to 'DIDC' failed. 
# <SQL> 'SELECT * FROM `CommodityPrices`'
# > data <- as.tbl(dbGetQuery(dcon, "SELECT * from AverageCompanyPayouts")) #now works
# Error: nanodbc/nanodbc.cpp:1617: HY000: [Microsoft][ODBC Microsoft Access Driver] ODBC--connection to 'DIDC' failed. 
# <SQL> 'SELECT * from AverageCompanyPayouts'

#list available tables
dbTables <- dbListTables(dcon)
dbTablesSubset <- dbTables[1:42]

#Read in all relevant tables
#load all tables https://stackoverflow.com/a/44137180/4927395
dfList <- setNames(lapply(dbTablesSubset, function(t) dbReadTable(dcon, t)), dbTablesSubset)
#saveRDS(dfList, file = "DIDC dfList.rds")
#dfList <- readRDS("DIDC dfList.rds")
list2env(dfList, envir=.GlobalEnv)
#Now you should have a bunch of tables in your environment

