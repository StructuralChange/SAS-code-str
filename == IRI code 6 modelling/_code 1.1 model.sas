
options nonotes nosource ;

 
%macro base_lift ( dataset, firstobs, length, lead ) ;  
 

/*

%let category = paptowl ;

 %let skunumber =143; 
 %let dataset= data4.Data_groc_&category ;
%let firstobs= 1 ;
%let length= 160 ;
%let lead= 12 ;



*/

 


/* 
step 1 dataset preparation: 
step 1.1	we need to construct a variable which indicates if there is promotional event (that can either be a display or feature), also
		in the dataset the variable is in log- format, we need to convert it to level- format 
*/
/* in the following dataset, variable_level is the sales variable in level, and promoall_&skunumber of value 1 indicates that there is a promotional event */
data dataset0 ;
	set &dataset ;
	if f_&skunumber+d_&skunumber  <> 0 then promoall_&skunumber=1 ;
		else promoall_&skunumber= 0 ;
	variable_level= exp(logs_&skunumber) ; /*   */
	keep week variable_level f_&skunumber d_&skunumber promoall_&skunumber ;
run ;


/* then we construct a 'reduced' dataset which makes the running of the code faster */
/* data_promo_only contains week and promotion only */ 
data data_promo_only ;
	set dataset0 ;
	keep week promoall_&skunumber ;
run ;
 

/* 
step 1.2	: create the "smoothed" dataset where the "smooth" sales (in level) equals to the sales in the non-promoted period, and equals 
to the previous non-promoted sales if the current period is promoted ; */
data data_non_promotion ;
	set dataset0 ;
	if _N_=1 then  temp= variable_level ;
	if 	promoall_&skunumber>0  then 
		smooth= temp ;
	else do ;
		smooth= variable_level ;
		temp= variable_level ;
	end ;
	retain temp ;
run ;

/* 
step 2: the modelling and rolling */

	
 
 %do roll = 1 %to &end_of_rolling %by &jump   ;
		%let start= %eval(&firstobs+&roll-1) ;
		%let end= %eval(&start+&length-1) ; 


/*

%let roll = 1 ;

	%let start= %eval(&firstobs+&roll-1) ;
		%let end= %eval(&start+&length-1) ; 




*/

		

	data dataset_temp1 ; 
		set data_non_promotion ;
		drop variable_level ;
	data dataset_temp2 ; 
		set data_non_promotion (obs= &end) ;
		keep week variable_level ;
	data dataset_temp_sales_excluded ;
		merge dataset_temp1 dataset_temp2 ;
		by week ;
	run ;




/* step 2:	forecast using SES based on the non-promoted period ;*/

proc forecast data= dataset_temp_sales_excluded(firstobs= &start obs=%eval(&start+&length-1)) lead=&lead
				method=expo trend=1 
                 out=pred outall ;
	id week ;
	var smooth ;
run ;


*/ 
* step 3:	arrange the output datasets ;
* step 3.1:	combine the datasets ;
*/ ;
data predforecast ;
	set pred ;
	if _type_= "FORECAST" ;
data predact (rename= (smooth=actual)) ;
	set pred ;
	if _type_= "ACTUAL" ;
/* step 3.1.1:	calculate lift ; */ ;
data comparison ;
	merge predact predforecast data_promo_only ;
	lift= actual- smooth;
	if lift<0 then lift=0 ;	
	if 	promoall_&skunumber= 0 then 
		lastlift= temp ;
	else if promoall_&skunumber >0 then do ;
		lastlift= lift ;
		temp= lift ;
	end ;
	retain temp ;


	if 	promoall_&skunumber=0 then 
		promo_proportion= temp2 ;
	else if promoall_&skunumber >0 then do ;
		promo_proportion= promoall_&skunumber ;
		temp2= promoall_&skunumber ;
	end ;
	retain temp2 ;


	by week ;
	drop temp _type_ ;
run ;

data comparison_exp ;
	set comparison ;
	if week=&end then do ;
		exp_lastlift= lastlift ;
		exp_promoproportion=  promo_proportion ;
	end ;

	if 	exp_lastlift<0 then exp_lastlift=exptemp ;
		else exptemp= exp_lastlift ;
	retain exptemp ;

	if 	exp_promoproportion<0 then exp_promoproportion=exptemp2 ;
		else exptemp2= exp_promoproportion ;
	retain exptemp2 ;
	drop exptemp exptemp2 ;
