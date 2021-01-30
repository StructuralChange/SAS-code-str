library(forecast)
library(tstools)
library(zoo)
library(PMCMR)
library(NSM3)

rm(list=ls())
setwd("Q:/= IRI data research/Diebold Mariana Test/results data")

 #dm.test(e1,e2,h=12,power=1)     
#dm test input 'e1' and 'e2' could be the original error, the function will automatically take the absolute value


overall_r_adl4_versus_r_ad4_ew <- read.csv("overall_r_adl4_versus_r_ad4_ew.csv")
overall_r_adl4_versus_r_ad4_ic <- read.csv("overall_r_adl4_versus_r_ad4_ic.csv")
overall_r_adl4_versus_r_ewc_ic <- read.csv("overall_r_adl4_versus_r_ewc_ic.csv")
overall_r_own2_versus_r_adl4   <- read.csv("overall_r_own2_versus_r_adl4.csv")
overall_r_own2_versus_r_base   <- read.csv("overall_r_own2_versus_r_base.csv")
overall_r_own2_versus_r_ow2_ew <- read.csv("overall_r_own2_versus_r_ow2_ew.csv")
overall_r_own2_versus_r_ow2_ic <- read.csv("overall_r_own2_versus_r_ow2_ic.csv")

AvgRelMAE <- read.csv("AvgRelMAE.csv")




#remove the obs beyond the horizon
horizon_parm <- 1

