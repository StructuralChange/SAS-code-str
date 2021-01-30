

/* this macro organize results so that they will be put in R package PMCMR */
 
%let measure= smape ;
%macro arrange1 (model) ;
data d_&model (rename =( &measure._&model= &measure)) ;
	set All_comparison_&measure ;
	length model $ 10 ;
	model = "&model" ;
	keep &measure._&model model ;
run ;
 
%mend ;


%arrange1 (base) ;
%arrange1 (own) ;
%arrange1 (own_ew) ;
%arrange1 (own_ic) ;
%arrange1 (adl) ;
%arrange1 (adl_ew) ;
%arrange1 (adl_ic) ;
%arrange1 (f) ;
%arrange1 (f_ewc) ;
%arrange1 (f_ic) ;
/*concatenate */

data d_all_&measure ;
	set d_base
		d_own
		d_own_ic
		d_own_ew
		d_adl
		d_adl_ic
		d_adl_ew
		d_f
		d_f_ic
		d_f_ewc ;
run ;
data d_test_&measure ;
	set  
		d_adl
		d_adl_ic
	  ;
run ;

proc npar1way data = d_test_smape ;
  class model;
  var smape;
run;
 

