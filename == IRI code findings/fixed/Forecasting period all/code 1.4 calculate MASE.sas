*
this macro rank the models with respect to various measures ;
options nonotes nosource  ;
* first we input the library where the results data are stored ;

%macro calculate1_initial (j) ;

 	data temp0 ;
		set &lib..cat_&category._&j ;
		&limit_horizon ;
		 
	proc means data= temp0 mean noprint ;
		var q ;
		output out= temp1 mean=mean ;
	run ;

	data rank_all.model_&model._&category._&measure  (rename= (mean=&measure )) ;
		set temp1 ;
		sku= &j ;
		format category $20. ;
		category= "&category" ;
		drop _type_ _freq_ ;
	run ;
%mend ;
%macro calculate1  (j) ;

	data temp0 ;
		set &lib..cat_&category._&j ;
		&limit_horizon ;

	proc means data= temp0 mean noprint ;
		var q ;
		output out= temp1 mean=mean ;
	run ;

	data temp2 (rename= (mean=&measure)) ;
		set temp1 ;
		sku= &j ;
		format category $20. ;
		category= "&category" ;
		drop _type_ _freq_ ;
	run ;

	data rank_all.model_&model._&category._&measure  ;
		set rank_all.model_&model._&category._&measure temp2 ;
	run ;
%mend ;

%macro organizing0 ;
	proc means data= rank_all.model_&model._&category._&measure mean noprint ;
		var &measure ;
		output out= temp3 mean=mean ;
	run ;

	data rank_all.model_&model._&category._result (rename = (mean= &measure)) ;
		set temp3 ;
		format category $20. ;
		category= "&category" ;
		model= "&model" ;
		drop _type_ _freq_ ;
	run ;
	/*proc delete data= rank_all.model_&model._&category ;*/
	run ;
%mend ;

 

 %include ' Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code SKU list.sas' ;

 
