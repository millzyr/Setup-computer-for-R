#fonts!
#https://www.r-bloggers.com/map-of-the-windows-fonts-registered-with-r/

#install.packages('extrafont')
library(extrafont)

font_import()
# This tries to autodetect the directory containing the TrueType fonts.
# If it fails on your system, please let me know.

###NOTE###
# if you install fonts onto your computer (eg roboto) by copying to fonts, it will be default put them someweher else, as a user account
# You need to copy your font file to c:\windows\fonts while using admin privledges. I did this while using an elevated command prompt, and a "Copy fontfile.ttf C:\Windows\Fonts"
# https://answers.microsoft.com/en-us/windows/forum/windows_10-files/installed-fonts-not-showing-up-in-windows-fonts/5fa9c4a1-e86c-4bd6-af33-13e249b3ec43?page=3
# You can use google fonts to install, for example, "Open Sans" into Fonts manager on computer
# see fonts folder in this project

# Vector of font family names
fonts()

# Show entire table
fonttable()

# Register fonts for Windows bitmap output
loadfonts(device="win")

#also, you'll need to install ghostcript, to render into pdf
#https://blog.revolutionanalytics.com/2012/09/how-to-use-your-favorite-fonts-in-r-charts.html
#Embedding fonts
#Extrafont uses GhostScript, a free PostScript interpreter, to embed the fonts. You'll need to make sure it's installed on your computer (note that GhostScript is not an R package). If you're using Windows, you'll also need to tell R where the Ghostscript executable is:
#downlaod from here:
#https://www.ghostscript.com/download/gsdnld.html

#edit for your version!
#Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.05/bin/gswin32c.exe")
Sys.setenv(R_GSCMD = "C:/Program Files (x86)/gs/gs9.52/bin/gswin32.exe")

library(tidyverse)
library(ggthemes)

fontTable = fonttable()

fontTable$Face = with(fontTable, ifelse(Bold & Italic, "bold.italic", 
                                        ifelse(Bold, "bold",
                                               ifelse(Italic, "italic", "plain"))))
fontTable$Face = factor(fontTable$Face, levels = c("plain","bold","italic","bold.italic"), ordered = TRUE)
fontTable$FamilyName = factor(fontTable$FamilyName, levels = rev(sort(unique(fontTable$FamilyName))), ordered = TRUE)

p = ggplot(fontTable) +
  geom_text(aes(x=Face, y=FamilyName, label=FullName, family=FamilyName, fontface=Face)) +
  labs(title="Windows Fonts in R", x=NULL, y=NULL) +
  theme_minimal() +
  theme(axis.ticks = element_blank(),
        axis.text=element_text(size=12, colour="gray40", family='Arial'),
        axis.text.x=element_text(face=c("plain","bold","italic","bold.italic")),
        plot.title=element_text(size=16, family='Arial'))

p
ggsave("font_ggplot_map.pdf", width = 10, height = 33, device = cairo_pdf)
warnings()
ggsave("font_ggplot_map.png", width = 10, height = 33)
warnings()
capabilities()
