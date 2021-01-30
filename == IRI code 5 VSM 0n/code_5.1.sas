



/*  
to extract the SKU numbers
from original dataset to variable list

so that we know which SKU's we are going to conduct the VSM process
*/
%macro extract_var_name (data) ;
	data dataset_in_use ;
		set &data ;
		if %eval(&start-1) <week< &end ; * this is the estimation/specificaiton window ;
		trig_y1= sin(2*constant("pi")*week/52) ;
		trig_y2= cos(2*constant("pi")*week/52) ;
		trig_m1= sin(2*constant("pi")*week/4) ;
		trig_m2= cos(2*constant("pi")*week/4) ;
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
	/* %let skunumber= 148 ;  */
	proc glmselect data= dataset_in_use  ;
		model logs_&skunumber = &catstring_in_use  / 
				selection= lasso (choose= cvex) cvmethod=split(10) ; /* here we use elastic net with 10-fold cross validation */
		ods output selectionsummary=lasso_table ;
	run;
	data lasso ;
		length EffectEntered $ 16;
		set Lasso_table ;
		keep EffectEntered ;
		if EffectEntered="Intercept" then EffectEntered="" ;
		/* if EffectEntered="" then delete ;*/
	run ;
	 /* we will NOT include the 'own-variables' in this macro ;
	s ;*/
	/*
	data temp_own1 ;
		length EffectEntered $ 16;
		EffectEntered= "logp_&skunumber" ;
		output ;
	data temp_own2 ;
		length EffectEntered $ 16;
		EffectEntered= "f_&skunumber" ;
		output ;
	data temp_own3 ;
		length EffectEntered $ 16;
		EffectEntered= "d_&skunumber" ;
		output ;
	run ;

	%put &output_var ;
	*/
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
 

  		/* %let tt=148 */
		/* we concatenate the original retained variables and their corresponding lagged terms , plus the calendar effects*/
		%let catstring_&tt = logs_&tt._lag1  logs_&tt._lag2 
							 logp_&tt logp_&tt._lag1  logp_&tt._lag2 
							 f_&tt f_&tt._lag1 f_&tt._lag2
							 d_&tt d_&tt._lag1 d_&tt._lag2
		Halloween	Thanksgiving	Christmas	NewYear	Presidents	Easter	July_4	Labor	Memoday	
		trig_y1	trig_y2	trig_m1	trig_m2
		Halloween_lag	Thanksgiving_lag	Christmas_lag	NewYear_lag	Presidents_lag	Easter_lag	July_4_lag	Labor_lag	Memoday_lag
		; 
		 
 
 
	%end ;


%mend ;


/* here we construct the strings for the VSM selection, and we implement the selection, and we concatenate the final results */

%macro select_all_variables ;
%do ii= 1 %to 1 ;
	/* %let ii=1 ; 
		%put &catstring_in_use ; 
		%put catstring_148  ;*/
	%let skunumber= &&sku_for_modelling&ii ; 
	%let catstring_in_use= &&catstring_&skunumber  ;
	%let output_var= data_v0n.vs_&start._&end._&category._all ;
	%selection ;

%end ;
%do ii= 2 %to &nobs ;
	%let skunumber= &&sku_for_modelling&ii ; 
	%let catstring_in_use= &&catstring_&skunumber  ;
	%let output_var= data_v0n.vs_&category._&skunumber ;
	%selection ;

	data data_v0n.vs_&start._&end._&category._all ;
		merge data_v0n.vs_&start._&end._&category._all data_v0n.vs_&category._&skunumber ;
	run ;
	proc delete data= data_v0n.vs_&category._&skunumber ;
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



/* check */
%obsnvars(data_v0n.vs_&start._&end._&category._all) ;
data _check_&category._&start._&end ;
	category="&category" ;
	nvars= &nvars ;
	nobs= &nobs ;
	start= &start ;
	end= &end ;
	output ;
run ;
