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
	set expl_str.overall_&model0._versus_&model1 ;

	ape_original= ae_0/actual ;
	ape_adj= ae_1/actual ;

	sape_original= 2*ae_0/(actual + forecast_original) ;
	sape_adj= 2*ae_1/(actual+ forecast_sb_adjusted) ;

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
	set expl_str.overall_&model0._versus_&model1 ;

	ape_original= ae_0/actual ;
	ape_adj= ae_1/actual ;

	sape_original= 2*ae_0/(actual + forecast_original) ;
	sape_adj= 2*ae_1/(actual+ forecast_sb_adjusted) ;

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
 

%sig0(r_adl4, r_ad4_ic, smape) ;





 