overall_r_adl4_versus_r_ad4_ew <- overall_r_adl4_versus_r_ad4_ew[overall_r_adl4_versus_r_ad4_ew$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ad4_ic <- overall_r_adl4_versus_r_ad4_ic[overall_r_adl4_versus_r_ad4_ic$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ewc_ic <- overall_r_adl4_versus_r_ewc_ic[overall_r_adl4_versus_r_ewc_ic$horizon <=horizon_parm,]
overall_r_own2_versus_r_adl4   <- overall_r_own2_versus_r_adl4[overall_r_own2_versus_r_adl4$horizon <=horizon_parm,]
overall_r_own2_versus_r_base   <- overall_r_own2_versus_r_base[overall_r_own2_versus_r_base$horizon <=horizon_parm,]
overall_r_own2_versus_r_ow2_ew <- overall_r_own2_versus_r_ow2_ew[overall_r_own2_versus_r_ow2_ew$horizon <=horizon_parm,]
overall_r_own2_versus_r_ow2_ic <- overall_r_own2_versus_r_ow2_ic[overall_r_own2_versus_r_ow2_ic$horizon <=horizon_parm,]

 

#1. test for MAE 
      e1  <- unlist(c(overall_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(overall_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(overall_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #8 ewc_ic
      
   
mean(e1)
mean(e2)
mean(e3)
mean(e4)
mean(e5)
mean(e6)
mean(e7)
mean(e8)

 

x1 <-cbind(e1, e2,e3,e4,e5,e6,e7,e8)
class(x1)
 
kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
kk
 

dm.test(e1,e2,h=1,power=1)     
dm.test(e2,e3,h=1,power=1)

dm.test(e2,e4,h=1,power=1)
dm.test(e2,e5,h=1,power=1)

dm.test(e3,e6,h=1,power=1)
dm.test(e3,e7,h=1,power=1)
dm.test(e3,e8,h=1,power=1)#### issue



#pWNMT(x1,method="Asymptotic")

#2. test for MASE 
      e1  <- unlist(c(overall_r_own2_versus_r_base["q_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(overall_r_own2_versus_r_base["q_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(overall_r_own2_versus_r_adl4["q_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["q_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["q_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["q_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["q_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["q_1"]), use.names=FALSE) #8 ewc_ic
      
      mean(e1)
      mean(e2)
      mean(e3)
      
      mean(e4)
      mean(e5)
      mean(e6)
      mean(e7)
      mean(e8)
      
      
      
      x1 <-cbind(e1, e2,e3,e4,e5,e6,e7,e8)
class(x1)

kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
kk

dm.test(e1,e2,h=1,power=1)     
dm.test(e2,e3,h=1,power=1)

dm.test(e2,e4,h=1,power=1)
dm.test(e2,e5,h=1,power=1)

dm.test(e3,e6,h=1,power=1)
dm.test(e3,e7,h=1,power=1)
dm.test(e3,e8,h=1,power=1)#### issue


#pWNMT(x1,method="Asymptotic")


#3. test for MAPE 
      f1  <- unlist(c(overall_r_own2_versus_r_base["forecast_sb_adjusted"]), use.names=FALSE)   #1 base
      f2  <- unlist(c(overall_r_own2_versus_r_base["forecast_original"]), use.names=FALSE)      #2 own2
      f3  <- unlist(c(overall_r_own2_versus_r_adl4["forecast_sb_adjusted"]), use.names=FALSE)   #3 adl4
      
      f4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["forecast_sb_adjusted"]), use.names=FALSE) #4 ow2_ew
      f5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["forecast_sb_adjusted"]), use.names=FALSE) #5 ow2_ic
      f6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["forecast_sb_adjusted"]), use.names=FALSE) #6 ad4_ew
      f7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["forecast_sb_adjusted"]), use.names=FALSE) #7 ad4_ic
      
      f8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["forecast_sb_adjusted"]), use.names=FALSE) #8 ewc_ic

      actual<- unlist(c(overall_r_adl4_versus_r_ewc_ic["actual"]), use.names=FALSE) #actual
      
      ape1 <- abs(f1-actual)/actual
      ape2 <- abs(f2-actual)/actual
      ape3 <- abs(f3-actual)/actual
      ape4 <- abs(f4-actual)/actual
      ape5 <- abs(f5-actual)/actual
      ape6 <- abs(f6-actual)/actual
      ape7 <- abs(f7-actual)/actual
      ape8 <- abs(f8-actual)/actual
      
      
      mean(ape1)
      mean(ape2)
      mean(ape3)
      
      mean(ape4)
      mean(ape5)
      mean(ape6)
      mean(ape7)
      mean(ape8)
      
x1 <-cbind(ape1, ape2,ape3,ape4,ape5,ape6,ape7,ape8)
class(x1)

kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
kk

dm.test(e1,e2,h=1,power=1)     
dm.test(e2,e3,h=1,power=1)

dm.test(e2,e4,h=1,power=1)
dm.test(e2,e5,h=1,power=1)

dm.test(e3,e6,h=1,power=1)
dm.test(e3,e7,h=1,power=1)
dm.test(e3,e8,h=1,power=1)#### issue


#pWNMT(x1,method="Asymptotic")


#4. test for symmetricMAPE 

 
      f1  <- unlist(c(overall_r_own2_versus_r_base["forecast_sb_adjusted"]), use.names=FALSE)   #1 base
      f2  <- unlist(c(overall_r_own2_versus_r_base["forecast_original"]), use.names=FALSE)      #2 own2
      f3  <- unlist(c(overall_r_own2_versus_r_adl4["forecast_sb_adjusted"]), use.names=FALSE)   #3 adl4
      
      f4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["forecast_sb_adjusted"]), use.names=FALSE) #4 ow2_ew
      f5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["forecast_sb_adjusted"]), use.names=FALSE) #5 ow2_ic
      f6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["forecast_sb_adjusted"]), use.names=FALSE) #6 ad4_ew
      f7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["forecast_sb_adjusted"]), use.names=FALSE) #7 ad4_ic
      
      f8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["forecast_sb_adjusted"]), use.names=FALSE) #8 ewc_ic
      
      actual<- unlist(c(overall_r_adl4_versus_r_ewc_ic["actual"]), use.names=FALSE) #actual
      
      sape1 <- abs(f1-actual)/(f1+actual)
      sape2 <- abs(f2-actual)/(f2+actual)
      sape3 <- abs(f3-actual)/(f3+actual)
      sape4 <- abs(f4-actual)/(f4+actual)
      sape5 <- abs(f5-actual)/(f5+actual)
      sape6 <- abs(f6-actual)/(f6+actual)
      sape7 <- abs(f7-actual)/(f7+actual)
      sape8 <- abs(f8-actual)/(f8+actual)
            
      mean(sape1)
      mean(sape2)
      mean(sape3)
      
      mean(sape4)
      mean(sape5)
      mean(sape6)
      mean(sape7)
      mean(sape8)


