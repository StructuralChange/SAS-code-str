				
options nosource nonotes  ;
  
/* step 1:	data */
ods listing close ;

data data_estimate ;
	set simu1.data ;
	if i<76 ;
	keep i y ;
data data_x ;
	set simu1.data ;
	drop y ;
data data_forecast ;
	merge data_estimate data_x ;
	by i ;
run ;


data data_estimate0 ;
	set simu1.data ;
	if i<76 ;
run ;

  




 
proc ucm data= Data_forecast noprint ;
		/* autoreg ;
		/* deplag lags= &lags ; /* when lags are specified, the lagged obs in the dataset will automatically be omitted, i.e., when obs=1 */
		/* irregular P=1 ; */
		level ;	* include a constant which follows a random walk ;
		slope ;
     model y   ;
				; 
				randomreg x ;

				/*Christmas    f_&skunumber d_&skunumber ;
	 			randomreg logp_148 ;
				randomreg logp_125  ;
				randomreg logp_143 ;*/

;
	forecast   lead= 25 outfor= forecast1  ;


   run;
