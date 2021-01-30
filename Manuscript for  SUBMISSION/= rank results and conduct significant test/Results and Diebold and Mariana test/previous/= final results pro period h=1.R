library(forecast)
library(tstools)
library(zoo)
library(PMCMR)
library(NSM3)

rm(list=ls())
setwd("Q:/= IRI data research/Diebold Mariana Test/results data")

 #dm.test(e1,e2,h=horizon_parm2,power=1)     
#dm test input 'e1' and 'e2' could be the original error, the function will automatically take the absolute value


pro_r_adl4_versus_r_ad4_ew <- read.csv("pro_r_adl4_versus_r_ad4_ew.csv")
pro_r_adl4_versus_r_ad4_ic <- read.csv("pro_r_adl4_versus_r_ad4_ic.csv")
pro_r_adl4_versus_r_ewc_ic <- read.csv("pro_r_adl4_versus_r_ewc_ic.csv")
pro_r_own2_versus_r_adl4   <- read.csv("pro_r_own2_versus_r_adl4.csv")
pro_r_own2_versus_r_base   <- read.csv("pro_r_own2_versus_r_base.csv")
pro_r_own2_versus_r_ow2_ew <- read.csv("pro_r_own2_versus_r_ow2_ew.csv")
pro_r_own2_versus_r_ow2_ic <- read.csv("pro_r_own2_versus_r_ow2_ic.csv")

#AvgRelMAE <- read.csv("AvgRelMAE.csv")




#remove the obs beyond the horizon
horizon_parm <- 1

pro_r_adl4_versus_r_ad4_ew <- pro_r_adl4_versus_r_ad4_ew[pro_r_adl4_versus_r_ad4_ew$horizon <=horizon_parm,]
pro_r_adl4_versus_r_ad4_ic <- pro_r_adl4_versus_r_ad4_ic[pro_r_adl4_versus_r_ad4_ic$horizon <=horizon_parm,]
pro_r_adl4_versus_r_ewc_ic <- pro_r_adl4_versus_r_ewc_ic[pro_r_adl4_versus_r_ewc_ic$horizon <=horizon_parm,]
pro_r_own2_versus_r_adl4   <- pro_r_own2_versus_r_adl4[pro_r_own2_versus_r_adl4$horizon <=horizon_parm,]
pro_r_own2_versus_r_base   <- pro_r_own2_versus_r_base[pro_r_own2_versus_r_base$horizon <=horizon_parm,]
pro_r_own2_versus_r_ow2_ew <- pro_r_own2_versus_r_ow2_ew[pro_r_own2_versus_r_ow2_ew$horizon <=horizon_parm,]
pro_r_own2_versus_r_ow2_ic <- pro_r_own2_versus_r_ow2_ic[pro_r_own2_versus_r_ow2_ic$horizon <=horizon_parm,]

 

