#some commands from:
#https://bookdown.org/yihui/bookdown/

install.packages("bookdown", dependencies = TRUE)

#install.packages('tinytex')
tinytex::install_tinytex()
#check
tinytex:::is_tinytex()

install.packages("flextable")

rmarkdown::pandoc_version()

#For styles in word, set up word tmeplate doc
#For styles in html, use styles.css
#For syles in pdf, all in rmarkdown

# Some fonts need to be added to browser and local computer - see test fonts install
# use google fonts to install, for example, "Open Sans" into Fonts manager on computer
# also, need to import fonts for ggplot, use extrafont::font_import() 
# ghostscript installed, see test fonts install




windowsFonts()

??theme_set
library(tidyverse)
library(extrafont)

my_theme <- theme_minimal() + theme(text = element_text(family = "Arial"))

ggplot(data=iris,aes(x=Sepal.Width, y=Sepal.Length)) + geom_point()+theme(text = element_text(family = "Open Sans"))