x1 <-cbind(sape1, sape2,sape3,sape4,sape5,sape6,sape7,sape8)
class(x1)

kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
kk
dm.test(e1,e2,h=1,power=1)     
dm.test(e2,e3,h=1,power=1)

dm.test(e2,e4,h=1,power=1)
dm.test(e2,e5,h=1,power=1)

dm.test(e3,e6,h=1,power=1)
dm.test(e3,e7,h=1,power=1)
dm.test(e3,e8,h=1,power=1)#### issue

 


#5. test for MSE 
      
                  
      e1  <- unlist(c(overall_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(overall_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(overall_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #8 ewc_ic
      
      mean(e1)
      mean(e2)
      mean(e3)
      
      mean(e4)
      mean(e5)
      mean(e6)
      mean(e7)
      mean(e8)
      
      x1 <-cbind(e1, e2,e3,e4,e5,e6,e7,e8)
      class(x1)
      
      kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
      kk
      
      
      dm.test(e1,e2,h=1,power=2)     
      dm.test(e2,e3,h=1,power=2)
      
      dm.test(e2,e4,h=1,power=2)
      dm.test(e2,e5,h=1,power=2)
      
      dm.test(e3,e6,h=1,power=2)
      dm.test(e3,e7,h=1,power=2)
      dm.test(e3,e8,h=1,power=2)#### issue
      
 
      
      

#pWNMT(x1,method="Asymptotic")

 

 


#5. test for Mean relative AE


      
      f1  <- unlist(c(overall_r_own2_versus_r_base["forecast_sb_adjusted"]), use.names=FALSE)      #1 base
      f2  <- unlist(c(overall_r_own2_versus_r_base["forecast_original"]), use.names=FALSE)   #2 own2, #forecasts by own2, as the reference
      f3  <- unlist(c(overall_r_own2_versus_r_adl4["forecast_sb_adjusted"]), use.names=FALSE)   #3 adl4
      
      f4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["forecast_sb_adjusted"]), use.names=FALSE) #4 ow2_ew
      f5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["forecast_sb_adjusted"]), use.names=FALSE) #5 ow2_ic
      f6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["forecast_sb_adjusted"]), use.names=FALSE) #6 ad4_ew
      f7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["forecast_sb_adjusted"]), use.names=FALSE) #7 ad4_ic
      
      f8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["forecast_sb_adjusted"]), use.names=FALSE) #8 ewc_ic
      
      rel_1 <- f1/f2
      rel_2 <- f2/f2
      rel_3 <- f3/f2
      rel_4 <- f4/f2
      rel_5 <- f5/f2
      rel_6 <- f6/f2
      rel_7 <- f7/f2
      rel_8 <- f8/f2
      
      
         
      

      x1 <-cbind(rel_1, rel_2,rel_3,rel_4,rel_5,rel_6,rel_7,rel_8)
      class(x1)

kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
kk


dm.test(rel_1,rel_2,h=1,power=1)  
dm.test(rel_2,rel_3,h=1,power=1)

dm.test(rel_2,rel_4,h=1,power=1)
dm.test(rel_2,rel_5,h=1,power=1)

dm.test(rel_3,rel_6,h=1,power=1)
dm.test(rel_3,rel_7,h=1,power=1)
dm.test(rel_3,rel_8,h=1,power=1)#### issue


 


#pWNMT(x1,method="Asymptotic")


#6. test for Mean AvgRelMAE


#overall_r_adl4_versus_r_ad4_ew <- read.csv("overall_r_adl4_versus_r_ad4_ew.csv")
#overall_r_adl4_versus_r_ad4_ic <- read.csv("overall_r_adl4_versus_r_ad4_ic.csv")
#overall_r_adl4_versus_r_ewc_ic <- read.csv("overall_r_adl4_versus_r_ewc_ic.csv")
#overall_r_own2_versus_r_adl4   <- read.csv("overall_r_own2_versus_r_adl4.csv")
#overall_r_own2_versus_r_base   <- read.csv("overall_r_own2_versus_r_base.csv")
#overall_r_own2_versus_r_ow2_ew <- read.csv("overall_r_own2_versus_r_ow2_ew.csv")
#overall_r_own2_versus_r_ow2_ic <- read.csv("overall_r_own2_versus_r_ow2_ic.csv")



 #we evluate other models' performance 'relative' to own2
