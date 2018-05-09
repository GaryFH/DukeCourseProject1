mean=5 #(mean)
sd=2
n=20
samplemean=6

z=(samplemean-mean)/(sd/sqrt(n))
z

#two sided test to get p value
2*pnorm(-abs(z))


##Therefore the probability that the samplemean is at least 6
1-pnorm(z)


#given 90% all plants are flowering what is chance of at least 95% of a sample size of 200
#are flowering  (assume random sample) note 200*90>10 and 200*10 is >10
#given

#per CLT - SE=sqrt(p*(1-p)/n) or SE=sqrt((p1*(1-p1)/n)+(p2*(1-p2)/n))
SE=sqrt((.9*.1)/200)
##Z=(Desired conf p - observed p)/SE
Z=(.95-.9)/SE
probability<-1-pnorm(Z)
probability
SE
Z




#paul the octupus

paul=factor(c(rep("yes",8),rep("no",0)),levels = c("yes","no"))
inference(paul,est="proportion",type="ht",method = "simulation",success="yes",null = .5,alternative = "greater")

#Use binomial distribution to solve above flower example
#200 times 95% = 190

probability2<-sum(dbinom(190:200,200,.9))
probability2
#571 our of 670 have good intuition

#95% confidence= p+-z*SE = .85+-1.96(sqrt(.85*.15/670)))
CI<-1.96*(sqrt(.85*.15/670))
SE<-sqrt(.85*.15/670)
pLow=.85-SE
pHigh=.85+SE
pLow
pHigh

#above had a confidence interval 2.7% (based on calculated SE=.027)
#What if we wanted the confidence interval to equal 1% (SE=.01)

#.01=1.96*(sqrt(.85*.15/n))
n<-1/((.01/1.96)^2/(.85*.15))
n



#paul the octupus

#Ho:p=.5
#HA:p>.5
source('http://bit.ly/dasi_inference')
paul<-factor(c(rep("yes",8),rep("no",0)),levels = c("yes","no"))
inference(paul, est= "proportion",type="ht", method = "simulation", nsim = 10000, success="yes", null = .5, alternative = "greater")

#11/12 people correctly choose a picture of the back of their hand out of 10 pictures

#choose 10 sided fair die - H0:p=.1, HA:p>.1  -  n=12 - 
hand=factor(c(rep("yes",11),rep("no",1)),levels = c("yes","no"))
inference(hand, est= "proportion",type="ht", method = "simulation", nsim = 100, success="yes", null = .1, alternative = "greater")



#11/12 recognized the back of their hands but only 7/12 recognized the palm of their hands 
#Question - are people better at recognizing the back than the front
#H0:Pback-Ppalm=0     HA:Pback-Ppalm>0
#Pooled group n=24 and correct=18 - make 24 cards with 18 "correct" and 6 "wrong"

#shuffle cards and randomly put in two piles of 12 - label one deck "back" and the other deck "palm"
#determine difference of correct between both decks and simulate (repeat) many times thus building 
#a randomization distribution of differences in proportions.
  #I don't know how to do this yet - it doesn't work well with what I have already done above in "inference"
#Bhand<-sample(c("yes","no"),1,replace = T,prob = c(11,1))
#Phand<-sample(c("yes","no"),1,replace = T,prob = c(7,5))
#diff=factor(c(rep("yes",18),rep("no",6)),levels = c("yes","no"))
#inference(diff, est= "proportion",type="ht", method = "simulation", nsim = 10000, success="yes", null = .1, alternative = "greater")



#https://rpubs.com/rodsveiga/252504



