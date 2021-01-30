/*
* this macro impute the data, construct dummy variables etc. ;
* having implemnted macro 2.2, we retain the variables which have more than 9x% of valid data. However, 
	we may still have sporadic missing observations ;
* this macro imputes the missing observations (e.g., e.g. units, dollars, d, and pr etc.) with previous values, 
but not reverse (i.e., if there are missing values in the first a few weeks, 
this macro will be unable to impute these observations ;
*/ 
%obsnvars(temp_all) ;

/* there are 2 types of missing values: numeric and char, and we use 2 different macros to deal with them ; */
/* 1) macro to replace numeric missing value e.g., unit etc. ;*/
%macro replace_numeric (variable) ;
	data sku_valid_all (rename= (tot=&variable._&a))  ;
		set sku_valid_all ;
				retain tot;
				if &variable._&a ^= . then tot= &variable._&a ;
				drop &variable._&a ;
	run ;
%mend ;
/* 2) macro to replace characteristic missing value e.g. feature ;*/
%macro replace_char (variable) ;
	data sku_valid_all (rename= (tot=&variable._&a))  ;
		set sku_valid_all ;
				retain tot;
				if &variable._&a ^= "" then tot= &variable._&a ;
				drop &variable._&a ;
	run ;
%mend ;

/* apply these macroes to all the variables 

	ascending order ;*/
%macro impute ;
	%do k=1 %to &nobs  ;
		%let a= &&retained_valid_sku&k ; 
		/* %put &a ;
		%let a= 143 ;

		*/
		%replace_numeric (d) ;
		%replace_numeric (pr) ;
		%replace_numeric (units) ;
		%replace_numeric (dollars) ;
		%replace_char (f) ;
	%end ;
%mend ;
%impute ;

/* apply these macroes to all the variables 

	descending order ;*/

proc sort data= Sku_valid_all ;
	by  descending week;
run ;
%impute ;

/* resort the data, by weeks */
proc sort data= Sku_valid_all ;
	by  week;
run ;
data data1.data_&channel._&category ;
	set sku_valid_all ;
run ;
 
 





