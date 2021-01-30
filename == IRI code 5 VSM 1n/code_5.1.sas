



/*  
to extract the SKU numbers
from original dataset to variable list
*/
%macro extract_var_name (data) ;
	data dataset_in_use ;
		set &data ;
		if %eval(&start-1) <week< &end  ; * this is the estimation/specificaiton window ;
	run ;
	data temp ;
		set dataset_in_use ; *   ;
		keep logs_1 - logs_3000 ;
		if _n_> 1 then delete ;
	run ;
	proc transpose data= temp out= templist ;
	run ;
%mend ;

 /* to conduct the LASSO selection. We re-insert the own explantory variables after the LASSO selection */
 %macro selection  ;

	ods listing  ;
	/* Method: LASSO ;*/
	proc glmselect data= dataset_in_use  ;
		model logs_&skunumber = &catstring/ 
				selection= lasso (choose= cvex) cvmethod=split(10) ;
		ods output selectionsummary=lasso_table ;
	run;
	data lasso ;
		length EffectEntered $ 16;
		set Lasso_table ;
		keep EffectEntered ;
		if EffectEntered="Intercept" then delete ;
		if EffectEntered="" then delete ;
	run ;
	 /* NO ADD BACK ;*/
 
	data &output_var (rename=(EffectEntered= r&skunumber)) ;
		set  Lasso      ;
		label  EffectEntered= r&skunumber ;
	run ;
	 

	proc sort data= &output_var noduplicate ;
		by 	r&skunumber ;	 
	run ;
 %mend ;

/* we index the SKU's */
%macro extractskunumber ;
/* we give indice to the SKU numbers in the category */ ;
	data _null_ ;
		set templist ;
		i= _n_ ;
		sku_list= compress(_name_,"logs_");
		sku_list_numeric= input(sku_list, 12.) ;
		call symput('sku_for_modelling'||strip(i),sku_list_numeric);
	run ;	
%mend ;





%extract_var_name(data4_0.Data_groc_&category) ; 
%extractskunumber ;
/* then we need to know how many sku's in total, by quoting the macro */
%obsnvars(templist) ;

	/* we concatenate strings and conduct PROC GLMSELECT */
	 
	/* once we have the number of SKU's and SKU_numbers, we can construct the string for the corresponding variables.
	e.g., if we have 2 SKU's, 1 and 22. then we can construct 
	logp_1 logp_22
	logs_1 logs_22 (logs will NOT be used in the variable selection though)
	f_1 f_22
	d_1 d_22
	*/
	%macro construct_string (variable) ;
		%global sku s_complete  ;
		%do i= 1 %to 1 ;
			%let sku= &&sku_for_modelling&i ;
			%let s_complete= &variable&sku ;
		%end ;
	 	%do i= 2 %to &nobs ;
			%let sku= &&sku_for_modelling&i ;
			%let s_complete = &variable&sku &s_complete ;
		%end ;	
	%mend ;
	%construct_string (logp_);	 	%let string_price= &s_complete ;	 /* %symdel s_complete ;	*%symdel sku ; */
	%construct_string (logs_);	 	%let string_units= &s_complete ; 	 /* %symdel s_complete ;	*%symdel sku ; */
	%construct_string (f_);		 	%let string_f= &s_complete ; 		 /* %symdel s_complete ;	*%symdel sku ; */
	%construct_string (d_);		 	%let string_d= &s_complete ;		 /* %symdel s_complete ;	*%symdel sku ; */
	/* we then concatenate all the explantory variables */
	%let catstring= &string_price &string_f &string_d ; 				 /* %put &catstring  ; */ 

 

/* then we select the explanatory variables for each SKU, and we concatenate 
	the retained variables into one single table for that category*/

%macro select_all_variables ;
%do ii= 1 %to 1 ;
	%let skunumber= &&sku_for_modelling&ii ; %let output_var= data_v1n.vs_&start._&end._&category._all ;
	%selection ;

%end ;
%do ii= 2 %to &nobs ;
	%let skunumber= &&sku_for_modelling&ii ; %let output_var= data_v1n.vs_&category._&skunumber ;
	%selection ;
	data data_v1n.vs_&start._&end._&category._all ;
		merge data_v1n.vs_&start._&end._&category._all data_v1n.vs_&category._&skunumber ;
	run ;
	proc delete data= data_v1n.vs_&category._&skunumber ;
	run ;
%end ;
%mend ;

%select_all_variables ;


/* check */
%obsnvars(data_v1n.vs_&start._&end._&category._all) ;
data _check_&category._&start._&end ;
	category="&category" ;
	nvars= &nvars ;
	nobs= &nobs ;
	start= &start ;
	end= &end ;
	output ;
run ;