#1, base relative to own2
      data0 <- overall_r_own2_versus_r_base
      
          mae0 <- aggregate(data0$ae_0, by=list(data0$category, data0$sku), mean)
      
          mae1 <- aggregate(data0$ae_1, by=list(data0$category, data0$sku), mean)
          
    
          mae0s <- mae0[order(mae0$Group.1, mae0$Group.2),]
              colnames(mae0s)[3] <- "mae0"
          
          mae1s <- mae1[order(mae1$Group.1, mae1$Group.2),]
              colnames(mae1s)[3] <- "mae1"
          
          total <- merge( mae0s, mae1s,by=c("Group.1","Group.2"))
          
          mae0  <- unlist(c(total["mae0"]), use.names=FALSE) #7 ad4_ic
          mae1  <- unlist(c(total["mae1"]), use.names=FALSE) #7 ad4_ic
         
          relMAE <- mae1/mae0 # base 'relative' to own2, mae0 is for own2
          AvgRelMAE<- prod(relMAE)^(1/length(relMAE))
          AvgRelMAE
 
#2, own2 relative to own2  , =1    
#3, ADL4 relative to own2      
        
       data0 <- overall_r_own2_versus_r_adl4
       
       mae0 <- aggregate(data0$ae_0, by=list(data0$category, data0$sku), mean)
       
       mae1 <- aggregate(data0$ae_1, by=list(data0$category, data0$sku), mean)
       
       
       mae0s <- mae0[order(mae0$Group.1, mae0$Group.2),]
       colnames(mae0s)[3] <- "mae0"
       
       mae1s <- mae1[order(mae1$Group.1, mae1$Group.2),]
       colnames(mae1s)[3] <- "mae1"
       
       total <- merge( mae0s, mae1s,by=c("Group.1","Group.2"))
       
       mae0  <- unlist(c(total["mae0"]), use.names=FALSE) #7 ad4_ic
       mae1  <- unlist(c(total["mae1"]), use.names=FALSE) #7 ad4_ic
       
       relMAE <- mae1/mae0 # base 'relative' to own2, mae0 is for own2
       
       #AvgRelMAE
       AvgRelMAE<- prod(relMAE)^(1/length(relMAE))
       AvgRelMAE 
#4, ow2_ew relative to own2
       data0 <- overall_r_own2_versus_r_ow2_ew
       
       mae0 <- aggregate(data0$ae_0, by=list(data0$category, data0$sku), mean)
       
       mae1 <- aggregate(data0$ae_1, by=list(data0$category, data0$sku), mean)
       
       
       mae0s <- mae0[order(mae0$Group.1, mae0$Group.2),]
       colnames(mae0s)[3] <- "mae0"
       
       mae1s <- mae1[order(mae1$Group.1, mae1$Group.2),]
       colnames(mae1s)[3] <- "mae1"
       
       total <- merge( mae0s, mae1s,by=c("Group.1","Group.2"))
       
       mae0  <- unlist(c(total["mae0"]), use.names=FALSE) #7 ad4_ic
       mae1  <- unlist(c(total["mae1"]), use.names=FALSE) #7 ad4_ic
       
       relMAE <- mae1/mae0 # base 'relative' to own2, mae0 is for own2
       
       #AvgRelMAE
       AvgRelMAE<- prod(relMAE)^(1/length(relMAE))
       AvgRelMAE 
#5, ow2_ic relative to own2
       data0 <- overall_r_own2_versus_r_ow2_ic
       
       mae0 <- aggregate(data0$ae_0, by=list(data0$category, data0$sku), mean)
       
       mae1 <- aggregate(data0$ae_1, by=list(data0$category, data0$sku), mean)
       
       
       mae0s <- mae0[order(mae0$Group.1, mae0$Group.2),]
       colnames(mae0s)[3] <- "mae0"
       
       mae1s <- mae1[order(mae1$Group.1, mae1$Group.2),]
       colnames(mae1s)[3] <- "mae1"
       
       total <- merge( mae0s, mae1s,by=c("Group.1","Group.2"))
       
       mae0  <- unlist(c(total["mae0"]), use.names=FALSE) #7 ad4_ic
       mae1  <- unlist(c(total["mae1"]), use.names=FALSE) #7 ad4_ic
       
       relMAE <- mae1/mae0 # base 'relative' to own2, mae0 is for own2
       
       #AvgRelMAE
       AvgRelMAE<- prod(relMAE)^(1/length(relMAE))
       AvgRelMAE 
