options nosource nonotes ;


options nonotes nosource ;
*calculating AvgRelMAE ;
%macro significance_calculate (dataset, measure )   ;
	data all ; 
		set &dataset ;
		dif = &measure._original- &measure._adj ;
	proc univariate data = all noprint ;
		var dif;
		output out=test PROBS=p_sr PROBT=p_t;
	proc means data=all noprint mean ;
		var dif ;
		output out= def ;
	data def ;
		set def ;
		if _stat_="MEAN" ;
		keep dif ;
	data sig_temp ;
		merge def test ;
	data temp1 ;
		set sig_temp ;
		format model1 $12. ;
		format model2 $12. ;
		model1= "&model0" ;
		model2= "&model1" ;
		measure="&measure" ;
			 
	run ;
%mend   ;


 

%macro sig0 (model0, model1 ,measure) ; 
/* %let model0= r_adl4 ;
	%let model1= r_ad4_ew ;
*/
data aa ;
	set expl_str._all_&model0._versus_&model1 ;

	ape_original= abs(actual- forecast_original)/actual ;
	ape_adj= abs(actual- forecast_sb_adjusted)/actual ;

	sape_original= 2*abs(actual- forecast_original)/(actual + forecast_original) ;
	sape_adj= 2*abs(actual- forecast_sb_adjusted)/(actual+ forecast_original) ;

	ase_original= q_0 ;
	ase_adj= q_1 ;
	if horizon>1 then delete ;
run ;


proc sort data= aa ;
	by category sku   ;

proc means data=  aa noprint ;
	by category sku   ;
	output out= k_mean ;
run ;

data k_mean ;
	set k_mean ;
	if _stat_= "MEAN" ;
	mape_original	= ape_original ;
	mape_adj		= ape_adj ;
	smape_original	= sape_original ;
	smape_adj		= sape_adj ;
	mase_original	= ase_original ;
	mase_adj		= ase_adj ;
run ;

%significance_calculate (k_mean, &measure) ;

data sig_test_all_h1 ;
	set temp1 ;
run ;

%mend ;
%macro sig1 (model0, model1, measure) ; 
/* %let model0= r_adl4 ;
	%let model1= r_ad4_ew ;
*/
data aa ;
	set expl_str._all_&model0._versus_&model1 ;

	ape_original= abs(actual- forecast_original)/actual ;
	ape_adj= abs(actual- forecast_sb_adjusted)/actual ;

	sape_original= 2*abs(actual- forecast_original)/(actual + forecast_original) ;
	sape_adj= 2*abs(actual- forecast_sb_adjusted)/(actual+ forecast_original) ;

	ase_original= q_0 ;
	ase_adj= q_1 ;

	if horizon>1 then delete ;
run ;


proc sort data= aa ;
	by category sku   ;

proc means data=  aa noprint ;
	by category sku   ;
	output out= k_mean ;
run ;

data k_mean ;
	set k_mean ;
	if _stat_= "MEAN" ;
	mape_original	= ape_original ;
	mape_adj		= ape_adj ;
	smape_original	= sape_original ;
	smape_adj		= sape_adj ;
	mase_original	= ase_original ;
	mase_adj		= ase_adj ;
run ;

%significance_calculate (k_mean, &measure) ;

data sig_test_all_h1 ;
	set sig_test_all_h1 temp1 ;
run ;

%mend ;
%sig0(r_adl4, r_ad4_ew, mape) ;
%sig1(r_adl4, r_ad4_ic, mape) ;
%sig1(r_adl2, r_ad2_ew, mape) ;
%sig1(r_adl2, r_ad2_ic, mape) ;

%sig1(r_adl4, r_ad4_ew, smape) ;
%sig1(r_adl4, r_ad4_ic, smape) ;
%sig1(r_adl2, r_ad2_ew, smape) ;
%sig1(r_adl2, r_ad2_ic, smape) ;

%sig1(r_adl4, r_ad4_ew, mase) ;
%sig1(r_adl4, r_ad4_ic, mase) ;
%sig1(r_adl2, r_ad2_ew, mase) ;
%sig1(r_adl2, r_ad2_ic, mase) ;







