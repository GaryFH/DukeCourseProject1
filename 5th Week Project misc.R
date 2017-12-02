

#load("C:/Users/GaryFH/Dropbox/Rstudio/R data files/Duke introduction to statistics with R/DukeCourseProject1/_384b2d9eda4b29131fb681b243a7767d_brfss2013.RData")
library(dplyr)
class(brfss2013)
df1<-tbl_df(brfss2013)
saveRDS(df1,"df1")
df1<-readRDS("df1")