#6, ad4_ew relative to own2
       data0 <- overall_r_own2_versus_r_ow2_ic
       data1 <- overall_r_adl4_versus_r_ad4_ew
       
       mae0 <- aggregate(data0$ae_0, by=list(data0$category, data0$sku), mean)
       
       mae1 <- aggregate(data1$ae_1, by=list(data1$category, data0$sku), mean)
       
       
       mae0s <- mae0[order(mae0$Group.1, mae0$Group.2),]
       colnames(mae0s)[3] <- "mae0"
       
       mae1s <- mae1[order(mae1$Group.1, mae1$Group.2),]
       colnames(mae1s)[3] <- "mae1"
       
       total <- merge( mae0s, mae1s,by=c("Group.1","Group.2"))
       
       mae0  <- unlist(c(total["mae0"]), use.names=FALSE) #7 ad4_ic
       mae1  <- unlist(c(total["mae1"]), use.names=FALSE) #7 ad4_ic
       
       relMAE <- mae1/mae0 # base 'relative' to own2, mae0 is for own2
       
       #AvgRelMAE
       AvgRelMAE<- prod(relMAE)^(1/length(relMAE))
       AvgRelMAE 
#7, ad4_ic relative to own2
       data0 <- overall_r_own2_versus_r_ow2_ic
       data1 <- overall_r_adl4_versus_r_ad4_ic
       
       mae0 <- aggregate(data0$ae_0, by=list(data0$category, data0$sku), mean)
       
       mae1 <- aggregate(data1$ae_1, by=list(data1$category, data0$sku), mean)
       
       
       mae0s <- mae0[order(mae0$Group.1, mae0$Group.2),]
       colnames(mae0s)[3] <- "mae0"
       
       mae1s <- mae1[order(mae1$Group.1, mae1$Group.2),]
       colnames(mae1s)[3] <- "mae1"
       
       total <- merge( mae0s, mae1s,by=c("Group.1","Group.2"))
       
       mae0  <- unlist(c(total["mae0"]), use.names=FALSE) #7 ad4_ic
       mae1  <- unlist(c(total["mae1"]), use.names=FALSE) #7 ad4_ic
       
       relMAE <- mae1/mae0 # base 'relative' to own2, mae0 is for own2
       
       #AvgRelMAE
       AvgRelMAE<- prod(relMAE)^(1/length(relMAE))
       AvgRelMAE      
#8, ewc_ic relative to own2
       data0 <- overall_r_own2_versus_r_ow2_ic
       data1 <- overall_r_adl4_versus_r_ewc_ic
       
       mae0 <- aggregate(data0$ae_0, by=list(data0$category, data0$sku), mean)
       
       mae1 <- aggregate(data1$ae_1, by=list(data1$category, data0$sku), mean)
       
       
       mae0s <- mae0[order(mae0$Group.1, mae0$Group.2),]
       colnames(mae0s)[3] <- "mae0"
       
       mae1s <- mae1[order(mae1$Group.1, mae1$Group.2),]
       colnames(mae1s)[3] <- "mae1"
       
       total <- merge( mae0s, mae1s,by=c("Group.1","Group.2"))
       
       mae0  <- unlist(c(total["mae0"]), use.names=FALSE) #7 ad4_ic
       mae1  <- unlist(c(total["mae1"]), use.names=FALSE) #7 ad4_ic
       
       relMAE <- mae1/mae0 # base 'relative' to own2, mae0 is for own2
       
       #AvgRelMAE
       AvgRelMAE<- prod(relMAE)^(1/length(relMAE))
       AvgRelMAE          
       
       
       
        
       
       
       
       
       
       
       
       
       
       