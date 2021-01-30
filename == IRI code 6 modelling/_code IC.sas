 

options nosource nonotes  ;
 

 
* start the Macro, define modelling range ;
%macro rolladl (dataset, firstobs, length, lead) ;  
	%do roll = 1 %to &end_of_rolling %by &jump    ;
		%let start= %eval(&firstobs+&roll-1) ;
		%let end= %eval(&start+&length-1) ; 
		/*%put &start &end &roll ;

		%let firstobs= 1 ;
		%let roll= 1 ;
		%let length= 160 ;
		%let start= %eval(&firstobs+&roll-1) ;
		%let end= %eval(&start+&length-1) ; 
		%let dataset= data4.Data_groc_&category ;
		%let lead= 12 ;
 
		*/

	 
 
 

/* step 1:	prepare dataset "dataset_temp_sales_excluded" which exclude the future sales of the target sku */
	data dataset_temp1 ; 
		set &dataset ;
		drop logs_&skunumber ;
	data dataset_temp2 ; 
		set &dataset (obs= &end) ;
		keep week logs_&skunumber ;
	proc sort data= dataset_temp1 ;
		by week ;
	proc sort data= dataset_temp2 ;
		by week ;

	data dataset_temp_sales_excluded ;
		merge dataset_temp1 dataset_temp2 ;
		by week ;
	run ;
/* extract the variable list */
	%include "Q:\= IRI data research\== IRI code 6 modelling\&string..sas" ;
	%let core_string= &&catstring_&skunumber;

/* 	%put &core_string ;  */




/* step 2:	The market response model */
ods listing close ;
proc model data= dataset_temp_sales_excluded ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
	logs_&skunumber= int  +w1* week   &core_string
 
			; /* NOTICE, here we need to include potential '+' in the core_string variable, 
				just in case the core_string does not contain any variable (so we remove the + symbol) */
	id week ; 
    fit logs_&skunumber 
 
            / hccme=1      outresid  outall
							  out=model_ic 
							  outest=parms  

chow= (				5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23		
24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40	41	42	43	44	45	46	47	48
49	50	51	52	53	54	55	56	57	58	59	60	61	62	63	64	65	66	67	68	69	70	71	72	73
74	75	76	77	78	79	80	81	82	83	84	85	86	87	88	89	90	91	92	93	94	95	96	97	98
99	100	101	102	103	104	105	106	107	108	109	110	111	112	113	114	115	116	117 118	119	120	121	122	123	
124	125	126	127	128	129	130	131	132	133	134	135	136	137	138	139	140	141	142	143	144	145	146	147	148	
149	150	151	152	153	154	155	156	 	)			 ; 

  /* we leave 5% of the sample untested, e.g., we conduct the Chow test for the central 95% of observations in the sample 
	e.g., we leave 5%*120= 7 observations, so we conduct the test from obs 4 to obs 156 */


 
	  		range week= %eval(&start+2) to &end ;

ods  output parameterestimates= pvalues residsummary= stat Chowtest= Chowtest;

      solve logs_&skunumber / data= dataset_temp_sales_excluded 
							  estdata= parms 
							  out=forecast forecast;
			
			%let forecast_end= %eval(&end+&lead) ;
	 		range week= %eval(&start+2) to &forecast_end ;
 
   	run;

ods listing ;
 


/* make a judgment based on the Chow test result */
data chowtest ;
	set chowtest ;
	keep probf breakpoint ;	
proc transpose data= chowtest out= chowtest ;
	var	probf ;
	id breakpoint ;
data chowtest ;
	set chowtest ;
	tpro=1 ; run ;
data chowtest ;
	set chowtest ;
	%global chow ;
	%do k=5 %to 156 ; /* we focus on the central 95% of observations */
		if _&k="" then _&k=1 ;
		if _&k<0.001 then t&k=0 ;
			else t&k=1 ;
		tpro= tpro*t&k ;
		drop t&k ;
	%end ;
	call symput("chow",tpro);
run ;  

%put   &chow ;

/* %let chow= 0 ; */
%if &chow >0 %then %normalrest ;
%if &chow =0 %then %rollic ;



