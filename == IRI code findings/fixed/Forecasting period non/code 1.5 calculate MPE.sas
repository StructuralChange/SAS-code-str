*
this macro rank the models with respect to various measures ;
options nonotes nosource  ;
* first we input the library where the results data are stored ;

%macro calculate1_initial (j) ;

 



	data temp0 ;
		set &lib..cat_&category._&j ;
		err= actual-forecast ;
		&limit_horizon ;if promoall_&j = 0 ;/* non-promoted */ ;
	run ;
	proc means data= temp0 sum noprint ;
		var err ;
		output out= temp_err sum= sum_err ;
	run ;
	proc means data= temp0 sum noprint ;
		var actual ;
		output out= temp_actual sum= sum_actual ;
	run ;

	data temp_mpe ;
		merge temp_actual temp_err ;
		mpe= sum_err/sum_actual ;
	run ;

	data rank_all.model_&model._&category._&measure    ;
		set temp_mpe ;
		sku= &j ;
		format category $20. ;
		category= "&category" ;
		drop _type_ _freq_ sum_actual sum_err ;
	run ;






%mend ;
%macro calculate1  (j) ;

	data temp0 ;
		set &lib..cat_&category._&j ;
		err= actual-forecast ;
		&limit_horizon ;if promoall_&j = 0 ;/* non-promoted */ ;
	run ;
	proc means data= temp0 sum noprint ;
		var err ;
		output out= temp_err sum= sum_err ;
	run ;
	proc means data= temp0 sum noprint ;
		var actual ;
		output out= temp_actual sum= sum_actual ;
	run ;

	data temp_mpe ;
		merge temp_actual temp_err ;
		mpe= sum_err/sum_actual ;
	run ;


	data temp2   ;
		set temp_mpe ;
		sku= &j ;
		format category $20. ;
		category= "&category" ;
		drop _type_ _freq_ sum_actual sum_err ;
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

 


 %include ' Q:\= IRI data research\== IRI code findings\Forecasting period non\code SKU list.sas' ;

