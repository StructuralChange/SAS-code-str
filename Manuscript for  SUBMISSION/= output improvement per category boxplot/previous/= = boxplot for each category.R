library(forecast)
#library(tstools)
library(zoo)
library(PMCMR)
library(NSM3)
library(dplyr)

rm(list=ls())
setwd("Q:/= IRI data research/Manuscript for  SUBMISSION/= output improvement per category boxplot")



data0 <- read.csv("All_comparison_all_8_mase.csv")
 

 class(data0)

 result <-  subset(data0, category %in% c("factiss", "hhclean", "spagsauc", "toitisu", "toothpa", "yogurt" ))
 

 


#1. test for MAE 
mase_adl4     <- unlist(c(result["adl4"]), use.names=FALSE)    
mase_ad4_ew   <- unlist(c(result["ad4_ew"]), use.names=FALSE)    
mase_ad4_ic   <- unlist(c(result["ad4_ic"]), use.names=FALSE)    
category   <- unlist(c(result["category"]), use.names=FALSE) 
sku   <- unlist(c(result["sku"]), use.names=FALSE) 

pct_improvement_adl_ew <- (mase_adl4-mase_ad4_ew)/mase_adl4
pct_improvement_adl_ic <- (mase_adl4-mase_ad4_ic)/mase_adl4


data1 <- cbind(category, sku,pct_improvement_adl_ew, pct_improvement_adl_ic)
data1_dataframe<- data.frame(data1)

class(data1_dataframe)


 

 





boxplot(data1_dataframe$pct_improvement_adl_ew~data1_dataframe$category)

 