#1. test for MAE 
      e1  <- unlist(c(pro_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(pro_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(pro_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(pro_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(pro_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(pro_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(pro_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(pro_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #8 ewc_ic
      
   
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
 

dm.test(e1,e2,h=horizon_parm,power=1)     
dm.test(e2,e3,h=horizon_parm,power=1)

dm.test(e2,e4,h=horizon_parm,power=1)
dm.test(e2,e5,h=horizon_parm,power=1)

dm.test(e3,e6,h=horizon_parm,power=1)
dm.test(e3,e7,h=horizon_parm,power=1)
dm.test(e3,e8,h=horizon_parm,power=1)#### issue



#pWNMT(x1,method="Asymptotic")

#2. test for MASE 
      e1  <- unlist(c(pro_r_own2_versus_r_base["q_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(pro_r_own2_versus_r_base["q_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(pro_r_own2_versus_r_adl4["q_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(pro_r_own2_versus_r_ow2_ew["q_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(pro_r_own2_versus_r_ow2_ic["q_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(pro_r_adl4_versus_r_ad4_ew["q_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(pro_r_adl4_versus_r_ad4_ic["q_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(pro_r_adl4_versus_r_ewc_ic["q_1"]), use.names=FALSE) #8 ewc_ic
      
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

dm.test(e1,e2,h=horizon_parm,power=1)     
dm.test(e2,e3,h=horizon_parm,power=1)

dm.test(e2,e4,h=horizon_parm,power=1)
dm.test(e2,e5,h=horizon_parm,power=1)

dm.test(e3,e6,h=horizon_parm,power=1)
dm.test(e3,e7,h=horizon_parm,power=1)
dm.test(e3,e8,h=horizon_parm,power=1)#### issue


#pWNMT(x1,method="Asymptotic")


#3. test for MAPE 
      f1  <- unlist(c(pro_r_own2_versus_r_base["forecast_sb_adjusted"]), use.names=FALSE)   #1 base
      f2  <- unlist(c(pro_r_own2_versus_r_base["forecast_original"]), use.names=FALSE)      #2 own2
      f3  <- unlist(c(pro_r_own2_versus_r_adl4["forecast_sb_adjusted"]), use.names=FALSE)   #3 adl4
      
      f4  <- unlist(c(pro_r_own2_versus_r_ow2_ew["forecast_sb_adjusted"]), use.names=FALSE) #4 ow2_ew
      f5  <- unlist(c(pro_r_own2_versus_r_ow2_ic["forecast_sb_adjusted"]), use.names=FALSE) #5 ow2_ic
      f6  <- unlist(c(pro_r_adl4_versus_r_ad4_ew["forecast_sb_adjusted"]), use.names=FALSE) #6 ad4_ew
      f7  <- unlist(c(pro_r_adl4_versus_r_ad4_ic["forecast_sb_adjusted"]), use.names=FALSE) #7 ad4_ic
      
      f8  <- unlist(c(pro_r_adl4_versus_r_ewc_ic["forecast_sb_adjusted"]), use.names=FALSE) #8 ewc_ic

      actual<- unlist(c(pro_r_adl4_versus_r_ewc_ic["actual"]), use.names=FALSE) #actual
      
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

dm.test(ape1,ape2,h=horizon_parm,power=1)     
dm.test(ape2,ape3,h=horizon_parm,power=1)

dm.test(ape2,ape4,h=horizon_parm,power=1)
dm.test(ape2,ape5,h=horizon_parm,power=1)

dm.test(ape3,ape6,h=horizon_parm,power=1)
dm.test(ape3,ape7,h=horizon_parm,power=1)
dm.test(ape3,ape8,h=horizon_parm,power=1)#### issue


#pWNMT(x1,method="Asymptotic")


#4. test for symmetricMAPE 

 
      f1  <- unlist(c(pro_r_own2_versus_r_base["forecast_sb_adjusted"]), use.names=FALSE)   #1 base
      f2  <- unlist(c(pro_r_own2_versus_r_base["forecast_original"]), use.names=FALSE)      #2 own2
      f3  <- unlist(c(pro_r_own2_versus_r_adl4["forecast_sb_adjusted"]), use.names=FALSE)   #3 adl4
      
      f4  <- unlist(c(pro_r_own2_versus_r_ow2_ew["forecast_sb_adjusted"]), use.names=FALSE) #4 ow2_ew
      f5  <- unlist(c(pro_r_own2_versus_r_ow2_ic["forecast_sb_adjusted"]), use.names=FALSE) #5 ow2_ic
      f6  <- unlist(c(pro_r_adl4_versus_r_ad4_ew["forecast_sb_adjusted"]), use.names=FALSE) #6 ad4_ew
      f7  <- unlist(c(pro_r_adl4_versus_r_ad4_ic["forecast_sb_adjusted"]), use.names=FALSE) #7 ad4_ic
      
      f8  <- unlist(c(pro_r_adl4_versus_r_ewc_ic["forecast_sb_adjusted"]), use.names=FALSE) #8 ewc_ic
      
      actual<- unlist(c(pro_r_adl4_versus_r_ewc_ic["actual"]), use.names=FALSE) #actual
      
      sape1 <- 2*abs(f1-actual)/(f1+actual)
      sape2 <- 2*abs(f2-actual)/(f2+actual)
      sape3 <- 2*abs(f3-actual)/(f3+actual)
      sape4 <- 2*abs(f4-actual)/(f4+actual)
      sape5 <- 2*abs(f5-actual)/(f5+actual)
      sape6 <- 2*abs(f6-actual)/(f6+actual)
      sape7 <- 2*abs(f7-actual)/(f7+actual)
      sape8 <- 2*abs(f8-actual)/(f8+actual)
            
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
dm.test(sape1,sape2,h=horizon_parm,power=1)     
dm.test(sape2,sape3,h=horizon_parm,power=1)

dm.test(sape2,sape4,h=horizon_parm,power=1)
dm.test(sape2,sape5,h=horizon_parm,power=1)

dm.test(sape3,sape6,h=horizon_parm,power=1)
dm.test(sape3,sape7,h=horizon_parm,power=1)
dm.test(sape3,sape8,h=horizon_parm,power=1)#### issue

 


#5. test for RMSE 
      
                  
      e1  <- unlist(c(pro_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(pro_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(pro_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(pro_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(pro_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(pro_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(pro_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(pro_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #8 ewc_ic
      
      
      se1 <- e1^2 
      se2 <- e2^2 
      se3 <- e3^2 
      se4 <- e4^2 
      se5 <- e5^2 
      se6 <- e6^2 
      se7 <- e7^2 
      se8 <- e8^2 
      sqrt(mean(se1))
      sqrt(mean(se2))
      sqrt(mean(se3))
      
      sqrt(mean(se4))
      sqrt(mean(se5))
      sqrt(mean(se6))
      sqrt(mean(se7))
      sqrt(mean(se8))
      
      mean(se1)
      mean(se2)
      mean(se3)
      
      mean(se4)
      mean(se5)
      mean(se6)
      mean(se7)
      mean(se8)
      # 
      x1 <-cbind(e1, e2,e3,e4,e5,e6,e7,e8)
      class(x1)
      
      kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
      kk
     
      # the dm test is based on MSE
      dm.test(se1,se2,h=horizon_parm,power=1)     
      dm.test(se2,se3,h=horizon_parm,power=1)
      
      dm.test(se2,se4,h=horizon_parm,power=1)
      dm.test(se2,se5,h=horizon_parm,power=1)
      
      dm.test(se3,se6,h=horizon_parm,power=1)
      dm.test(se3,se7,h=horizon_parm,power=1)
      dm.test(se3,se8,h=horizon_parm,power=1)#### issue
      
 
      
      

#pWNMT(x1,method="Asymptotic")

 

  
 


#pWNMT(x1,method="Asymptotic")


#6. test for Mean AvgRelMAE


#pro_r_adl4_versus_r_ad4_ew <- read.csv("pro_r_adl4_versus_r_ad4_ew.csv")
#pro_r_adl4_versus_r_ad4_ic <- read.csv("pro_r_adl4_versus_r_ad4_ic.csv")
#pro_r_adl4_versus_r_ewc_ic <- read.csv("pro_r_adl4_versus_r_ewc_ic.csv")
#pro_r_own2_versus_r_adl4   <- read.csv("pro_r_own2_versus_r_adl4.csv")
#pro_r_own2_versus_r_base   <- read.csv("pro_r_own2_versus_r_base.csv")
#pro_r_own2_versus_r_ow2_ew <- read.csv("pro_r_own2_versus_r_ow2_ew.csv")
#pro_r_own2_versus_r_ow2_ic <- read.csv("pro_r_own2_versus_r_ow2_ic.csv")



 #we evluate other models' performance 'relative' to own2
#1, base relative to own2
      data0 <- pro_r_own2_versus_r_base
      
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
        
       data0 <- pro_r_own2_versus_r_adl4
       
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
       data0 <- pro_r_own2_versus_r_ow2_ew
       
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
       data0 <- pro_r_own2_versus_r_ow2_ic
       
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
       data0 <- pro_r_own2_versus_r_ow2_ic
       data1 <- pro_r_adl4_versus_r_ad4_ew
       
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
       data0 <- pro_r_own2_versus_r_ow2_ic
       data1 <- pro_r_adl4_versus_r_ad4_ic
       
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
       data0 <- pro_r_own2_versus_r_ow2_ic
       data1 <- pro_r_adl4_versus_r_ewc_ic
       
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
       
       
       
        
       
       
       
       
       
       
       
       
       
       