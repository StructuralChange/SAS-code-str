library(forecast)
rm(list=ls())
setwd("Q:/= IRI data research/Diebold Mariana Test/results data")






overall_r_adl4_versus_r_ad4_ew <- read.csv("overall_r_adl4_versus_r_ad4_ew.csv")
overall_r_adl4_versus_r_ad4_ic <- read.csv("overall_r_adl4_versus_r_ad4_ic.csv")
overall_r_adl4_versus_r_ewc_ic <- read.csv("overall_r_adl4_versus_r_ewc_ic.csv")
overall_r_own2_versus_r_adl4   <- read.csv("overall_r_own2_versus_r_adl4.csv")
overall_r_own2_versus_r_base   <- read.csv("overall_r_own2_versus_r_base.csv")
overall_r_own2_versus_r_ow2_ew <- read.csv("overall_r_own2_versus_r_ow2_ew.csv")
overall_r_own2_versus_r_ow2_ic <- read.csv("overall_r_own2_versus_r_ow2_ic.csv")



extract_category <- function(data1,category1,temp) {
  temp<- data1[data1$category ==category1,]
  
  
  return(temp)
}

data_coldcer<- extract_category(overall_r_adl4_versus_r_ad4_ew,"coldcer",data_coldcer)

 






dmtest1 <- function(data1,result1) {
  f0      <- unlist(c(data1["forecast_original"]), use.names=FALSE)
  f1      <- unlist(c(data1["forecast_sb_adjusted"]), use.names=FALSE)
  
  result1 <- dm.test(f0,f1,h=12,power=1)  
   
  
  return(result1)
}
dmtest2 <- function(data1,result1) {
  f0      <- unlist(c(data1["forecast_original"]), use.names=FALSE)
  f1      <- unlist(c(data1["forecast_sb_adjusted"]), use.names=FALSE)
  
  result1 <- dm.test(f0,f1,h=12,power=2)  
  
  
  return(result1)
}


dmtest1(overall_r_adl4_versus_r_ad4_ew,result1)
dmtest2(overall_r_adl4_versus_r_ad4_ew,result2)

dmtest1(overall_r_adl4_versus_r_ad4_ic,result1)
dmtest2(overall_r_adl4_versus_r_ad4_ic,result2)

dmtest1(overall_r_adl4_versus_r_ewc_ic,result1)
dmtest2(overall_r_adl4_versus_r_ewc_ic,result2)



dmtest1(overall_r_own2_versus_r_adl4,result1)
dmtest2(overall_r_own2_versus_r_adl4,result2)

dmtest1(overall_r_own2_versus_r_base,result1)
dmtest2(overall_r_own2_versus_r_base,result2)

dmtest1(overall_r_own2_versus_r_ow2_ew,result1)
dmtest2(overall_r_own2_versus_r_ow2_ew,result2)

dmtest1(overall_r_own2_versus_r_ow2_ic,result1)
dmtest2(overall_r_own2_versus_r_ow2_ic,result2)
  

 
