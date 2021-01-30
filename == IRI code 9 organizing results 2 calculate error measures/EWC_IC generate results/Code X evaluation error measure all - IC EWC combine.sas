

  %let results_lib1= r_ad4_ew ;
  %let results_lib2= r_ad4_ic ;

  
%macro combine_promo_nonpromo ;

				data temp01 ;
					set &results_lib1..Cat_&category._sku&skunumber ;
						rename forecast=forecast_1 ;
						rename ae=ae_1 ;
						rename q=q_1 ;
				run ;
				data temp02 ;
					set &results_lib2..Cat_&category._sku&skunumber ;
						rename forecast=forecast_2 ;
						rename ae=ae_2 ;
						rename q=q_2 ;
				run ;

				proc sort data= temp01 ;
					by start horizon ;
				proc sort data= temp02 ;
					by start horizon ;
				run ;

		data r_ewc_ic.cat_&category._sku&skunumber   ;
					merge temp01 temp02 ;
					by start horizon ;
					 if promoall_&skunumber= 1   then forecast= forecast_1 ;
					 if promoall_&skunumber= 1   then ae= ae_1 ;
					 if promoall_&skunumber= 1   then q= q_1 ;
					 
					 if promoall_&skunumber= 0   then forecast= forecast_2 ;
					 if promoall_&skunumber= 0   then ae= ae_2 ;
					 if promoall_&skunumber= 0   then q= q_2 ;
				drop forecast_1 ae_1 q_1
					 forecast_2 ae_2 q_2 ;
 
				run ;


				
%mend ;






/* calculate MAPE */
%macro produce1 ;
	 
	%do cc1 = 1 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ; %combine_promo_nonpromo ;
			 

				/*  check   */
	%end ;
 
 
%mend ;
/* calculate sMAPE */
 
 
