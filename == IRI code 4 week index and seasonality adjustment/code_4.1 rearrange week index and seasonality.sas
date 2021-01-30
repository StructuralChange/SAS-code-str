


%macro extract_var_name (data) ;
	data temp0 ;
		set &data ; *   ;
		keep &string1   ; /* for sales and price lags, we use 2 lags */
		 
	run ;
	data temp ;
		set &data ; *   ;
		keep &string1   ; /* for sales and price lags, we use 2 lags */
		if _n_> 1 then delete ;
	run ;
	proc transpose data= temp out= templist ;
	run ;
%mend ;

%macro list1 ;
/* we give indice to the SKU numbers in the category */ ;
		data _null_ ;
				set templist ;
				i= _n_ ;			 
				call symput('sku_for_modelling'||strip(i),_name_);
		run ;
/* then we need to know how many sku's in total, by quoting the macro ;*/
%mend ;

%macro construct_string1 (n)  ;			 
		 data temp_&n ;
				set temp0 ;
					%do i= 1 %to &nobs ;
						%let xx= &&sku_for_modelling&i ;
						%put &xx ;
						&xx._lag1= lag(&xx) ;
						&xx._lag2= lag2(&xx) ;
						%put &nobs ;
					%end ;	
		 run ;
%mend ;
%macro construct_string2 (n)  ;			 
		 data temp_&n ;
				set temp0 ;
					%do i= 1 %to &nobs ;
						%let xx= &&sku_for_modelling&i ;
						%put &xx ;
						&xx._lag1= lag(&xx) ;
						&xx._lag2= lag2(&xx) ;
						%put &nobs ;
					%end ;	
		 run ;
%mend ;


%macro create_lag_general (category) ;
	%let string1 = %str(logs_1 - logs_3000 logp_1 - logp_3000 ) ;
		%extract_var_name(data2.Data_groc_&category) ; %list1 ; %obsnvars(templist) ; %construct_string2(1) ;	
	%let string1 = %str(f_1 - f_3000 d_1 - d_3000 ) ;
		%extract_var_name(data2.Data_groc_&category) ; %list1 ; %obsnvars(templist) ; %construct_string1(2) ;	
 	data reserve_pr ;
		set data2.Data_groc_&category ;
		keep pr_1 - pr_3000 ;
	run ;

	data data3.Data_groc_&category ;
		merge temp_1 temp_2 reserve_pr ;
		week= _n_ ;
	run ;
%mend ;

 

%create_lag_general (	Paptowl	) ;
%create_lag_general (	beer	) ;
%create_lag_general (	carbbev	) ;
%create_lag_general (	blades	) ;
%create_lag_general (	cigets	) ;
%create_lag_general (	coffee	) ;
%create_lag_general (	coldcer	) ;
%create_lag_general (	deod	) ;
*%create_lag_general (	diapers	) ;
%create_lag_general (	factiss	) ;
%create_lag_general (	fzdinent	) ;
%create_lag_general (	fzpizza	) ;
%create_lag_general (	hhclean	) ;
%create_lag_general (	hotdog	) ;
%create_lag_general (	laundet	) ;
%create_lag_general (	margbutr	) ;
%create_lag_general (	mayo	) ;
%create_lag_general (	milk	) ;
%create_lag_general (	mustketc	) ;
%create_lag_general (	peanbutr	) ;
%create_lag_general (	photo	) ;
%create_lag_general (	razors	) ;
%create_lag_general (	saltsnck	) ;
%create_lag_general (	shamp	) ;
%create_lag_general (	soup	) ;
%create_lag_general (	spagsauc	) ;
%create_lag_general (	sugarsub	) ;
%create_lag_general (	toitisu	) ;
%create_lag_general (	toothbr	) ;
%create_lag_general (	toothpa	) ;
%create_lag_general (	yogurt	) ;
