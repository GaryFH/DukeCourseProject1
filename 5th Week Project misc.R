

load("_384b2d9eda4b29131fb681b243a7767d_brfss2013.RData")
library(dplyr)
class(brfss2013)
df1<-tbl_df(brfss2013)
saveRDS(df1,"df1")

aaa<-sapply(df1,class)
aaab<-select(df1,which(aaa=="integer"))
aaabs<-select(df1,which(aaa=="numeric"))


ames %>%
  summarise(mu = mean(area), pop_med = median(area), 
            sigma = sd(area), pop_iqr = IQR(area),
            pop_min = min(area), pop_max = max(area),
            pop_q1 = quantile(area, 0.25),  # first quartile, 25th percentile
            pop_q3 = quantile(area, 0.75))  # third quartile, 75th percentile