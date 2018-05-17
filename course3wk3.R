suppressWarnings(library(dplyr))
suppressWarnings(library(DAAG))
suppressWarnings(library(readr))
suppressWarnings(library(ggplot2))
options(digits = 5)
scipen=999

#set number of decimals for selected outputs with:
gh <- function(x, d=2) sprintf(paste0("%1.",d,"f"), x) 
#for outputs with 2 decimals use: gh(objectName)
#for outputs with a different number of decimals 
    #use: gh("the object name"," the number OF decimals wanted)
#data(allbacks)
d1<-tbl_df(allbacks)

gfh<-lm(weight~volume + cover,d1)
summary(gfh)

#lm formula for predicting weight from gfh lm data
#weight=197.96 + (.72*volume) - (184 if cover is pb)
estweight<-gfh$coefficients[1] + (gfh$coefficients[2]*allbacks$volume[1]) + 
  (ifelse(allbacks$cover[1]=="pb",gfh$coefficients[3],0))
estweight
unname(estweight)

#make formula for list of estimated weights from gfh lm formula

listestwght<-c()
for (i in 1:nrow(d1)) {
  estweght<-gfh$coefficients[1] + (gfh$coefficients[2]*allbacks$volume[i]) + 
    (ifelse(allbacks$cover[i]=="pb",gfh$coefficients[3],0)) 
    estweght<-unname(gh(estweght,3)) #removes dimname and sets digits to 3
    listestwght<-c(listestwght,estweght)
} 
print(listestwght)


#Work with states data

states<-tbl_df(read_csv("states.csv"))#stringsAsFactors=FALSE
states$state<-as.factor(states$state)
states

gfh2<-lm(poverty~hs_grad ,states)
summary(gfh2)

gfh2<-lm(poverty~female_house ,states)
summary(gfh2)

#plot states
ggplot(states,aes(x=female_house,y=poverty))+ geom_point() +
          geom_smooth(method = lm, se = T) + 
  labs(x= paste("Female lead house - correlation number is: ",round(cor(x=states$female_house,y=states$poverty),3),
                " and Rsquared is: ",round(cor(x=states$female_house,y=states$poverty)^2,3)))

