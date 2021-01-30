
options nosource nonotes  ;
 
/* it is better to use samples of larger size,  (e.g., 200 weeks compared to 120 week) to avoid overestimating the effect of price */


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

/* step 2: conduct the modelling for each of the SKU's in the category */
%macro run_candidate_model   ;
	%do cc= 1 %to &nobs ;
		%let skunumber= &&sku_for_candidate_modelling&cc ;
		/* %let skunumber= 22 ;*/
		%put &skunumber  ;
		%include "Q:\= IRI data research\== IRI code 6 modelling\_code x1.1 model.sas" ;
	%end ;
%mend ;


/* step 3: implement step 2 for all the categories */
%macro conduct_all_category ;
	%include "Q:\= IRI data research\== IRI code 6 modelling\CONSOLE_model_category_string.sas" ;
%mend ;

 
/* step 4: execution */
 
	%let output_lib= r_adl_ic ;
	%conduct_all_category ;				
 
 
