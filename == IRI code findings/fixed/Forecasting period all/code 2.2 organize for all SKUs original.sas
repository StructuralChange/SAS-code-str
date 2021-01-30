
options nonotes nosource ;
*%let measure= mape ;
%macro all_initial (category) ;
	data all_details_&model ;
		set rank_all.Model_&model._&category._&measure ;
	run ;
%mend ;

%macro all_others (category) ;
	data all_details_&model ;
		set all_details_&model rank_all.Model_&model._&category._&measure ;
	run ;
%mend ;

%macro testall(model) ;



/* %let model=adl ; */
%all_initial (beer) ;
/* %all_others (	paptowl	) ; * too few SKU's ;*/
%all_others (	carbbev	) ;
%all_others (	blades	) ;
%all_others (	cigets	) ;
%all_others (	coffee	) ;
%all_others (	coldcer	) ;
%all_others (	deod	) ;
/* %all_others (	diapers	) ;*/
%all_others (	factiss	) ;
%all_others (	fzdinent	) ;
%all_others (	fzpizza	) ;
%all_others (	hhclean	) ;
%all_others (	hotdog	) ;
%all_others (	laundet	) ;
%all_others (	margbutr	) ;
%all_others (	mayo	) ;
%all_others (	milk	) ;
%all_others (	mustketc	) ;
%all_others (	peanbutr	) ;
%all_others (	photo	) ;
*%all_others (	razors	) ;
%all_others (	saltsnck	) ;
%all_others (	shamp	) ;
%all_others (	soup	) ;
%all_others (	spagsauc	) ;
%all_others (	sugarsub	) ;
%all_others (	toitisu	) ;
%all_others (	toothbr	) ;
%all_others (	toothpa	) ;
%all_others (	yogurt	) ;


proc sort data= all_details_&model ;
	by category sku ;
run ;

data all_details_&model (rename= (&measure= &measure._&model)) ;
	set all_details_&model ;
run ;

%mend ;
%testall (base) ;
%testall (own) ;
%testall (adl) ;
%testall (f) ;
%testall (own_ew) ;
%testall (own_ic) ;
%testall (adl_ew) ;
%testall (adl_ic) ;
%testall (f_ewc) ;
%testall (f_ic) ;
 
 

data all_comparison_&measure ;
	merge All_details_base
		  All_details_own
		  All_details_adl
		  All_details_f
		  All_details_own_ew
		  All_details_own_ic
		  All_details_adl_ew
		  All_details_adl_ic
		  All_details_f_ewc
		  All_details_f_ic 
 
		    ;
		  by category sku ;
run ;
