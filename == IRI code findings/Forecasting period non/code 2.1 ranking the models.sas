 

%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 2.2 organize for all SKUs.sas" ;


%macro means1(model) ;
	proc means data= All_comparison_&measure noprint ;
		var &measure._&model ;
		output out= r_&model mean=mean_&model ;
	run ;
%mend ;
	%means1(base) ;
	%means1(own) ;
	%means1(adl) ;
	%means1(own_ew) ;
	%means1(own_ic) ;
	%means1(adl_ic) ;
	%means1(adl_ew) ;
	%means1(f) ;
	%means1(f_ic) ;
	%means1(f_ewc);
 
 

 	data r_allmodel ;
		merge r_base
			  r_own
			  r_adl
			  r_own_ew
			  r_own_ic
			  r_adl_ic
			  r_adl_ew
			  r_f
			  r_f_ic
			  r_f_ewc
 
			   ;
		drop _freq_ _type_ ;
	run ;
proc transpose data= r_allmodel out= &measure._all ;
data &measure._all ;
	set &measure._all ;
	rename col1= &measure ;
run ;



* step2:	add ranks ;
%macro rank1( measure) ;
	proc rank data= &measure._all out=ranking_&measure ;
		var &measure ;
		ranks rk_&measure ;
	run ;
	data ranking_&measure ;
		set ranking_&measure ;
		label rk_&measure= rk_&measure ;
	run ;
%mend ;
 
%rank1 ( &measure) ;
 
 