%end ;

%mend ;



%macro normalrest ;
/* if there is no structural break within the estimation sample, we can direct use the forecast results in the main macro. */
/* step 2.1:	The P-values stored in "Pvalues" */
	data Pvalues ; 
		set pvalues ; 
		keep parameter probt ; 
	run ;
	proc transpose data= Pvalues out= Pvalues ;
		id parameter ; 
		var probt ;
	data Pvalues ; 
		set Pvalues ; 
		drop _NAME_ ; 
		start= &roll ; 
	run ;

/* step 2.2:	* The coefficients are stored in "Parms" */
	data parms ;
		set parms ;
		start= &roll ;
	run ;
/* step 2.3:	The post-sample forecasts are in "forecast" */
	data forecast ;
		set forecast (rename=(logs_&skunumber= forecast)) ;
		if week>&end ;
		keep forecast week ;
	run ;
 
 


/* log bias correction */
%include "Q:\= IRI data research\== IRI code 7 organizing results arregation bias correction\code 7.1_half MSE correction IC.sas" ;
 
	
	

/* step 3: calculate the MAE for the no-change naive model, so that we can calculate MASE afterwards ; */
/* step 3.1: product the dataset with absolute error for the no-change model */
	data dataset0 ;
		set &dataset ;
		if f_&skunumber+d_&skunumber <> 0 then promoall_&skunumber=1 ;
			else promoall_&skunumber= 0 ;
		logs_&skunumber= exp(logs_&skunumber) ; /* we have detected no slow movers so we do not add 1 to the original value */
		keep week logs_&skunumber f_&skunumber d_&skunumber promoall_&skunumber ;
	run ;

	data actual_in  (rename=(logs_&skunumber= actual)) ;
		set dataset0  ;
		if &start-1< week< &start+&length ;
		keep week logs_&skunumber ;
	data actual_in ;
		set actual_in ;
		lag= lag(actual) ;
		naive_ab_error= abs(actual-lag) ;
	data actual_in ;
		set actual_in ;
		if _N_=1 then delete ;
	run ;
/* step 3.2: take an average of the absolute errors by the no-change naive model */
	proc means data= actual_in noprint ;
		var naive_ab_error ;
		output out= naive_mae ;
	run ;
	data naive_mae ;
		set naive_mae ;
		keep naive_ab_error week ;
		if _stat_= "MEAN" ;
		week= %eval(&start+&length) ;
	run ;

/* to calcualte scaled MSE, we need the sum of actual values */
	proc means data= actual_in noprint ;
		var actual ;
		output out= actual1 ;
	run ;
	data actual1_sum ;
		set actual1 ;
		keep actual week ;
		if _stat_= "MEAN" ;
		week= %eval(&start+&length) ;
	run ;

	data _null_ ;
		set actual1_sum ;
		i= _n_ ;
		 
		actual_sum= input(actual, 12.) ;
		call symput('actual_sum',actual_sum);
	run ;	

/* step 3.4:	we construct the dataset containing the actual/forecast values for the out-of-sample period */
	data actual_out  (rename=(logs_&skunumber=actual));
		set dataset0 ;
		if &start+&length-1<week<&start+&length+&lead ;
		keep week logs_&skunumber    promoall_&skunumber ;
	data comparison_out ;  
		merge actual_out forecast_level ;
		by week ;
		ae=abs(actual-forecast) ;
		start=&roll ;
		keep start week ae   actual forecast   promoall_&skunumber ;
	run ;

/* step 3.5:	we calculate the values for "q" for MASE for the out-of-sample dataset */
	data comparison_out ;
		merge comparison_out naive_mae ;
		by week ;
	data comparison_out ;
		set comparison_out ;
			horizon= week- &end ;
			retain d2 ;
			if week= %eval(&start+&length) then d2= naive_ab_error ;
			keep start q ae week   actual forecast   promoall_&skunumber horizon ;
			q= ae/d2 ;
		start= &roll ;
	run ;

