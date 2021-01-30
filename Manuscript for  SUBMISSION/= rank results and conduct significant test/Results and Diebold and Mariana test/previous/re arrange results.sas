options nosource nonotes  ;
 
/*  this macro clean existing results

previously the test code has been run but not completed, so the previous results are added with duplicants

*/


/* pre-loaded macros */ 
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;

/* step 1: the following macros are used to automatically load the skunumbers of the SKU's for a specific category */ 
/* step 1.1: to extract the skunumber of the SKU's for a specific category. e.g., to extract the variable names of the dataset for that category */
%macro extract_var_name (data) ;
	data temp ;
		set &data ; *   ;
		keep logs_1 - logs_3000 ;
		if _n_> 1 then delete ;
	run ;
	proc transpose data= temp out= templist ;
	run ;
%mend ;




/* step 1.2: put the variable names (i.e., skunumbers) into global variables */
%macro extractskunumber ;
	data _null_ ;
		set templist ;
		i= _n_ ;
		sku_list= compress(_name_,"logs_");
		sku_list_numeric= input(sku_list, 12.) ;
		call symput('sku_for_candidate_modelling'||strip(i),sku_list_numeric);
	run ;	
%mend ;

%extract_var_name(data4.Data_groc_beer) ;
%extractskunumber ;
%obsnvars(templist) ;

/* step 2: conduct the modelling for each of the SKU's in the category */
%macro runall   ;
	%do cc= 1 %to &nobs ;
		%let skunumber= &&sku_for_candidate_modelling&cc ;
		/* %let skunumber= 22 ;*/
		%put &skunumber  ;
		data Cat_beer_sku&skunumber ;
			set r_ewc_ic.Cat_beer_sku&skunumber ;
			if forecast=. then delete ;
		run ;
		proc sort data= Cat_beer_sku&skunumber  nodup ;
			by start horizon ;
		run ;



	%end ;
%mend ;
%runall ;
