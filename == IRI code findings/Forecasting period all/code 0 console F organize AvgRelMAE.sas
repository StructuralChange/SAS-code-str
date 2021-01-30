options nonotes nosource ;
%let horizon=12 ;
/* the AVRELMAE is calculated based on own */
 

%macro armae1(model) ;

	proc means data= rk_armae.Armae_&model._vs_base_h&horizon mean noprint ;
		var avg_rel_mae ;
		output out=x1 mean=mean ;
	data x_&model._&horizon ;
		set x1 ;
		avg_rel_mae=mean ;
		candidate="&model" ;
		horizon=&horizon ;
		drop _type_ _freq_ mean ;
	run ;
%mend ;
%armae1(own) ;
%armae1(adl) ;
%armae1(adl_ic) ;
%armae1(adl_ew) ;
%armae1(own_ic) ;
%armae1(own_ew) ;
%armae1(f) ;
%armae1(f_ewc) ;
%armae1(f_ic) ;
data base ;
	candidate="base" ;
	avg_rel_mae=1 ;
	horizon=&horizon ;
	output ;
run ;
data all ;
	length candidate $ 12;
	set base 
		x_own_&horizon
		x_adl_&horizon
		x_own_ew_&horizon
		x_own_ic_&horizon
		x_adl_ic_&horizon
		x_adl_ew_&horizon
		x_f_&horizon
		x_f_ic_&horizon
		x_f_ewc_&horizon
		;
 
run ;


* step2:	add ranks ;
%macro rank1( data) ;
	proc rank data= &data out=ranking_all ;
		var avg_rel_mae ;
		ranks rk_avg_rel_mae ;
	run ;
 
%mend ;
 
%rank1 ( all) ;
 








 
