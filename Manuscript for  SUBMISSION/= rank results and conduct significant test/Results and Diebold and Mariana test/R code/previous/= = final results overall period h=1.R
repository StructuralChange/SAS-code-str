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

results_vector <- rbind( 
  
  mean(e1),
  mean(e2),
  mean(e3),
  mean(e4),
  mean(e5),
  mean(e6),
  mean(e7),
  mean(e8))

  

 #rank
rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
results_rank_mae <- cbind(results_vector, rank) #combine the model results with the ranks

#dm test
pvalue_12<- unlist(dm.test(e1,e2,h=horizon_parm,power=1)[4],use.names=FALSE)  
pvalue_23<- unlist(dm.test(e2,e3,h=horizon_parm,power=1)[4],use.names=FALSE) 

pvalue_24<- unlist(dm.test(e2,e4,h=horizon_parm,power=1)[4],use.names=FALSE) 
pvalue_25<- unlist(dm.test(e2,e5,h=horizon_parm,power=1)[4],use.names=FALSE) 

pvalue_36<- unlist(dm.test(e3,e6,h=horizon_parm,power=1)[4],use.names=FALSE) 
pvalue_37<- unlist(dm.test(e3,e7,h=horizon_parm,power=1)[4],use.names=FALSE) 
pvalue_38<- unlist(dm.test(e3,e8,h=horizon_parm,power=1)[4],use.names=FALSE) 


pvalue_mae <- rbind(pvalue_12,pvalue_23,pvalue_24,pvalue_25,pvalue_36,pvalue_37,pvalue_38)






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
      
      results_vector <- rbind( 
        
        mean(e1),
        mean(e2),
        mean(e3),
        mean(e4),
        mean(e5),
        mean(e6),
        mean(e7),
        mean(e8))
      
    
      
      
      rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
      results_rank_mase <- cbind(results_vector, rank) #combine the model results with the ranks
      
      

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
      
      results_vector <- rbind( 
        
        mean(ape1),
        mean(ape2),
        mean(ape3),
        mean(ape4),
        mean(ape5),
        mean(ape6),
        mean(ape7),
        mean(ape8))
      
      
      
      
      rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
      results_rank_mape <- cbind(results_vector, rank) #combine the model results with the ranks
      
      
       


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
      
      sape1 <- 2*abs(f1-actual)/(f1+actual)
      sape2 <- 2*abs(f2-actual)/(f2+actual)
      sape3 <- 2*abs(f3-actual)/(f3+actual)
      sape4 <- 2*abs(f4-actual)/(f4+actual)
      sape5 <- 2*abs(f5-actual)/(f5+actual)
      sape6 <- 2*abs(f6-actual)/(f6+actual)
      sape7 <- 2*abs(f7-actual)/(f7+actual)
      sape8 <- 2*abs(f8-actual)/(f8+actual)
            
      results_vector <- rbind( 
        
        mean(sape1),
        mean(sape2),
        mean(sape3),
        mean(sape4),
        mean(sape5),
        mean(sape6),
        mean(sape7),
        mean(sape8))
      
      
      rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
      results_rank_smape <- cbind(results_vector, rank) #combine the model results with the ranks
      
 


