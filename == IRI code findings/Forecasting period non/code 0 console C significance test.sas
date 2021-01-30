* this macro tests the statistical significance for the difference between the results of the various models ;

%macro significance_calculate (dataset, var1, var2)   ;
	data all ; 
		set &dataset ;
		dif = &var1- &var2 ;
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
	data sig_&var1._&var2 ;
		merge def test ;
	data temp1 ;
		set sig_&var1._&var2 ;
		format model1 $12. ;
		format model2 $12. ;
		model1= "&var1" ;
		model2= "&var2" ;
			 
	run ;
%mend   ;


  




%macro allall ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 2.2 organize for all SKUs.sas" ;



%significance_calculate (All_comparison_&measure,&measure._base, &measure._own) ;

data temp0 ; set temp1 ; run ;        	   %significance_calculate (All_comparison_&measure,&measure._base, &measure._adl) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._base, &measure._f) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._base, &measure._own_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._base, &measure._own_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._base, &measure._adl_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._base, &measure._adl_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._base, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._base, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._adl) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._f) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._own_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._own_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._adl_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._adl_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl, &measure._f) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl, &measure._own_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl, &measure._own_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl, &measure._adl_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl, &measure._adl_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._f, &measure._own_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._f, &measure._own_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._f, &measure._adl_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._f, &measure._adl_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._f, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._f, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ew, &measure._own_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ew, &measure._adl_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ew, &measure._adl_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ew, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ew, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ic, &measure._adl_ew) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ic, &measure._adl_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ic, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._own_ic, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl_ew, &measure._adl_ic) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl_ew, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl_ew, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl_ic, &measure._f_ewc) ;
data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._adl_ic, &measure._f_ic) ; 

data temp0 ; set temp0 temp1 ; run ;       %significance_calculate (All_comparison_&measure,&measure._f_ewc, &measure._f_ic) ; 
data temp0 ; set temp0 temp1 ; run ;   
 


data sig_&measure ;
	set temp0 ;
run ;


%mend ;
 
%let measure= mpe ; %allall ;
%let measure= mape ; %allall ;
%let measure= smape ; %allall ;
%let measure= mase ; %allall ;
%let measure= mae ; %allall ;
