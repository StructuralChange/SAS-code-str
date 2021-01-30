/* this macro select the skus with valid data and trim missing values ;
* some SKUs may have missing data. e.g., for some weeks, they have no price, no sales, no feature etc,
	we find them out by looking at if their sales data are missing
* based on 4 years ;
* step 1, we extract the unit sales ;*/

data data_store_structured_units ;
	set data_store_structured ;
	keep week units_1- units_&nobs ;
	if week< 1322 ;* week 1322 is the first week in year 5 ;
run ;


/*  
* we exam the validity of the unit sales data by calculating the proportion of the unit sales with non-missing data for each sku. ;
* there are &nobs SKU's in total in the dataset (notice that the value of &nobs is otained in macro 2.1), now the value of &nobs refers 
	to the total number of SKU's contained in Data_store_structured,
	its value may change if we run the external macro for other dataset in later steps ;

* the following macro will produce a dataset which contains the percentage of non-missing value for each variable/SKU_sales ;*/
%macro countvalid ;
data temp ;
	set data_store_structured_units ;
	%do i= 1 %to &nobs ;
	if units_&i= "" then valid_&i= 0 ;
		else valid_&i=1 ;
	%end ;
run ;
%do j= 1 %to &nobs ;
	proc means data= temp noprint mean ;
		var valid_&j ;
		output out= temp&j mean=mean ;
	data temp&j (rename= (mean= proportion_valid_&j)) ;
		set temp&j ;
		keep mean ;
	run ;
		%if &j=1 %then %do ;
			data temp_all ;
				set temp&j ;
			run ;
		%end ;
		%else %do ;
		data temp_all ;
				merge temp_all temp&j ;  
					 
		run ;
		%end ;
run ;
%end ;
proc transpose data= temp_all out= temp_all;
data temp_all ;
	set temp_all ;
run ;
%mend ;
%countvalid ;
/* we can sort this dataset ;*/
proc sort data= temp_all ;
 	by  descending col1 ;
run ;
/* and then store the sorted dataset in a permanent lib ;    */
data data1c.valid_picture_&category ; * output, showing the quality of the dataset for this category ;
	set temp_all ;
run ;
/* 
now we know the proportion of valid data for each SKU for the store ;
and we only focus on the SKU's with valid data of above a threshold, say, 9x% ;   */
/*
data temp_all1 ;
	set temp_all ;
	if col1>0.9 ; /* we only retain the skus with valid data of above 90% ;*/
run ;

/*
now we retain the SKU number of the SKU's with enough data, and put them into global variables, 
	e.g.&retained_valid_sku1  
		&retained_valid_sku7
		&retained_valid_sku9 , given 1, 7, and 9 are retained based on the 9x% threshold ;*/
data temp_all ;
	set temp_all ;
	i= _n_ ;
	retail_list= compress(_name_,"proportion_valid_");
	retail_list_numeric= input( retail_list, 12.) ;
	call symput('retained_valid_sku'||strip(i),retail_list_numeric);
run ;
 
 
/* we also need to know how many SKU's are retained, so we re-run the exteral-macro, and the dataset we 
	used as the input is now the dataset 'temp_all' ;*/
%obsnvars(temp_all) ;
 
/*  %put &dset has &nvars variable(s) and &nobs observation(s).;
* thus there are &nvars variables and &nobs observations in dataset 'temp_all' ;

* now the SKU numbers with valid data are represented by from '&retained_valid_sku1' to -  '&retained_valid_sku&nobs' ;
* e.g. %put &retained_valid_sku1 ;*/
 %macro rebuild ;
	%do k=1 %to &nobs  ;
	/* extract the data for each SKU with enough valid data ;*/
	%let a= &&retained_valid_sku&k ; 
	 	data sku&k ;
			set Data_store_structured ;
			if week< 1322 ;/* week 1322 is the first week in year 5 */ ;
			keep units_&a 
				 dollars_&a
				 f_&a
				 d_&a
				 pr_&a 
				 week ;
		run ;
		%if &k=1 %then %do ;
			data sku_valid_all ;
				set sku&k ;
			run ;
		%end ;
		%else %do ;
		data sku_valid_all ;
			merge sku&k sku_valid_all  ;
			by week ;
		run ;
		proc delete data= sku&k  ;
		run ;
		%end ;
	%end ;
%mend ;
%rebuild ;


		 
