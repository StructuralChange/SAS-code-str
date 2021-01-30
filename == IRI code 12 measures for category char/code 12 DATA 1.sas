options nosource nonotes ;


 /* this macro calculate the stats for each SKU for all the categories */


 
ods listing close ;
/* pre-loaded macros */ 
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;
%let focus_period= 200 ;


/* step 1: the following macros are used to automatically load the skunumbers of the SKU's for a specific category */ 
/* step 1.1: to extract the skunumber of the SKU's for a specific category. e.g., to extract the variable names of the dataset for that category */
%macro extract_var_name (data) ;
	data temp ;
		set &data ;  
		keep units_1 - units_3000 ;
		if _n_> 1 then delete ;
	run ;
	proc transpose data= temp out= templist ;
	run ;


	data test_sales ;
		set &data ;  
		t=_n_ ;
		if _n_>&focus_period then delete ; /* our evaluation focus on week 1- week &focus_period */
		keep units_1 - units_3000 t ; 
	run ;
	data test_price ;
		set &data ;  
		t=_n_ ;
		if _n_>&focus_period then delete ;
		keep price_1 - price_3000 t ; 
	run ;
	data test_f ;
		set &data ;  
		t=_n_ ;
		if _n_>&focus_period then delete ;
		keep f_1 - f_3000 t ; 
	run ;
	data test_d ;
		set &data ;  
		t=_n_ ;
		if _n_>&focus_period then delete ;
		keep d_1 - d_3000 t ; 
	run ;
%mend ;

/* step 1.2: put the variable names (i.e., skunumbers) into global variables */
%macro extractskunumber ;
	data _null_ ;
		set templist ;
		i= _n_ ;
		sku_list= compress(_name_,"units_");
		sku_list_numeric= input(sku_list, 12.) ;
		call symput('sku_for_candidate_modelling'||strip(i),sku_list_numeric);
	run ;	
%mend ;
/* %put &sku_for_candidate_modelling1 ; */
/* step 2.1: calculate the stats for the sales of each SKU */
%macro run_candidate_model_s   ;
	%do cc= 1 %to &nobs ;
		%let skunumber= &&sku_for_candidate_modelling&cc ;
		/* %let skunumber= 839 ;*/
			proc means data= test_sales noprint ;
				var units_&skunumber ;
				output out= stat_each_sku_&cc mean= sales_mean std= sales_std SKEWNESS=sales_SKEWNESS range= sales_range KURTOSIS=sales_KURTOSIS ;
			run ;
			data stat_each_sku_&cc ;
				set stat_each_sku_&cc ;
				drop _type_ _freq_ ;
				skunumber= &skunumber ;
				category= "&category" ;
			run ;
	 
	%end ;
	data stat_each_sku_&category._all ;
		set stat_each_sku_1 ;
	run ;
	%do tt= 2 %to &nobs ;
			data stat_each_sku_&category._all ;
				set stat_each_sku_&category._all 
					stat_each_sku_&tt ;
			run ;	
		proc delete data= stat_each_sku_&tt ;  
		run ; 
	%end ;
	 proc delete data= stat_each_sku_1 ;  
		run ;
	data sales_each_sku_&category._all ;
		set stat_each_sku_&category._all ;
		sales_c_v=sales_std/sales_mean ;
	run ;
%mend ;
/* step 2.1: calculate the stats for the price of each SKU */
%macro run_candidate_model_pr   ;
	%do cc= 1 %to &nobs ;
		%let skunumber= &&sku_for_candidate_modelling&cc ;
		/* %let skunumber= 839 ;*/
			proc means data= test_price noprint ;
				var price_&skunumber ;
				output out= stat_each_sku_&cc mean= price_mean std= price_std SKEWNESS=price_SKEWNESS range= price_range KURTOSIS=price_KURTOSIS ;
			run ;
			data stat_each_sku_&cc ;
				set stat_each_sku_&cc ;
				drop _type_ _freq_ ;
				skunumber= &skunumber ;
				category= "&category" ;
			run ;
 
	%end ;
	data stat_each_sku_&category._all ;
		set stat_each_sku_1 ;
	run ;
	%do tt= 2 %to &nobs ;
			data stat_each_sku_&category._all ;
				set stat_each_sku_&category._all 
					stat_each_sku_&tt ;
			run ;	 
		  proc delete data= stat_each_sku_&tt ;  
		run ;
	%end ;
	 proc delete data= stat_each_sku_1 ;  
		run ;
	data price_each_sku_&category._all ;
		set stat_each_sku_&category._all ;
		price_c_v=price_std/price_mean ;
	run ;
