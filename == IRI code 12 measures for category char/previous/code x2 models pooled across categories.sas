options nosource nonotes ;
 

 
 

%macro doit0 (category) ;
data c1 ;
	set expl_cat._reg_mape_all_horizons ;
	if h1=1 ;
	 
proc reg data = c1;
  model   &measure. =  

	 	 		
 	price_std		
 	
 	price_c_v		
 	
 
 	sales_c_v		
 	d_freq		
 	f_freq		
 	outliers_pct		
 	randomness		
   
 	abs_linear_trend
	 
 

/ vif tol collin;
ods  output parameterestimates= estimate1 ;
 
output out= xx ;
run;
quit ;

 

%mend ;
 

%macro lll ;
	%doit0 ; 
	  
%mend ;
%let measure= improvement_ad4_ic ;
%lll ;
%let measure= improvement_ad4_ew ;
%lll ;
%let measure= improvement_ow2_ew	;
%lll ;
%let measure= improvement_ow2_ic;	 
%lll ;

quit ;
