##setup computer for new staff (e.g. Ryan - current at May 2020)

##Make smart default for projects folder in Tools|Global options|General
#eg user/docs/R_projects
#Never save workspace or history (see screenshot of settings)
#"Setup computer for R - RStudio Rstudio settings  R_projects_.png"
#NB We have made a script that copies sensible recommended defaults automagically

username <- Sys.getenv('username')
appdata <- Sys.getenv('appdata')

documents_folder <- paste0('C:\\Users\\',username,'\\Documents\\')
my_appdata_path <- paste0(appdata, '\\Rstudio\\')

urlfile="https://raw.githubusercontent.com/millzyr/Setup-computer-for-R/master/recommended-rstudio-prefs.json"
download.file(urlfile, paste0(my_appdata_path, "rstudio-prefs.json"))


#You may want to set up or connect to shinyapps or rsconnect to publish examples


##Make smart location for libraries
#use Environment variables
#see https://stackoverflow.com/a/19662905/4927395
# note comment:
#Definitely the proper solution. The only catch is if your user is not a admin (likely the case if you're having this problem to begin with), you have to change your environment variables via Control Panel->User Accounts->User Accounts->Change my environment variables.
.libPaths()
# this is ok
"C:/Users/millsr/Documents/R_library"
#with admin rights, i like this (or similar):
"C:/R_library" 
#You may want to delete other libpaths, though may be a pain to do this
# hints at https://stackoverflow.com/questions/15217758/remove-a-library-from-libpaths-permanently-without-rprofile-site
Sys.getenv("R_HOME")

## Set up github
#Follow happy git with R instructions
#https://happygitwithr.com/
# ensure current
# install git
# make github account and "introduce yourself"

## install if needed (do this exactly once):
#install.packages("usethis")

library(usethis)
use_git_config(user.name = "millzyr", user.email = "rrmills93@gmail.com")


##If using bookdown, or rmarkdown, recommended to install bookdown
#see "test starting with rmarkdown.R" (uses https://bookdown.org/yihui/bookdown/)


##If using link to DIDC (Dairy Industry Data Centre), eg for Economic Survey need to install specific drivers 
#see "test obdc connection.R"

##install major packages as required
#install.packages("tidyverse")
#install.packages("sf")

#install Rtools (separately) if ever planning to build packages from source
#You may want to set up or connect to shinyapps or rsconnect to publish examples
#DairyNZ has a shinyapps account