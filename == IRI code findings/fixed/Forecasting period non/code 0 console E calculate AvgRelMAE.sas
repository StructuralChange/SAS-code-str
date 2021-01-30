options nonotes nosource ;
*calculating AvgRelMAE ;


 
 
/*%let number_of_sku=127 ;
*/
%macro shw(benchmark, model, horizon) ;

%macro run1 ;
	 
	%do i= 1 %to 20 ;
		%let roll= &i ;
		%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 3.1 calculate AvgRelMAE.sas" ;

	%end ;
%mend ;

%run1 ;

 
data rank_2.Armae_&model._vs_&benchmark._h&horizon ;
	set Armae_&model._vs_&benchmark._h&horizon._r1 ;
run ;

proc delete data= Armae_&model._vs_&benchmark._h&horizon._r1 ; run ;

%macro concatenate1 ;
	%do i= 2 %to 20 ;
		data rank_2.Armae_&model._vs_&benchmark._h&horizon ;
			set rank_2.Armae_&model._vs_&benchmark._h&horizon
				Armae_&model._vs_&benchmark._h&horizon._r&i ;
		run ;
		proc delete data= Armae_&model._vs_&benchmark._h&horizon._r&i ; run ;
	%end ;
%mend ;

%concatenate1 ; 
%mend; 

 %macro implementall (horizon1) ;

%shw(	base	,	own	,	&horizon1) ;
%shw(	base	,	adl	,	&horizon1) ;
%shw(	base	,	f	,	&horizon1) ;
%shw(	base	,	own_ew	,	&horizon1) ;
%shw(	base	,	own_ic	,	&horizon1) ;
%shw(	base	,	adl_ew	,	&horizon1) ;
%shw(	base	,	adl_ic	,	&horizon1) ;
%shw(	base	,	f_ewc	,	&horizon1) ;
%shw(	base	,	f_ic	,	&horizon1) ;
%shw(	own	,	adl	,	&horizon1) ;
%shw(	own	,	f	,	&horizon1) ;
%shw(	own	,	own_ew	,	&horizon1) ;
%shw(	own	,	own_ic	,	&horizon1) ;
%shw(	own	,	adl_ew	,	&horizon1) ;
%shw(	own	,	adl_ic	,	&horizon1) ;
%shw(	own	,	f_ewc	,	&horizon1) ;
%shw(	own	,	f_ic	,	&horizon1) ;
%shw(	adl	,	f	,	&horizon1) ;
%shw(	adl	,	own_ew	,	&horizon1) ;
%shw(	adl	,	own_ic	,	&horizon1) ;
%shw(	adl	,	adl_ew	,	&horizon1) ;
%shw(	adl	,	adl_ic	,	&horizon1) ;
%shw(	adl	,	f_ewc	,	&horizon1) ;
%shw(	adl	,	f_ic	,	&horizon1) ;
%shw(	f	,	own_ew	,	&horizon1) ;
%shw(	f	,	own_ic	,	&horizon1) ;
%shw(	f	,	adl_ew	,	&horizon1) ;
%shw(	f	,	adl_ic	,	&horizon1) ;
%shw(	f	,	f_ewc	,	&horizon1) ;
%shw(	f	,	f_ic	,	&horizon1) ;
%shw(	own_ew	,	own_ic	,	&horizon1) ;
%shw(	own_ew	,	adl_ew	,	&horizon1) ;
%shw(	own_ew	,	adl_ic	,	&horizon1) ;
%shw(	own_ew	,	f_ewc	,	&horizon1) ;
%shw(	own_ew	,	f_ic	,	&horizon1) ;
%shw(	own_ic	,	adl_ew	,	&horizon1) ;
%shw(	own_ic	,	adl_ic	,	&horizon1) ;
%shw(	own_ic	,	f_ewc	,	&horizon1) ;
%shw(	own_ic	,	f_ic	,	&horizon1) ;
%shw(	adl_ew	,	adl_ic	,	&horizon1) ;
%shw(	adl_ew	,	f_ewc	,	&horizon1) ;
%shw(	adl_ew	,	f_ic	,	&horizon1) ;
%shw(	adl_ic	,	f_ewc	,	&horizon1) ;
%shw(	adl_ic	,	f_ic	,	&horizon1) ;

%mend ;

 
%implementall (12);

 
%implementall(4) ;
 
%implementall(1) ;













 