/* step 3.6: we add the promotion information to the out-of-sample dataset */
	data info_promoall ;
		set &dataset ;
		if f_&skunumber+d_&skunumber <> 0 then promoall_&skunumber=1 ;
			else promoall_&skunumber= 0 ;
		if &end < week< %eval(&end+ &lead +1) ;
		keep promoall_&skunumber week  ;
	run ;

	data comparison_out ;
		merge comparison_out info_promoall ;
		actual_sum= &actual_sum ;
		by week ;
	run ;




/* step 4: append rolling results */
 

 	proc append base= &output_lib..cat_&category._sku&skunumber data= comparison_out 
; run ;   
	/*proc append base= &output_lib..pvalues_cat_&category._&start._sku&skunumber data= pvalues ; run ;*/
	/*proc append base= &output_lib..parms_cat_&category._&start._sku&skunumber data= parms ; run ;*/

	run ;


 
	proc delete data= Actual_in ;
	proc delete data= Actual_out ;
	proc delete data= Comparison_out ;
	proc delete data= Dataset0 ;
	proc delete data= Dataset_temp1 ;
	proc delete data= Dataset_temp2 ;
	proc delete data= Dataset_temp_sales_excluded ;
	proc delete data= Forecast ;
	proc delete data= Forecast1 ;
	proc delete data= Forecast_level ;
	proc delete data= Info_promoall ;
	proc delete data= Log_bias_correction ;
	proc delete data= Naive_mae ;
	proc delete data= Parms ;
	proc delete data= Pvalues ;
	proc delete data= Stat ;
	proc delete data= Temp_&skunumber ;
  

	run ;
 
%mend ;




************************************ the IC procedure ************************************* ;
%macro rollic ;
/* if there is structural break within the estimation sample, we need to combine forecasts with different estimation windows */

  
 

/* intercept correction */
	data interceptcorrection ; 
		set model_ic ; 
		if %eval(&start+&full_window - &ic_obs )<week < %eval(&end+1) ; /* The windows is 160 nobs, and we retain the last 10 observations for the IC adjustment */
		if _TYPE_= "RESIDUAL" ; 
		keep logs_&skunumber ; 
	proc means data= interceptcorrection mean noprint ; 
		var logs_&skunumber  ; 
		output out= average_ic mean=mean ;
	data average_ic ; 
		set average_ic ; 
		call symput("ic",mean); 
	run ;		
 
	data forecast ;
		set forecast (rename=(logs_&skunumber = forecast)) ;
		if week>&end ;
		ic=&ic ;
		chow=&chow ;
		if chow=0 then forecast=forecast+ ic ; * if there are s.b. (&chow=0) then implement I.C. ; ;
		keep forecast week ;
	run ;




 
/* step 2.1:	The P-values stored in "Pvalues" */
	data Pvalues ; 
		set pvalues ; 
		keep parameter probt ; 
	run ;
	proc transpose data= Pvalues out= Pvalues ;
		id parameter ; 
		var probt ;
	data Pvalues ; 
		set Pvalues ; 
		drop _NAME_ ; 
		start= &roll ; 
	run ;

/* step 2.2:	* The coefficients are stored in "Parms" */
	data parms ;
		set parms ;
		start= &roll ;
	run ;
 

/* log bias correction */
%include "Q:\= IRI data research\== IRI code 7 organizing results arregation bias correction\code 7.1_half MSE correction IC.sas" ;
 
	
/* step 3: calculate the MAE for the no-change naive model, so that we can calculate MASE afterwards ; */
/* step 3.1: product the dataset with absolute error for the no-change model */
	data dataset0 ;
		set &dataset ;
		if f_&skunumber+d_&skunumber <> 0 then promoall_&skunumber=1 ;
			else promoall_&skunumber= 0 ;
		logs_&skunumber= exp(logs_&skunumber) ; /* we have detected no slow movers so we do not add 1 to the original value */
		keep week logs_&skunumber f_&skunumber d_&skunumber promoall_&skunumber ;
	run ;

	data actual_in  (rename=(logs_&skunumber= actual)) ;
		set dataset0  ;
		if &start-1< week< &start+&length ;
		keep week logs_&skunumber ;
	data actual_in ;
		set actual_in ;
		lag= lag(actual) ;
		naive_ab_error= abs(actual-lag) ;
	data actual_in ;
		set actual_in ;
		if _N_=1 then delete ;
	run ;