%mend ;
/* step 2.1: calculate the stats for the feature of each SKU */
%macro run_candidate_model_f   ;
	%do cc= 1 %to &nobs ;
		%let skunumber= &&sku_for_candidate_modelling&cc ;
		/* %let skunumber= 839 ;*/
			proc means data= test_f noprint ;
				var f_&skunumber ;
				output out= stat_each_sku_&cc mean= f_freq   ;
			run ;
			data stat_each_sku_&cc ;
				set stat_each_sku_&cc ;
				drop _type_ _freq_ ;
				skunumber= &skunumber ;
				category= "&category" ;
			run ;
	 
	%end ;
	data stat_each_sku_&category._all ;
		set stat_each_sku_1 ;
	run ;
	%do tt= 2 %to &nobs ;
			data stat_each_sku_&category._all ;
				set stat_each_sku_&category._all 
					stat_each_sku_&tt ;
			run ;	
		proc delete data= stat_each_sku_&tt ;  
		run ; 
	%end ;
	 proc delete data= stat_each_sku_1 ;  
		run ;
	data f_each_sku_&category._all ;
		set stat_each_sku_&category._all ;
		 
	run ;
%mend ;
/* step 2.1: calculate the stats for the display of each SKU */
%macro run_candidate_model_d   ;
	%do cc= 1 %to &nobs ;
		%let skunumber= &&sku_for_candidate_modelling&cc ;
		/* %let skunumber= 839 ;*/
			proc means data= test_d noprint ;
				var d_&skunumber ;
				output out= stat_each_sku_&cc mean= d_freq   ;
			run ;
			data stat_each_sku_&cc ;
				set stat_each_sku_&cc ;
				drop _type_ _freq_ ;
				skunumber= &skunumber ;
				category= "&category" ;
			run ;
		
	%end ;
	data stat_each_sku_&category._all ;
		set stat_each_sku_1 ;
	run ;
	%do tt= 2 %to &nobs ;
			data stat_each_sku_&category._all ;
				set stat_each_sku_&category._all 
					stat_each_sku_&tt ;
			run ;	
		proc delete data= stat_each_sku_&tt ;  
		run ; 
	%end ;
	 proc delete data= stat_each_sku_1 ;  
		run ;
	data d_each_sku_&category._all ;
		set stat_each_sku_&category._all ;
		 
	run ;
