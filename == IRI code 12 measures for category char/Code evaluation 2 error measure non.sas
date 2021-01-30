

  

/* calculate MAPE */
%macro calculate_mape ;
	%let results_lib= r_&model ;
	%do cc1 = 1 %to 1 ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					ape= ae/actual ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
					  run ;
				proc means data= temp noprint mean ;
					var ape ;  
					output out=  tt mean= mean ;
				data results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				run ;
				/*  check    


				data temp_check_h&horizon._non ;
					set temp ;
				run ;


				/*  check   */


	%end ;
	%do cc1 = 2 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					ape= ae/actual ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var ape ;  
					output out=  tt mean= mean ;
				data temp_results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				data results_&measure._&model ;
					set results_&measure._&model  temp_results_&measure._&model ;
				run ; 

				/*  check   


				data temp_check_h&horizon._non ;
					set temp_check_h&horizon._non temp ;
				run ;


				/*  check   */
	%end ;

	data results_&category._&measure._&model ;
		set results_&measure._&model ;
		length category $12.  ;category= "&category" ;
		measure= "&measure" ;
	run ;
%mend ;
/* calculate sMAPE */

%macro calculate_smape ;
	%let results_lib= r_&model ;
	%do cc1 = 1 %to 1 ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					ape= 2*ae/(actual+forecast) ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var ape ;  
					output out=  tt mean= mean ;
				data results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				run ;
	%end ;
	%do cc1 = 2 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					ape= 2*ae/(actual+forecast) ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var ape ;  
					output out=  tt mean= mean ;
				data temp_results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				data results_&measure._&model ;
					set results_&measure._&model  temp_results_&measure._&model ;
				run ; 
	%end ;

	data results_&category._&measure._&model ;
		set results_&measure._&model ;
		length category $12.  ;category= "&category" ;
		measure= "&measure" ;
	run ;
%mend ;
 

/* calculate MAE */

%macro calculate_mae  ;
	%let results_lib= r_&model ;
	%do cc1 = 1 %to 1 ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					  ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					  if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var ae ;  
					output out=  tt mean= mean ;
				data results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				run ;
	%end ;
	%do cc1 = 2 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					 ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					 if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var ae ;  
					output out=  tt mean= mean ;
				data temp_results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				data results_&measure._&model ;
					set results_&measure._&model  temp_results_&measure._&model ;
				run ; 
	%end ;

	data results_&category._&measure._&model ;
		set results_&measure._&model ;
		length category $12.  ;category= "&category" ;
		measure= "&measure" ;
	run ;
%mend ;
 



/* calculate MASE */

%macro calculate_mase ;
	%let results_lib= r_&model ;
	%do cc1 = 1 %to 1 ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					  ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					 if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var q ;  
					output out=  tt mean= mean ;
				data results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				run ;
	%end ;
	%do cc1 = 2 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					 ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var q ;  
					output out=  tt mean= mean ;
				data temp_results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				data results_&measure._&model ;
					set results_&measure._&model  temp_results_&measure._&model ;
				run ; 
	%end ;

	data results_&category._&measure._&model ;
		set results_&measure._&model ;
		length category $12.  ;category= "&category" ;
		measure= "&measure" ;
	run ;
%mend ;
 

 /* calculate MPE */

%macro calculate_mpe ;
	%let results_lib= r_&model ;
	%do cc1 = 1 %to 1 ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					pe= (actual-forecast)/actual ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var pe ;  
					output out=  tt mean= mean ;
				data results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				run ;
	%end ;
	%do cc1 = 2 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					pe= (actual-forecast)/actual ;/* if promoall_&sku = 0 ;   non-promo*/ ;
					if promoall_&skunumber = 0 ;  if horizon> &horizon then delete ;
				proc means data= temp noprint mean ;
					var pe ;  
					output out=  tt mean= mean ;
				data temp_results_&measure._&model (rename = (mean=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					keep sku mean ;
				data results_&measure._&model ;
					set results_&measure._&model  temp_results_&measure._&model ;
				run ; 
	%end ;

	data results_&category._&measure._&model ;
		set results_&measure._&model ;
		length category $12.  ;category= "&category" ;
		measure= "&measure" ;
	run ;
%mend ;
 

 
 

/* calculate RMSE */
 

%macro calculate_RMSE  ;
	%let results_lib= r_&model ;
	%do cc1 = 1 %to 1 ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					  ;  if promoall_&skunumber = 0 ;  */ non-promo*/ ;
					  if horizon> &horizon then delete ;
					  se=ae*ae ;
				proc means data= temp noprint mean ;
					var se ;  
					output out=  tt mean= mean ;
				data results_&measure._&model (rename = (mean_sqrt=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					mean_sqrt= sqrt(mean) ;
					keep sku mean_sqrt ;
				run ;
	%end ;
	%do cc1 = 2 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					  ;  if promoall_&skunumber = 0 ;  */ non-promo*/ ;
					 if horizon> &horizon then delete ;
					 se=ae*ae ;
				proc means data= temp noprint mean ;
					var se ;  
					output out=  tt mean= mean ;
				data temp_results_&measure._&model (rename = (mean_sqrt=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					mean_sqrt= sqrt(mean) ;
					keep sku mean_sqrt ;
				data results_&measure._&model ;
					set results_&measure._&model  temp_results_&measure._&model ;
				run ; 
	%end ;

	data results_&category._&measure._&model ;
		set results_&measure._&model ;
		length category $12.  ;category= "&category" ;
		measure= "&measure" ;
	run ;
%mend ;
 
/* calculate MSE */
 

%macro calculate_MSE  ;
	%let results_lib= r_&model ;
	%do cc1 = 1 %to 1 ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					 ;  if promoall_&skunumber = 0 ;  */ non-promo*/ ;
					  if horizon> &horizon then delete ;
					  se=ae*ae ;
				proc means data= temp noprint mean ;
					var se ;  
					output out=  tt mean= mean ;
				data results_&measure._&model (rename = (mean_sq=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					mean_sq= mean ;
					keep sku mean_sq ;
				run ;
	%end ;
	%do cc1 = 2 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
				data temp ;
					set &results_lib..Cat_&category._sku&skunumber ;
					;  if promoall_&skunumber = 0 ;  */ non-promo*/ ;
					 if horizon> &horizon then delete ;
					 se=ae*ae ;
				proc means data= temp noprint mean ;
					var se ;  
					output out=  tt mean= mean ;
				data temp_results_&measure._&model (rename = (mean_sq=  &model) ) ;
					set tt ;
					sku= &skunumber ;
					mean_sq= mean ;
					keep sku mean_sq ;
				data results_&measure._&model ;
					set results_&measure._&model  temp_results_&measure._&model ;
				run ; 
	%end ;

	data results_&category._&measure._&model ;
		set results_&measure._&model ;
		length category $12.  ;category= "&category" ;
		measure= "&measure" ;
	run ;
%mend ;
 
