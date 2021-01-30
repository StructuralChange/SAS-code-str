library(forecast)
#library(tstools)
library(zoo)
library(PMCMR)
library(NSM3)

rm(list=ls())
setwd("Q:/= IRI data research/Manuscript for  SUBMISSION/= rank results and conduct significant test/Results and Diebold and Mariana test/results data")

 #dm.test(e1,e2,h=horizon_parm2,power=1)     
#dm test input 'e1' and 'e2' could be the original error, the function will automatically take the absolute value


overall_r_adl4_versus_r_ad4_ew <- read.csv("overall_r_adl4_versus_r_ad4_ew.csv")
overall_r_adl4_versus_r_ad4_ic <- read.csv("overall_r_adl4_versus_r_ad4_ic.csv")
overall_r_adl4_versus_r_ewc_ic <- read.csv("overall_r_adl4_versus_r_ewc_ic.csv")
overall_r_own2_versus_r_adl4   <- read.csv("overall_r_own2_versus_r_adl4.csv")
overall_r_own2_versus_r_base   <- read.csv("overall_r_own2_versus_r_base.csv")
overall_r_own2_versus_r_ow2_ew <- read.csv("overall_r_own2_versus_r_ow2_ew.csv")
overall_r_own2_versus_r_ow2_ic <- read.csv("overall_r_own2_versus_r_ow2_ic.csv")

 




#remove the obs beyond the horizon
horizon_parm <- 8

overall_r_adl4_versus_r_ad4_ew <- overall_r_adl4_versus_r_ad4_ew[overall_r_adl4_versus_r_ad4_ew$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ad4_ic <- overall_r_adl4_versus_r_ad4_ic[overall_r_adl4_versus_r_ad4_ic$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ewc_ic <- overall_r_adl4_versus_r_ewc_ic[overall_r_adl4_versus_r_ewc_ic$horizon <=horizon_parm,]
overall_r_own2_versus_r_adl4   <- overall_r_own2_versus_r_adl4[overall_r_own2_versus_r_adl4$horizon <=horizon_parm,]
overall_r_own2_versus_r_base   <- overall_r_own2_versus_r_base[overall_r_own2_versus_r_base$horizon <=horizon_parm,]
overall_r_own2_versus_r_ow2_ew <- overall_r_own2_versus_r_ow2_ew[overall_r_own2_versus_r_ow2_ew$horizon <=horizon_parm,]
overall_r_own2_versus_r_ow2_ic <- overall_r_own2_versus_r_ow2_ic[overall_r_own2_versus_r_ow2_ic$horizon <=horizon_parm,]

  


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
      
      pe1 <- (f1-actual)/actual
      pe2 <- (f2-actual)/actual
      pe3 <- (f3-actual)/actual
      pe4 <- (f4-actual)/actual
      pe5 <- (f5-actual)/actual
      pe6 <- (f6-actual)/actual
      pe7 <- (f7-actual)/actual
      pe8 <- (f8-actual)/actual
      
      
      mean(pe1)
      mean(pe2)
      mean(pe3)
      
      mean(pe4)
      mean(pe5)
      mean(pe6)
      mean(pe7)
      mean(pe8)
      
      results_vector <- rbind( 
        
        mean(pe1),
        mean(pe2),
        mean(pe3),
        mean(pe4),
        mean(pe5),
        mean(pe6),
        mean(pe7),
        mean(pe8))
      
      
      
      
      rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
      results_rank_mape <- cbind(results_vector, rank) #combine the model results with the ranks
      
      
      
      
      pvalue_12<- unlist(dm.test(ape1,ape2,h=horizon_parm,power=1)[4],use.names=FALSE)  
      pvalue_23<- unlist(dm.test(ape2,ape3,h=horizon_parm,power=1)[4],use.names=FALSE) 
      
      pvalue_24<- unlist(dm.test(ape2,ape4,h=horizon_parm,power=1)[4],use.names=FALSE) 
      pvalue_25<- unlist(dm.test(ape2,ape5,h=horizon_parm,power=1)[4],use.names=FALSE) 
      
      pvalue_36<- unlist(dm.test(ape3,ape6,h=horizon_parm,power=1)[4],use.names=FALSE) 
      pvalue_37<- unlist(dm.test(ape3,ape7,h=horizon_parm,power=1)[4],use.names=FALSE) 
      pvalue_38<- unlist(dm.test(ape3,ape8,h=horizon_parm,power=1)[4],use.names=FALSE) 
      
      
      pvalue_mape <- rbind(pvalue_12,pvalue_23,pvalue_24,pvalue_25,pvalue_36,pvalue_37,pvalue_38)
      
      
       
 
       
       