library(forecast)
library(tstools)
library(zoo)
library(PMCMR)
library(NSM3)

rm(list=ls())
setwd("Q:/= IRI data research/Diebold Mariana Test/results data")

 #dm.test(e1,e2,h=horizon_parm2,power=1)     
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
      
      
      
      
      mpe1 <- (f1-actual)/actual
      mpe2 <- (f2-actual)/actual
      mpe3 <- (f3-actual)/actual
      mpe4 <- (f4-actual)/actual
      mpe5 <- (f5-actual)/actual
      mpe6 <- (f6-actual)/actual
      mpe7 <- (f7-actual)/actual
      mpe8 <- (f8-actual)/actual
      
      
      mean(mpe1)
      mean(mpe2)
      mean(mpe3)
      
      mean(mpe4)
      mean(mpe5)
      mean(mpe6)
      mean(mpe7)
      mean(mpe8)
      
       
       
       
       
       
       
       
       
       