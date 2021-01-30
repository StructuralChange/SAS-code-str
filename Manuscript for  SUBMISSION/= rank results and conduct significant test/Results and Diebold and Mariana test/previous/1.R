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

dmtest1 <- function(data1) {
  f0      <- unlist(c(data1["forecast_original"]), use.names=FALSE)
  f1      <- unlist(c(data1["forecast_sb_adjusted"]), use.names=FALSE)
  
  result1 <- dm.test(f0,f1,h=12,power=1)  
   
  
  return(result1)
}

dmtest1(overall_r_adl4_versus_r_ad4_ew)


 
f0_adl4_vs_ad4_ew     <- unlist(c(overall_r_adl4_versus_r_ad4_ew["forecast_original"]), use.names=FALSE)
f1_adl4_vs_ad4_ew     <- unlist(c(overall_r_adl4_versus_r_ad4_ew["forecast_sb_adjusted"]), use.names=FALSE)

result1 <- dm.test(f0_adl4_vs_ad4_ew,f1_adl4_vs_ad4_ew,h=12,power=1)  
result1
result2 <- dm.test(f0_adl4_vs_ad4_ew,f1_adl4_vs_ad4_ew,h=12,power=2)  
result2
 
f0_adl4_vs_ad4_ic     <- unlist(c(overall_r_adl4_versus_r_ad4_ic["forecast_original"]), use.names=FALSE)
f1_adl4_vs_ad4_ic     <- unlist(c(overall_r_adl4_versus_r_ad4_ic["forecast_sb_adjusted"]), use.names=FALSE)

result3 <- dm.test(f0_adl4_vs_ad4_ic,f1_adl4_vs_ad4_ic,h=12,power=1)  
result3
result4 <- dm.test(f0_adl4_vs_ad4_ic,f1_adl4_vs_ad4_ic,h=12,power=2)  
result4

f0_adl4_vs_ewc_ic     <- unlist(c(overall_r_adl4_versus_r_ewc_ic["forecast_original"]), use.names=FALSE)
f1_adl4_vs_ewc_ic     <- unlist(c(overall_r_adl4_versus_r_ewc_ic["forecast_sb_adjusted"]), use.names=FALSE)

result5 <- dm.test(f0_adl4_vs_ewc_ic,f1_adl4_vs_ewc_ic,h=12,power=1)  
result5
result6 <- dm.test(f0_adl4_vs_ewc_ic,f1_adl4_vs_ewc_ic,h=12,power=2)  
result6

f0_own2_vs_adl4       <- unlist(c(overall_r_own2_versus_r_adl4["forecast_original"]), use.names=FALSE)
f1_own2_vs_adl4       <- unlist(c(overall_r_own2_versus_r_adl4["forecast_sb_adjusted"]), use.names=FALSE)


result7 <- dm.test(f0_own2_vs_adl4,f1_own2_vs_adl4,h=12,power=1)  
result7
result8 <- dm.test(f0_own2_vs_adl4,f1_own2_vs_adl4,h=12,power=2)  
result8

f0_own2_vs_base       <- unlist(c(overall_r_own2_versus_r_base["forecast_original"]), use.names=FALSE)
f1_own2_vs_base       <- unlist(c(overall_r_own2_versus_r_base["forecast_sb_adjusted"]), use.names=FALSE)

result9 <- dm.test(f0_own2_vs_base,f1_own2_vs_base,h=12,power=1)  
result9
result10 <- dm.test(f0_own2_vs_base,f1_own2_vs_base,h=12,power=2)  
result10

f0_own2_vs_ow2_ew     <- unlist(c(overall_r_own2_versus_r_ow2_ew["forecast_original"]), use.names=FALSE)
f1_own2_vs_ow2_ew     <- unlist(c(overall_r_own2_versus_r_ow2_ew["forecast_sb_adjusted"]), use.names=FALSE)

result11 <- dm.test(f0_own2_vs_ow2_ew,f1_own2_vs_ow2_ew,h=12,power=1)  
result11
result12 <- dm.test(f0_own2_vs_ow2_ew,f1_own2_vs_ow2_ew,h=12,power=2)  
result12

f0_own2_vs_ow2_ic     <- unlist(c(overall_r_own2_versus_r_ow2_ic["forecast_original"]), use.names=FALSE)
f1_own2_vs_ow2_ic     <- unlist(c(overall_r_own2_versus_r_ow2_ic["forecast_sb_adjusted"]), use.names=FALSE)

result13 <- dm.test(f0_own2_vs_ow2_ic,f1_own2_vs_ow2_ic,h=12,power=1)  
result13
result14 <- dm.test(f0_own2_vs_ow2_ic,f1_own2_vs_ow2_ic,h=12,power=2)  
result14


 