%mend ; 
/* step 2.1: calculate the char statistics for each SKU */
%macro run_candidate_model_outliers   ;
	%do cc= 1 %to &nobs ;
		%let skunumber= &&sku_for_candidate_modelling&cc ;
		/* the proportion of outliers  ; %let skunumber 125 ; */

			data t1   ;
				set Test_sales ;
				zt= units_&skunumber-lag(units_&skunumber) ;
				keep zt  units_&skunumber ;
			run ;
			proc univariate data= t1 noprint;
			  var zt ;
			  output out=xxxxx  q1=q1 q3=q3      ;
			run;
			data t2 ;
				merge t1 xxxxx ;
				retain temp3 temp1  ;
				if _n_=1 then temp3= q3 ;
					else q3= temp3 ;
				if _n_=1 then temp1= q1 ;
					else q1= temp1 ;
				z= q3-q1 ;
				if q1-1.5*z<zt<q3+1.5*z  then outliers=0 ;
					else outliers= 1 ;
				 
			run ;
			proc means data= t2 noprint ;
				var outliers ;
				output out= t3 mean= outliers_pct ;
			run ;
			data stat_each_sku_&cc ;
				set t3 ;
				drop _type_ _freq_ ;
				skunumber= &skunumber ;
				category= "&category" ;
			run ;

  
			/* randomness  ;*/
			data t2_2 ;
				set t2 ;
				if outliers= 0 ;
				keep units_&skunumber   ;
			run ;
			data t2_2 ;
				set t2_2 ;
					t=_n_ ;
					y1= lag(units_&skunumber) ;
					y2=lag2(units_&skunumber ) ;
					y3=lag3(units_&skunumber) ;
			run ;
			proc reg data= t2_2       ;
				model units_&skunumber = y1 y2 y3 t ;
				  ods output FitStatistics = fitstats;
			run ;
			quit ;

			data randomness (rename= (nvalue2= randomness)) ;
				set fitstats ;
				if _n_=1 ;
				keep nValue2 ;
			run ;


			data randomness_&cc ;
				set randomness ;
				skunumber= &skunumber ;
				category= "&category" ;
			run ;

			/* linear trend  ;*/
			proc corr data= t2_2 out= x1 noprint  ;
				var units_&skunumber t ;
				
			run ;

			data trend (rename= (abs1= abs_linear_trend)) ;
				set x1 ;
				if _name_ ="t" ;
				abs1= abs(units_&skunumber) ;
				keep abs1 ;
			run ;
			data trend_&cc ;
				set trend ;
				skunumber= &skunumber ;
				category= "&category" ;
			run ;

 
 

	%end ;
	data stat_each_sku_&category._all ;
		set stat_each_sku_1 ;
	run ;

	data randomness_&category._all ;
		set randomness_1 ;
	data trend_&category._all ;
		set trend_1 ;
	run ;






	%do tt= 2 %to &nobs ;
			data stat_each_sku_&category._all ;
				set stat_each_sku_&category._all 
					stat_each_sku_&tt ;
			run ;	
			proc delete data= stat_each_sku_&tt ;  
			run ; 


			data randomness_&category._all ;
				set randomness_&category._all 
					randomness_&tt ;
			run ;

	 

			data trend_&category._all ;
				set trend_&category._all 
					trend_&tt ;
			run ;
			proc delete data= randomness_&tt ;  
			run ; 
			proc delete data= trend_&tt ;  
			run ; 





	%end ;
	 proc delete data= stat_each_sku_1 ;  
		run ;
	data outlier_each_sku_&category._all ;
		set stat_each_sku_&category._all ;
		 
	run ;
 
	 proc delete data= randomness_1 ;  
	 proc delete data= trend_1 ;  
		run ;