run ;
 


/* step 3.1.2:	calculate lastlift ; */ ;
data comparison2 ;
	set comparison_exp ;
	if _N_=&start then temp= lastlift ;
	if lastlift ="" then lastlift= temp ;
		else temp= lastlift ; 
	retain temp ;
run ;
/* step 3.1.3:	adjust forecasts with lastlift ; */ ;
data comparison3 ;
	set comparison2 ;
	if 	exp_lastlift=. then exp_lastlift=0 ;
	if 	exp_promoproportion=. then exp_promoproportion=0 ;
	if promoall_&skunumber= 0 then ajustforecast=  smooth ;
	if promoall_&skunumber> 0 then do ;
		if exp_lastlift>0 then ajustforecast=  smooth+ exp_lastlift*(promoall_&skunumber/exp_promoproportion) ;
		else  ajustforecast=  smooth ;
	end ;
	drop lift lastlift  promo_proportion temp temp2 exp_lastlift exp_promoproportion ;
run ;
*/ 
* step 4:	evaluation ;
* step 4.1: in-sample fit: MSE - omitted ; 
* step 4.2:	The post-sample forecasts are in "forecast" ; 
*/ ;
	data forecast (rename=(ajustforecast= forecast));
		set Comparison3  ;
		if _LEAD_>0 ;
		keep ajustforecast week ;
	run ;


	data actual_in  (rename=(variable_level= actual)) ;
		set dataset0 ;
		if &start-1< week< &start+&length ;
		keep week variable_level  promoall_&skunumber ;
	data actual_in ;
		set actual_in ;
		lag= lag(actual) ;
		naive_ab_error= abs(actual-lag) ;
	data actual_in ;
		set actual_in ;
		if _N_=1 then delete ;
	run ;
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
 


/* step 3.4:	post-sample abs errors ; */ ;
	data actual_out  (rename=(variable_level=actual));
		set dataset0 ;
		if &start+&length-1<week<&start+&length+&lead ;
		keep week variable_level   promoall_&skunumber ;
	data comparison_out ;  
		merge actual_out forecast ;
		by week ;
		ae=abs(actual-forecast) ;
		roll=&roll ;
		
		
		keep roll week ae   actual forecast  promoall_&skunumber ;
	run ;

/* step 3.5:	calculation for "q" ;*/ ;
	data comparison_out ;
		merge comparison_out naive_mae ;
		by week ;
	data comparison_out ;
		set comparison_out ;
			horizon= week- &end ;
			retain d2 ;
			if week= %eval(&start+&length) then d2= naive_ab_error ;
			keep roll q ae week   actual forecast  promoall_&skunumber horizon ;
			q= ae/d2 ;
		roll= &roll ;
	run ;
	* step 3.6: add the promotion information ;
	data info_promoall ;
		set &dataset ;
		if f_&skunumber+d_&skunumber <> 0 then promoall_&skunumber=1 ;
			else promoall_&skunumber= 0 ;
		if &end < week< %eval(&end+ &lead +1) ;
		keep promoall_&skunumber week  ;
	run ;

	data comparison_out (rename = (roll= start)) ;
		merge comparison_out info_promoall ;
		actual_sum= &actual_sum ;
		by week ;
	run ;
/* step 4: append rolling results ; */ ;

 	proc append base= &output_lib..cat_&category._sku&skunumber data= comparison_out ; run ;  * comp_all contains all the "q" values ;
	run ;
	* clear output logs ; /*
		  dm 'odsres; select all;clear;';  
		 dm"odsres; clear; out; clear;";
*/
	  ;

%end ;
%mend ; 
 
/* %let j=	160	;	%base_lift (data5.Data_factor_beer, beer, units_&skunumber, &lower, &upper, 12, &experiment, week) ;*/
 

%base_lift (data4.Data_groc_&category, 1,&full_window, &max_hoirzon) ;
 

* the index for the following categories were subject to errors, double check, mayo, coffee, papttowl, saltsnck, toothbr ;
