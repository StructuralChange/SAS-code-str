options nonotes nosource ;
/* data imputation ;*/

/* * this macro replace the missing data with previous value,
	then it sorts the data observations reversely based on 'week',
	- do the replacing, 
	- then sorts it back
thus this imputation macro all the missing values in the dataset using the closest value ;
the imputation procedure in macro 2.1 only imputes the missing values following valid data.

/* the target dataset is called target_category 
the value of &target_category is determined in macro 3.0.
e.g.,
%let target_category=data1.Data_groc_beer ;
/*


/* we load an external macro which extract the number of rows and columns of a table */
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;

/* step 1, extract the SKU numbers, this is done based on the unit sales variables only ;*/
	data temp ;
		set &target_category ; * data1.Data_groc_blades ;
		keep units_1 - units_3000 ;
		if _n_> 1 then delete ;
	run ;
	proc transpose data= temp out= templist ;
	run ;
	data templist ;
		set templist ;
		i= _n_ ;
		sku_list= compress(_name_,"units_");
		sku_list_numeric= input(sku_list, 12.) ;
		call symput('sku_for_modelling'||strip(i),sku_list_numeric);
	run ;
	* then we need to know how many sku's in total, by quoting the macro ;
	%obsnvars(templist) ;
	* %put &dset has &nvars variable(s) and &nobs observation(s).;
	* thus we have &nobs sku's in total, thus &sku_for_modelling1 -
		&sku_for_modelling&nobs represent the number of the &nobs sku's. ;

	/* now we need a complete index from 1114 to 1321 to identify the missing observations in &target_category.
	e.g., the whole observation of week 1122 may be missing in &target_category (so there is no missing value indications
	because the whole observation is gone. By merging a complete index into &target_category, we will be able to 
	identify the missing observations.*/
	data index ;
		do week= 1114 to 1321 ;
			output ;
		end ;
	run ;
	data temp2_0 ;
		set &target_category ; ;
	run ;
/* we merge the complete index into temp2. */
	data temp2 ;
		merge index temp2_0 ;
		by week ;
	run ;
/*  replace the missing value with previous values ; */
	%macro fix_missing_value (data,variable);
		data &data ;
			set &data ;
			%do i= 1 %to &nobs ;
				%let a= &&sku_for_modelling&i ;
				if &variable._&a=. then &variable._&a= t&i ;
					else t&i= &variable._&a ;
				retain t&i ; 
			%end ;
			drop t1- t&nobs ;
		run ;
	%mend ;

	%fix_missing_value (temp2, units);
	%fix_missing_value (temp2, price);
	%fix_missing_value (temp2, pr);
	%fix_missing_value (temp2, dollars);
	%fix_missing_value (temp2, f);
	%fix_missing_value (temp2, d);
	%fix_missing_value (temp2, logp);
	%fix_missing_value (temp2, logs);

	proc sort data=temp2 out= temp2 ;
		by descending week ;
	run ;
	%fix_missing_value (temp2, units);
	%fix_missing_value (temp2, price);
	%fix_missing_value (temp2, pr);
	%fix_missing_value (temp2, dollars);
	%fix_missing_value (temp2, f);
	%fix_missing_value (temp2, d);
	%fix_missing_value (temp2, logp);
	%fix_missing_value (temp2, logs);
 
	proc sort data=temp2 out= &target1 ;
		by week ;
	run ;
 
