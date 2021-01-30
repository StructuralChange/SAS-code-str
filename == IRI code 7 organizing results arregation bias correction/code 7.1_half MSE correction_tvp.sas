
/* calculate the one-half MSE as the log bias correction ;*/
 data log_bias_correction  ; 
	set stat ;
	one_half_mse= ms/2 ;
	keep start one_half_mse ;
	start= &roll ;
run ;
/* correction method 1: log reverse * exp( one_half_mse) ;*/
data forecast1 ;
	output ;
run ;
data forecast_level ;
	merge forecast log_bias_correction ;
	retain temp ;
	if _n_=1 then temp= one_half_mse ;
		else one_half_mse= temp ;
	 
	  forecast= exp(forecast)*exp(one_half_mse) ;    
	
	drop temp one_half_mse ;
run ;



/*
data forecast1 ;
	set forecast ;                                       
	forecast=exp(forecast)-1 ;
run ;
data forecast_level2 ;
	merge forecast1 log_bias_correction ;
	retain temp ;
	if _n_=1 then temp= one_half_mse ;
		else one_half_mse= temp ;
	forecast= forecast+ one_half_mse ;
	drop temp one_half_mse ;
run ;

*/
