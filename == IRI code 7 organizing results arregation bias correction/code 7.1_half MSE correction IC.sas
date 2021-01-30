


data log_bias_correction ;
	set model_ic ;
	if _type_="RESIDUAL" ;
	exp_error= exp(logs_&skunumber) ;
run ;
proc means data= log_bias_correction mean noprint ;
	var exp_error  ;
output out= adj mean=adj ;

run ;
 

data forecast_level ;
	merge forecast adj ;
	retain temp ;
	if _n_=1 then temp= adj ;
		else adj= temp ;
	 
	  forecast= exp(forecast)*adj ;    
	start= &roll ;
	drop temp adj  _type_ _freq_;
run ;

data forecast1 ;
	output ;
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