#plot residuals for gfh2
ggplot(data = gfh2, aes(x = gfh2$fitted.values, y = gfh2$residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab("Fitted values") +
  ylab("Residuals")

#ANOVA stuff
summary(aov(poverty~female_house,states))  #rsquared = female_house Sum Sq/total Sum Sq
gfhh<-anova(lm(poverty~female_house,states))

#note that rsqr can be calculated from anova data by ratios of "Sum Sq"
rsqr<-gfhh$`Sum Sq`[1]/(gfhh$`Sum Sq`[1]+gfhh$`Sum Sq`[2])
rsqr
gfhh

#add white variable to correlation analysis
gfh3<-lm(poverty~female_house + white,states)
summary(gfh3)

ggplot(data = gfh3, aes(data$fitted.values, y = data$residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab("Fitted values") +
  ylab("Residuals")

anova(lm(poverty~female_house + white,states)) #rsquared = female_house Sum Sq/total Sum Sq
total = 132.6+8.2+339.5 #Sum Sq total
rsqrWhite<-8.2/total
rsqrFemale<-132.6/total
rsqrTotal<-(132.6+8.2)/total
print(paste ("Rsqr White = ",round(rsqrWhite,3)))
print(paste ("Rsqr Female = ",round(rsqrFemale,3)))
print(paste ("Rsqr Total = ",round(rsqrTotal,3)))

#Rsqr goes up for every additional variable used - but adjust Rsqr applies penalty
#Adjusted Rsqr is Rsqr less penalty for having multiple predictor variables
#the more variables the bigger the penalty and the more samples/observations
#the smaller the penalty - also the better the new var's cor the less the penalty.  
#In the above example,  the extra couple of percentages that
#Rsqr went up by adding the "white" variable was less than the penalty - therefore
#adding "white" did not help (models with higher adj Rsqr ususally win)


#Two predictor variables are COLLINEAR when they are correlated with each other.
#Predictors should be independent (therefore no collinear) collinear can hurt the model.

#Since adding dependent/associated predictors adds little/nothing to the effectiveness
#of a model it violates the principle of parsimony (it is not thrifty) 
#Simplest model is best and said to be parsimonious.



#INFERENCE STUFF

#Load Data
cognitive<-tbl_df(read_csv("http://bit.ly/dasi_cognitive"))
d1<-cognitive
d1
gfh<-lm(kid_score~mom_iq,d1)
summary(gfh)

anova(gfh) 

ggplot(data = gfh, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab("Fitted values") +
  ylab("Residuals")

#plot gfh
ggplot(d1,aes(x=mom_iq,y=kid_score))+ geom_point() +
  geom_smooth(method = lm, se = T) + 
  labs(x= paste("Mom's iq correlation number or R number is: ",round(cor(x=d1$mom_iq,y=d1$kid_score),3),
                " and Rsquared is: ",round(cor(x=d1$mom_iq,y=d1$kid_score)^2,3)))

#FULL MODEL
gfhFull<-lm(kid_score~mom_iq + mom_hs + mom_work + mom_age,d1)
summary(gfhFull)

anova(gfhFull)

ggplot(data = gfhFull, aes(data$fitted.values, y = data$residuals)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab("Fitted values") +
  ylab("Residuals")

#t.test if predictor variable has two levels
t.test(d1$kid_score~d1$mom_hs)

#t.test if predictor variable has more than two levels
t.test(d1$kid_score,d1$mom_iq)

# To find best model with pValues just throw away variable with high pValues 1 at a time
# Best model by AdjRsqr start with all variables and throw one away and see if AdjRsqr gets higher 
#- if it removing a var doesn't improve adjust rsqr then return var to model 
#and try another variable.   When removing a var increases adj rsqr don't return 
#that var to the model - Keep trying the same process with this "better" model to it's logical conclusion.


#The Best model by AdjRsqr for above df is gfhBest<-lm(kid_score~mom_iq + mom_hs + mom_work ,d1)
gfhBest<-lm(kid_score~mom_iq + mom_hs + mom_work ,d1)

summary(gfhBest)

anova(gfhBest)

#     CONDITIONS FOR GOOD MODEL
#CHECK CONDITION 1 : LINEAR WITH RESPONSE VARIABLE 
#Residual plot
data<-gfhBest
namey<-names(d1[1])
namex<-("mom_iq,  mom_hs,  mom_work")
ggplot(data = data, aes(y = data$residuals, x = data$fitted.values)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab(paste("Residuals for Predictor Variables: ",namex)) +
  ylab(paste("Fitted values for Responce Variable ",namey))
#plot shows randomly scattered around zero - thus condition1 is met


#CONDITION 2 : NEARLY NORMAL RESIDUALS WITH MEAN OF ZERO
#above scatterplot shows this - can also check condition2 with histogram
hist(gfhBest$residuals)

#make normal probability plot
qqnorm(gfhBest$residuals)
qqline(gfh$residuals)
#note all plots have nearly normal distribution - thus condition2 is met


#CONDITION 3 : CONSTANT VARIABILITY OF RESIDUALS 
#same plot as above showing actual residuals vrs fitted residuals
data<-gfhBest
namey<-names(d1[1])
namex<-("mom_iq,  mom_hs,  mom_work")
ggplot(data = data, aes(y = data$residuals, x = data$fitted.values)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab(paste("Residuals for Predictor Variables: ",namex)) +
  ylab(paste("Fitted values for Responce Variable ",namey))

#modify plot to show absolute value of residuals
data<-gfhBest
namey<-names(d1[1])
namex<-("mom_iq,  mom_hs,  mom_work")
ggplot(data = data, aes(y = abs(data$residuals), x = data$fitted.values)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab(paste("Residuals for Predictor Variables: ",namex)) +
  ylab(paste("Fitted values for Responce Variable ",namey))

#since no fan shape in plot1 and no triangle shape in plot2 (which is plot1 folded)
#we see condition3 is met


#CONDITION 4 : INDEPENDENT RESIDUALS
#check to see if a time series issue exist
plot(gfhBest$residuals)#not showing x value is OK in plot - it uses index for x
#looks consitant over entire length of x access








  