/* step 3.2: take an average of the absolute errors by the no-change naive model */
	proc means data= actual_in noprint ;
		var naive_ab_error ;
		output out= naive_mae ;
	run ;
	data naive_mae ;
		set naive_mae ;
		keep naive_ab_error week ;
		if _stat_= "MEAN" ;
		week= %eval(&start+&length) ;
	run ;
/* to calcualte scaled MSE, we need the sum of actual values */
	proc means data= actual_in noprint ;
		var actual ;
		output out= actual1 ;
	run ;
	data actual1_sum ;
		set actual1 ;
		keep actual week ;
		if _stat_= "MEAN" ;
		week= %eval(&start+&length) ;
	run ;

	data _null_ ;
		set actual1_sum ;
		i= _n_ ;
		 
		actual_sum= input(actual, 12.) ;
		call symput('actual_sum',actual_sum);
	run ;	

/* step 3.4:	we construct the dataset containing the actual/forecast values for the out-of-sample period */
	data actual_out  (rename=(logs_&skunumber=actual));
		set dataset0 ;
		if &start+&length-1<week<&start+&length+&lead ;
		keep week logs_&skunumber    promoall_&skunumber ;
	data comparison_out ;  
		merge actual_out forecast_level ;
		by week ;
		ae=abs(actual-forecast) ;
		start=&roll ;
		keep start week ae   actual forecast   promoall_&skunumber ;
	run ;

/* step 3.5:	we calculate the values for "q" for MASE for the out-of-sample dataset */
	data comparison_out ;
		merge comparison_out naive_mae ;
		by week ;
	data comparison_out ;
		set comparison_out ;
			horizon= week- &end ;
			retain d2 ;
			if week= %eval(&start+&length) then d2= naive_ab_error ;
			keep start q ae week   actual forecast   promoall_&skunumber horizon ;
			q= ae/d2 ;
		start= &roll ;
	run ;

/* step 3.6: we add the promotion information to the out-of-sample dataset */
	data info_promoall ;
		set &dataset ;
		if f_&skunumber+d_&skunumber <> 0 then promoall_&skunumber=1 ;
			else promoall_&skunumber= 0 ;
		if &end < week< %eval(&end+ &lead +1) ;
		keep promoall_&skunumber week  ;
	run ;

	data comparison_out ;
		merge comparison_out info_promoall ;
		actual_sum= &actual_sum ;
		by week ;
	run ;



/* step 4: append rolling results */

 	proc append base= &output_lib..cat_&category._sku&skunumber data= comparison_out 
; run ;   
	/*proc append base= &output_lib..pvalues_cat_&category._&start._sku&j data= pvalues ; run ;*/
	/*proc append base= &output_lib..parms_cat_&category._&start._sku&j data= parms ; run ;*/

	run ;


	proc delete data= Actual_in ;
	proc delete data= Actual_out ;
	proc delete data= Comparison_out ;
	proc delete data= Dataset0 ;
	proc delete data= Dataset_temp1 ;
	proc delete data= Dataset_temp2 ;
	proc delete data= Dataset_temp_sales_excluded ;
	proc delete data= Forecast ;
	proc delete data= Forecast1 ;
	proc delete data= Forecast_level ;
	proc delete data= Info_promoall ;
	proc delete data= Log_bias_correction ;
	proc delete data= Model_ic ;
	proc delete data= Naive_mae ;
	proc delete data= Parms ;
	proc delete data= Pvalues ;
	proc delete data= Stat ;
	proc delete data= Temp_&skunumber ; 
 
	run ;

	/* clear output logs ;*/
	run ;
%mend ;
 
 
/*
  %let category= 	beer	;
%let skunumber= 22 ;

*/
/* %put &core_string ;*/


%rolladl(data4.Data_groc_&category  , 1, &full_window , &max_hoirzon) ; 