#5. test for RMSE 
      
                  
      e1  <- unlist(c(overall_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(overall_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(overall_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #8 ewc_ic
      
      
      se1 <- e1^2 
      se2 <- e2^2 
      se3 <- e3^2 
      se4 <- e4^2 
      se5 <- e5^2 
      se6 <- e6^2 
      se7 <- e7^2 
      se8 <- e8^2 
  
       
      results_vector <- rbind( 
        
        sqrt(mean(se1)),
        sqrt(mean(se2)),
        sqrt(mean(se3)),
        
        sqrt(mean(se4)),
        sqrt(mean(se5)),
        sqrt(mean(se6)),
        sqrt(mean(se7)),
        sqrt(mean(se8)))
      
      
      
      rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
      results_rank_rmse <- cbind(results_vector, rank) #combine the model results with the ranks    
      

#pWNMT(x1,method="Asymptotic")

 
      
      
      #5b. test for MSE 
      
      
      e1  <- unlist(c(overall_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(overall_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(overall_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #8 ewc_ic
      
      
      se1 <- e1^2 
      se2 <- e2^2 
      se3 <- e3^2 
      se4 <- e4^2 
      se5 <- e5^2 
      se6 <- e6^2 
      se7 <- e7^2 
      se8 <- e8^2 
      
      
      results_vector <- rbind( 
        
         mean(se1),
         mean(se2),
         mean(se3),
        
         mean(se4),
         mean(se5),
         mean(se6),
         mean(se7),
         mean(se8))
      
      
      
      
      rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
      results_rank_mse <- cbind(results_vector, rank) #combine the model results with the ranks    
      
      
 
#5c.  scaled MSE
      
       
      actual_sum  <- unlist(c(overall_r_own2_versus_r_base["actual_sum"]), use.names=FALSE)   #1 base
      
      
      
      
      e1  <- unlist(c(overall_r_own2_versus_r_base["ae_1"]), use.names=FALSE)   #1 base
      e2  <- unlist(c(overall_r_own2_versus_r_base["ae_0"]), use.names=FALSE)   #2 own2
      e3  <- unlist(c(overall_r_own2_versus_r_adl4["ae_1"]), use.names=FALSE)   #3 adl4
      
      e4  <- unlist(c(overall_r_own2_versus_r_ow2_ew["ae_1"]), use.names=FALSE) #4 ow2_ew
      e5  <- unlist(c(overall_r_own2_versus_r_ow2_ic["ae_1"]), use.names=FALSE) #5 ow2_ic
      e6  <- unlist(c(overall_r_adl4_versus_r_ad4_ew["ae_1"]), use.names=FALSE) #6 ad4_ew
      e7  <- unlist(c(overall_r_adl4_versus_r_ad4_ic["ae_1"]), use.names=FALSE) #7 ad4_ic
      
      e8  <- unlist(c(overall_r_adl4_versus_r_ewc_ic["ae_1"]), use.names=FALSE) #8 ewc_ic
      
      
      mean_scaled_error_1 <- mean(e1/actual_sum)^2 
      mean_scaled_error_2 <- mean(e2/actual_sum)^2 
      mean_scaled_error_3 <- mean(e3/actual_sum)^2  
      mean_scaled_error_4 <- mean(e4/actual_sum)^2 
      mean_scaled_error_5 <- mean(e5/actual_sum)^2 
      mean_scaled_error_6 <- mean(e6/actual_sum)^2 
      mean_scaled_error_7 <- mean(e7/actual_sum)^2 
      mean_scaled_error_8 <- mean(e8/actual_sum)^2 
      
      
      results_vector <- rbind( 
        
        mean_scaled_error_1,
        mean_scaled_error_2,
        mean_scaled_error_3,
        mean_scaled_error_4,
        mean_scaled_error_5,
        mean_scaled_error_6,
        mean_scaled_error_7,
        mean_scaled_error_8)
         
      
      
      
      
      rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
      results_rank_scaled_mse <- cbind(results_vector, rank) #combine the model results with the ranks    
      
      
      
      
      
 

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
          AvgRelMAE1<- prod(relMAE)^(1/length(relMAE))
           
 
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
       AvgRelMAE2<- prod(relMAE)^(1/length(relMAE))
         
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
       AvgRelMAE3<- prod(relMAE)^(1/length(relMAE))
         
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
       AvgRelMAE4<- prod(relMAE)^(1/length(relMAE))
         
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
       AvgRelMAE5<- prod(relMAE)^(1/length(relMAE))
         
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
       AvgRelMAE6<- prod(relMAE)^(1/length(relMAE))
              
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
       AvgRelMAE7<- prod(relMAE)^(1/length(relMAE))
                  
       
       
       
        #### organize 
       own2 <- 1
       results_vector <- rbind( 
         
         AvgRelMAE1,
         own2,
         AvgRelMAE2,
         AvgRelMAE3,
         AvgRelMAE4,
         AvgRelMAE5,
         AvgRelMAE6,
         AvgRelMAE7)
       
        
       
       
       rank <- match(results_vector, sort(results_vector))#the order of the perforamnce of the models
       results_rank_AvgRelMAE <- cbind(results_vector, rank) #combine the model results with the ranks    
       
       
       
       
       #### all results ;
    
       all_results_ranks <- cbind(results_rank_mae, results_rank_smape, results_rank_mase, results_rank_AvgRelMAE, results_rank_mse)
       
       
       
       