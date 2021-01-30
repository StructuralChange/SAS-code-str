library(forecast)
#library(tstools)
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

 




#remove the obs beyond the horizon
horizon_parm <- 8

overall_r_adl4_versus_r_ad4_ew <- overall_r_adl4_versus_r_ad4_ew[overall_r_adl4_versus_r_ad4_ew$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ad4_ic <- overall_r_adl4_versus_r_ad4_ic[overall_r_adl4_versus_r_ad4_ic$horizon <=horizon_parm,]
overall_r_adl4_versus_r_ewc_ic <- overall_r_adl4_versus_r_ewc_ic[overall_r_adl4_versus_r_ewc_ic$horizon <=horizon_parm,]
overall_r_own2_versus_r_adl4   <- overall_r_own2_versus_r_adl4[overall_r_own2_versus_r_adl4$horizon <=horizon_parm,]
overall_r_own2_versus_r_base   <- overall_r_own2_versus_r_base[overall_r_own2_versus_r_base$horizon <=horizon_parm,]
overall_r_own2_versus_r_ow2_ew <- overall_r_own2_versus_r_ow2_ew[overall_r_own2_versus_r_ow2_ew$horizon <=horizon_parm,]
overall_r_own2_versus_r_ow2_ic <- overall_r_own2_versus_r_ow2_ic[overall_r_own2_versus_r_ow2_ic$horizon <=horizon_parm,]

 

#1. test for MASE 
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


t1<- aggregate(overall_r_own2_versus_r_adl4[,13], list(overall_r_own2_versus_r_adl4$category), mean)
t2<- aggregate(overall_r_adl4_versus_r_ad4_ew[,13], list(overall_r_adl4_versus_r_ad4_ew$category), mean)
t3<- aggregate(overall_r_adl4_versus_r_ad4_ic[,13], list(overall_r_adl4_versus_r_ad4_ic$category), mean)
t4<- aggregate(overall_r_adl4_versus_r_ewc_ic[,13], list(overall_r_adl4_versus_r_ewc_ic$category), mean)

 

 
       
       