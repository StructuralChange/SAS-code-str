
/* preliminary results:
if we add 2 lags for own variables and 1 lage for competitive variables, then we run vsm and then the MODEL proc,
the model will be outperformed by the own  model(e.g., 2 own variables in the vsm and then MODEL proc)


/*  
to extract the SKU numbers
from original dataset to variable list

so that we know which SKU's we are going to conduct the VSM process
*/
%macro extract_var_name (data) ;
	data dataset_in_use ;
		set &data ;
		if %eval(&start-1) <week< &end ; * this is the estimation/specificaiton window ;
	run ;
	data temp ;
		set dataset_in_use ; *   ;
		keep logs_1 - logs_3000 ;
		if _n_> 1 then delete ;
	run ;
	proc transpose data= temp out= templist ;
	run ;
%mend ;

 /* to conduct the LASSO selection. Also we re-insert the own explantory variables after the LASSO selection */
/* note that, the variable list is , i.e., &catstring_in_use */
 %macro selection  ;

	ods listing  ;
	/* Method: LASSO ;*/
	proc glmselect data= dataset_in_use  ;
		model logs_&skunumber = &catstring_in_use  / 
				/* selection= lasso (choose= aic) ;*/
				selection= lasso (choose= cvex) cvmethod=split(10) ; /* here we use LASSO  with 10-fold cross validation */
		ods output selectionsummary=lasso_table ;
	run;
	data lasso ;
		length EffectEntered $ 16;
		set Lasso_table ;
		keep EffectEntered ;
		if EffectEntered="Intercept" then delete ;
		if EffectEntered="" then delete ;
	run ;
	 /* we will include the 'own-variables' because they are important and may be wrongfully excluded by the algorithms ;
	add own variables ;*/
	data temp_own_x ;
		length EffectEntered $ 16;
		EffectEntered= "" ;
		output ;
	run ;
	data &output_var (rename=(EffectEntered= r&skunumber)) ;
		set   temp_own_x Lasso   ;
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

 
/* this macro extract the variables which we obtained from the 1st stage VSM process.
	the variables are from library data_v1.___.
	this is the 2nd stage VSM so we not only need the original retained variables but their corresponding lagged terms */
%macro kk ;

	%do kk= 1 %to &nobs ;
		%let tt= &&sku_for_modelling&kk ;
		%global catstring_&tt ;
		/* we extract the variables from library data_v1, here we rearrange the retained dataset*/
		/* %let tt= 143 ;*/
		data temp_&tt ;
			set data_t1.Vs_&start._&end._&category._all ;
			keep r&tt ;
			if r&tt="" then delete ;
		run ;

	
	/* here we construct the lagged terms for those retained variables */


	data temp_&tt._lags ;
		set temp_&tt ;
		r&tt._lag1 = cats(r&tt,"_lag1") ;
		r&tt._lag2 = cats(r&tt,"_lag2") ;
	 
	run ;
	/* then, for each SKU, we concatenate all their retained variables (with lag1) into strings */
	/* the following macro ONLY read the variables and dimensions for this specfic SKU */
		data _null_ ;
				set temp_&tt._lags ;
				i= _n_ ;
				*sku_list= compress(_name_,"logs_");
				*sku_list_numeric= input(sku_list, 12.) ;
				call symput('retained'||strip(i),r&tt.);
				call symput('retained_lag1'||strip(i),r&tt._lag1);
				call symput('retained_lag2'||strip(i),r&tt._lag2);
			run ;	  ;

	%obsnvars(temp_&tt) ;
 
		%macro construct_string2   ;
			%global sku s_complete sku_lag1 s_complete_lag1 s_complete_lag2 ;
			%do i= 1 %to 1 ;
				%let sku= &&retained&i ;
				%let s_complete=  &sku ;
 

			%end ;
		 	%do i= 2 %to &nobs ;
				%let sku= &&retained&i ;
				%let s_complete =  &sku &s_complete ;
 
			%end ;	
		%mend ;
		%construct_string2 ;
		 
		/* we concatenate the original retained variables and their corresponding lagged terms , plus the calendar effects*/
		 /* %put &&catstring_&tt ;  */
	 
 		%let catstring_&tt = &s_complete  
		Halloween	Thanksgiving	Christmas	NewYear	Presidents	Easter	July_4	Labor	Memoday	
		m1	m2	m3	m4	m5	m6	m7	m8	m9	m10	m11	m12	
		Halloween_lag	Thanksgiving_lag	Christmas_lag	NewYear_lag	Presidents_lag	Easter_lag	July_4_lag	Labor_lag	Memoday_lag
		; /* here we include seasonality only */
 
	%end ;


%mend ;


/* here we construct the strings for the VSM selection, and we implement the selection, and we concatenate the final results */

%macro select_all_variables ;
%do ii= 1 %to 1 ;
	%let skunumber= &&sku_for_modelling&ii ; 
	%let catstring_in_use= &&catstring_&skunumber  ;
	%let output_var= Data_t2.vs_&start._&end._&category._all ;
	%selection ;

%end ;
%do ii= 2 %to &nobs ;
	%let skunumber= &&sku_for_modelling&ii ; 
	%let catstring_in_use= &&catstring_&skunumber   ;
	%let output_var= Data_t2.vs_&category._&skunumber ;
	%selection ;

	data Data_t2.vs_&start._&end._&category._all ;
		merge Data_t2.vs_&start._&end._&category._all 
				Data_t2.vs_&category._&skunumber ;
	run ;
	proc delete data= Data_t2.vs_&category._&skunumber ;
	run ;
%end ;
%mend ;






/* %let category=Paptowl ; */

/* we need to use the dataset with lagged terms because PROC GLMSELECT does not recognize lag funcions */
%extract_var_name(data4.Data_groc_&category) ; 

%extractskunumber ;

%obsnvars(templist) ;

%kk ;

%obsnvars(templist) ;

%select_all_variables ;



 
