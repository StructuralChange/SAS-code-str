options nosource nonotes ;
 




%macro doit0 (category) ;
data c1 ;
	set expl_cat.all_&error._all_horizons ;
	if category= "&category" ;
proc reg data = c1;
  model   improvement&measure. =  

		 	 
 	price_std		 
   	 
 		 
	promoall	 
 	outliers_pct		 
 	randomness		 
 	abs_linear_trend
 horizon1
 horizon4
 

/ vif tol collin;
ods  output parameterestimates= estimate1 ;
by category ;
output out= xx ;
run;
quit ;


data estimate2a (rename = (estimate= estimate_&category)) ;
	set estimate1 ;
	label estimate="estimate_&category" ;
	keep Variable estimate   ;
data estimate2b (rename = (stderr= stderr_&category)) ;
	set estimate1 ;
	label stderr="stderr_&category" ;
	keep Variable   stderr ;
data estimate2c (rename = (VarianceInflation= VIF_&category)) ;
	set estimate1 ;
	label stderr="stderr_&category" ;
	keep Variable   VarianceInflation   ;
run ;


data &error._&measure._est2a_all ;
	set estimate2a ;
data &error._&measure._est2b_all ;
	set estimate2b ;
data &error._&measure._est2c_all ;
	set estimate2c ;
run ;

%mend ;

%macro doit1 (category) ;
data c1 ;
	set expl_cat.all_&error._all_horizons ;
	if category= "&category" ;
proc reg data = c1;
  model   improvement&measure. =  

 	 
 	price_std		 
   	 
 		 
	promoall	 
 	outliers_pct		 
 	randomness		 
 	abs_linear_trend
 horizon1
 horizon4
 

/ vif tol collin;
ods  output parameterestimates= estimate1 ;
by category ;
output out= xx ;
run;
quit ;


data estimate2a (rename = (estimate= estimate_&category)) ;
	set estimate1 ;
	label estimate="estimate_&category" ;
	keep Variable estimate   ;
data estimate2b (rename = (stderr= stderr_&category)) ;
	set estimate1 ;
	label stderr="stderr_&category" ;
	keep Variable   stderr ;
data estimate2c (rename = (VarianceInflation= VIF_&category)) ;
	set estimate1 ;
	label stderr="stderr_&category" ;
	keep Variable   VarianceInflation   ;
run ;


data &error._&measure._est2a_all ;
	merge &error._&measure._est2a_all estimate2a ;
data &error._&measure._est2b_all ;
	merge &error._&measure._est2b_all estimate2b ;
data &error._&measure._est2c_all ;
	merge &error._&measure._est2c_all estimate2c ;
run ;

%mend ;



%macro lll ;


data x1 ;
	set expl_cat._reg_&error.2_1 ;
	horizon1=1 ;
		promoall= d_freq+ f_freq ;
data x4 ;
	set expl_cat._reg_&error.2_4 ;
	horizon4=1 ;
		promoall= d_freq+ f_freq ;
data x12 ;
	set expl_cat._reg_&error.2_12 ;
	horizon12=1 ;

		promoall= d_freq+ f_freq ;
 	
data expl_cat.all_&error._all_horizons ;
	set x1 x4 x12 ;
	if horizon1=. then horizon1=0 ;
	if horizon4=. then horizon4=0 ;
	if horizon12=. then horizon12=0 ;
 
run ;




	%doit0(Paptowl	); 
	%doit1(saltsnck);
	%doit1(beer	);
	%doit1(carbbev	);
	%doit1(blades	);

	%doit1(cigets	);
	%doit1(coffee	);
	%doit1(coldcer	);
	%doit1(deod	); 
	%doit1(factiss	);

	%doit1(fzdinent);
	%doit1(fzpizza	);
	%doit1(hhclean	);
	%doit1(hotdog	);
	%doit1(laundet	);

	%doit1(margbutr);
	%doit1(mayo	);
	%doit1(milk	);
	%doit1(mustketc);
	%doit1(peanbutr);

	%doit1(photo	); 
	%doit1(razors	);
	%doit1(shamp	);
	%doit1(soup	);
	%doit1(spagsauc);

	%doit1(sugarsub);
	%doit1(toitisu	);
	%doit1(toothbr	);
	%doit1(toothpa	);
	%doit1(yogurt	);  
%mend ;
%let error=mape ;
%let measure= _ad4_ic ;
%lll ;
%let measure= _ad4_ew ;
%lll ;
%let measure= _ow2_ew	;
%lll ;
%let measure= _ow2_ic;	 
%lll ;


%let error=mase ;
%let measure= _ad4_ic ;
%lll ;
%let measure= _ad4_ew ;
%lll ;
%let measure= _ow2_ew	;
%lll ;
%let measure= _ow2_ic;	 
%lll ;

%let error=smape ;
%let measure= _ad4_ic ;
%lll ;
%let measure= _ad4_ew ;
%lll ;
%let measure= _ow2_ew	;
%lll ;
%let measure= _ow2_ic;	 
%lll ;