%mend ; 
/* concatenate*/
%macro dooall0 (category) ;
		%extract_var_name(data2.Data_groc_&category) ;  
		%extractskunumber ; 
		%obsnvars(templist) ; 
		%run_candidate_model_s ; 
		%run_candidate_model_pr ; 
		%run_candidate_model_f ;
		%run_candidate_model_d ;
		%run_candidate_model_outliers ;
	proc sort data= price_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= sales_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= d_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= f_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= outlier_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= randomness_&category._all ;
		by category skunumber ;
	proc sort data= trend_&category._all ;
		by category skunumber ;
	run ;
 
	data n_of_sku_allcat ;
		n_of_sku= &nobs ;
		category="&category" ;
		output ;
	run ;
	proc sort data= n_of_sku_allcat ;
		by category   ;
	run ;

		data stat_all_&category ;
			merge price_each_sku_&category._all  
				  sales_each_sku_&category._all
				  d_each_sku_&category._all
				  f_each_sku_&category._all  
				  outlier_each_sku_&category._all
				  randomness_&category._all 
				  trend_&category._all 
				    ;  
			by category skunumber ;
		run ;
 

		data stat_all_allcat ;
			set stat_all_&category   ;
			by category ;
		run ;
 %mend ;
 %macro dooall (category) ;
 	/* %let category= saltsnck ;*/
		%extract_var_name(data2.Data_groc_&category) ;  
		%extractskunumber ; 
		%obsnvars(templist) ; 
		%run_candidate_model_s ; 
		%run_candidate_model_pr ; 
		%run_candidate_model_f ;
		%run_candidate_model_d ;
		%run_candidate_model_outliers ;
	proc sort data= price_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= sales_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= d_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= f_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= outlier_each_sku_&category._all ;
		by category skunumber ;
	proc sort data= randomness_&category._all ;
		by category skunumber ;
	proc sort data= trend_&category._all ;
		by category skunumber ;
	run ;


	data n_of_sku ;
		n_of_sku= &nobs ;
		category="&category" ;
		output ;
	run ;
	data n_of_sku_allcat ;
		set n_of_sku_allcat n_of_sku ;
	run ;
 

		data stat_all_&category ;
			merge price_each_sku_&category._all  
				  sales_each_sku_&category._all
				  d_each_sku_&category._all
				  f_each_sku_&category._all  
				  outlier_each_sku_&category._all 
				   randomness_&category._all
				   trend_&category._all 
				    ; 
			by category skunumber ;
		run ;

 
		data stat_all_allcat ;
			set stat_all_allcat stat_all_&category  ;
		run ;

 %mend ;
	*%dooall(Paptowl) ;	
	%dooall0(saltsnck) ;
	%dooall(beer	) ;
	%dooall(carbbev	) ;
	%dooall(blades	) ;
	%dooall(cigets	) ;
	%dooall(coffee	) ;
	%dooall(coldcer	) ;
	%dooall(deod	);
	%dooall(factiss	) ;
	%dooall(fzdinent) ;
	%dooall(fzpizza	) ;
	%dooall(hhclean	) ;
	%dooall(hotdog	) ;
	%dooall(laundet	) ;
	%dooall(margbutr) ;
	%dooall(mayo	) ;
	%dooall(milk	) ;
	%dooall(mustketc) ;
	%dooall(peanbutr) ;
	%dooall(photo	) ;
	*%dooall(razors	) ;
	%dooall(shamp	) ;
	%dooall(soup	) ;
	%dooall(spagsauc) ;
	%dooall(sugarsub) ;
	%dooall(toitisu	) ;
	%dooall(toothbr	) ;
	%dooall(toothpa	) ;
	%dooall(yogurt	) ;   
proc sort data= N_of_sku_allcat ;
	by category ;
run ;
proc sort data= Stat_all_allcat ;
	by category skunumber ;
run ;


 data expl_cat.stat_all_allcat  ;
 
 	merge  Stat_all_allcat    N_of_sku_allcat ;
	by category ;
run ;


 data expl_cat.stat_all_allcat2  ;
 	set  expl_cat.stat_all_allcat  ;
  
	drop price_skewness 	 price_range price_kurtosis ;
run ;

 





/*
 


 
data t1 ;
	set Test_sales ;
	keep units_117 ;
run ;
proc univariate data= t1 noprint;
  var units_117;
  output out=xxxxx  q1=q1 q3=q3      ;
run;
data t2 ;
	merge t1 xxxxx ;
	retain temp3 temp1  ;
	if _n_=1 then temp3= q3 ;
		else q3= temp3 ;
	if _n_=1 then temp1= q1 ;
		else q1= temp1 ;
	z= q3-q1 ;
	if q1-1.5*z<units_117<q3+1.5*z  then outliers=0 ;
		else outliers= 1 ;
	 
run ;
proc means data= t2 noprint ;
	output out= t3 mean= outliers_pct ;
run ;


data t2_2 ;
	set t2 ;
	if outliers= 0 ;
	keep units_117   ;
run ;

 

data t2_2 ;
	set t2_2 ;
		t=_n_ ;
		y1= lag(units_117) ;
		y2=lag2(units_117 ) ;
		y3=lag3(units_117) ;
run ;
proc reg data= t2_2       ;
	model units_117 = y1 y2 y3 t ;
	  ods output FitStatistics = fitstats;
run ;
quit ;

data randomness (rename= (nvalue2= randomness)) ;
	set fitstats ;
	if _n_=1 ;
	keep nValue2 ;
run ;

proc corr data= t2_2 out= x1 noprint  ;
	var units_117 t ;
	
run ;

data trend (rename= (units_117= linear_trend)) ;
	set x1 ;
	if _name_ ="t" ;
	keep units_117 ;
run ;

*/
