library(forecast)
library(tstools)
library(zoo)
library(PMCMR)
library(NSM3)

rm(list=ls())
setwd("Q:/= IRI data research/Diebold Mariana Test/results data")

if (!require("devtools"))
  install.packages("devtools")
devtools::install_github("trnnick/TStools")




overall_r_adl4_versus_r_ad4_ew <- read.csv("overall_r_adl4_versus_r_ad4_ew.csv")
overall_r_adl4_versus_r_ad4_ic <- read.csv("overall_r_adl4_versus_r_ad4_ic.csv")
overall_r_adl4_versus_r_ewc_ic <- read.csv("overall_r_adl4_versus_r_ewc_ic.csv")
overall_r_own2_versus_r_adl4   <- read.csv("overall_r_own2_versus_r_adl4.csv")
overall_r_own2_versus_r_base   <- read.csv("overall_r_own2_versus_r_base.csv")
overall_r_own2_versus_r_ow2_ew <- read.csv("overall_r_own2_versus_r_ow2_ew.csv")
overall_r_own2_versus_r_ow2_ic <- read.csv("overall_r_own2_versus_r_ow2_ic.csv")

f1  <- unlist(c(overall_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #base
f2  <- unlist(c(overall_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #own2
f3  <- unlist(c(overall_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #adl4

f4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #ow2_ew
f5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #ow2_ic
f6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #ad4_ew
f7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #ad4_ic

f8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #ewc_ic



x1 <-cbind(f1, f2,f3,f4,f5,f6,f7,f8)
class(x1)
 
kk <- posthoc.friedman.nemenyi.test(x1,pladjust.method="none")
pWNMT(x1,method="Asymptotic")

#nemenyi(x1,conf.int=0.95,plottype="vline")




 
 







dmtest1 <- function(data1) {
  actual  <- unlist(c(data1["forecast_original"]), use.names=FALSE)
  f0      <- unlist(c(data1["forecast_original"]), use.names=FALSE)
  f1      <- unlist(c(data1["forecast_sb_adjusted"]), use.names=FALSE)
  q_0     <- unlist(c(data1["q_0"]), use.names=FALSE)
  q_1     <- unlist(c(data1["q_1"]), use.names=FALSE)
  
  
  e0      <- actual-f0
  e1      <- actual-f1
  
  pe0     <- e0/actual
  pe1     <- e1/actual
  
  spe0     <- e0/(actual+f0)
  spe1     <- e1/(actual+f1)
  
  result_mae <- dm.test(e0,e1,h=12,power=1)  
  result_mse <- dm.test(e0,e1,h=12,power=2)
  result_mape <- dm.test(pe0,pe1,h=12,power=1)  
  result_smape <- dm.test(spe0,spe1,h=12,power=1)  
  result_mase <- dm.test(q_0, q_1, h=12,power=1)  
   
  result_all <- list(result_mae,result_mse,result_mape,result_smape, result_mase)
  
   
  return(result_all)
 
} 

 

 

dmtest1(overall_r_adl4_versus_r_ad4_ew)
dmtest1(overall_r_adl4_versus_r_ad4_ic)
dmtest1(overall_r_adl4_versus_r_ewc_ic)
dmtest1(overall_r_own2_versus_r_adl4)
dmtest1(overall_r_own2_versus_r_base)
dmtest1(overall_r_own2_versus_r_ow2_ew)
dmtest1(overall_r_own2_versus_r_ow2_ic)
 

 
