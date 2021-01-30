options nonotes nosource ;
*calculating AvgRelMAE ;



 %let number_of_sku=128 ;
/*%let number_of_sku=126 ;

%let benchmark=base ;
%let model=adl ;
%let horizon=4 ;
%let roll=1 ;

%let limit_horizon= %str(if horizon>&horizon then delete ; ) ; * this include the forecast horizons from 1 to 12 ;
%global limit_horizon ;
%put &limit_horizon ;

*/

/* for fixed, there is only 1 roll */
%macro shw(benchmark, model, horizon) ;

	%macro run1 ;
		 
		%do i= 1 %to 1 ;
			%let roll= &i ;
			%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 3.1 calculate AvgRelMAE.sas" ;

		%end ;
	%mend ;

	%run1 ;

 
data rank_2.Armae_&model._vs_&benchmark._h&horizon ;
	set Armae_&model._vs_&benchmark._h&horizon._r1 ;
run ;

proc delete data= Armae_&model._vs_&benchmark._h&horizon._r1 ; run ;


%mend; 





%let horizon1=12 ;
%let limit_horizon= %str(if horizon>&horizon1 then delete ; ) ; * this include the forecast horizons from 1 to 12 ;
%global limit_horizon ;


%shw(	base	,	own	,	&horizon1) ;
%shw(	base	,	adl	,	&horizon1) ;
%shw(	base	,	f	,	&horizon1) ;
%shw(	base	,	own_ew	,	&horizon1) ;
%shw(	base	,	own_ic	,	&horizon1) ;
%shw(	base	,	adl_ew	,	&horizon1) ;
%shw(	base	,	adl_ic	,	&horizon1) ;
%shw(	base	,	f_ewc	,	&horizon1) ;
%shw(	base	,	f_ic	,	&horizon1) ;
 


 
 %let horizon1=4 ;
%let limit_horizon= %str(if horizon>&horizon1 then delete ; ) ; * this include the forecast horizons from 1 to 12 ;
%global limit_horizon ;


%shw(	base	,	own	,	&horizon1) ;
%shw(	base	,	adl	,	&horizon1) ;
%shw(	base	,	f	,	&horizon1) ;
%shw(	base	,	own_ew	,	&horizon1) ;
%shw(	base	,	own_ic	,	&horizon1) ;
%shw(	base	,	adl_ew	,	&horizon1) ;
%shw(	base	,	adl_ic	,	&horizon1) ;
%shw(	base	,	f_ewc	,	&horizon1) ;
%shw(	base	,	f_ic	,	&horizon1) ;
 



 
 %let horizon1=1 ;
%let limit_horizon= %str(if horizon>&horizon1 then delete ; ) ; * this include the forecast horizons from 1 to 12 ;
%global limit_horizon ;


%shw(	base	,	own	,	&horizon1) ;
%shw(	base	,	adl	,	&horizon1) ;
%shw(	base	,	f	,	&horizon1) ;
%shw(	base	,	own_ew	,	&horizon1) ;
%shw(	base	,	own_ic	,	&horizon1) ;
%shw(	base	,	adl_ew	,	&horizon1) ;
%shw(	base	,	adl_ic	,	&horizon1) ;
%shw(	base	,	f_ewc	,	&horizon1) ;
%shw(	base	,	f_ic	,	&horizon1) ;
 


 
