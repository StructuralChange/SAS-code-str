	   ods graphics on;

 


/* this macro explores the possible number of retained factors */
/* this macro eventually indicate we use 5 factors */
/* this macro construct the factor score file (which will be used in later stage - the regression model */

data factor1 ;
	set expl_cat._reg_smape_8 ;
		keep 
			price_mean
			price_std
			
			sales_mean
			sales_std
			 
			 
			 
			
			d_freq
			f_freq
			outliers_pct
			randomness
			abs_linear_trend ;
run ;
	proc stdize data= factor1		out= std_factor1 ;
		var price_mean
			price_std
			
			sales_mean
			sales_std
			 
			 
			 
			
			d_freq
			f_freq
			outliers_pct
			randomness
			abs_linear_trend ;
	run ;

 
/* based on the variance explained and the scree plot, we retain 5 factors */
 
/***/
proc factor data=std_factor1 simple corr scree
 rotate = varimax reorder
		  NFACTORS= 5 
  
    outstat=  fact_all_1 
		  score 
;
ods output  orthrotfactpat=  rotfactpattern  
				corr=  correlations 	
				Varexplain= Varexplain 
				finalcommun=  finalcommun 
				;
	   run;


	   
	   	proc score  data= std_factor1  
					score=  fact_all_1  
					out=scores  ;
		run ;
