options nonotes nosource ;
 
%include "q:\= IRI data research\== External macros\code x count rows and columns.sas" ; run ;
 

/* this marco concatenate the forecasts by each pair of models */
/* %let category=blade ;*/


%macro extract_sku_numbers ;
	** step 0, we extract the sku numbers from the model0 dataset, e.g. 21, 28 et al. from the beer category, and 
	we then code to organize the error measure results based on their sku numbers ;
	* step 0.1, we extract the unit sales ;
	data Data_groc_&category ;
		set data4.Data_groc_&category ;
		keep  logs_1- logs_2200 ;
		if week< 2 ;* week 1322 is the first week in year 5 ;
	run ;
	* we organize the dataset by transposing them ;
	proc transpose data= Data_groc_&category out=Data_groc_&category ;
	run ;
	* now we store the SKU numbers into macro variables ; 
	data temp ;
		set Data_groc_&category ;
		i= _n_ ;
		retail_list= compress(_name_,"logs_");
		retail_list_numeric= input( retail_list, 12.) ;
		call symput('results_sku'||strip(i),retail_list_numeric);
	run ;
	 
	%obsnvars(temp) ;
	**  %put &dset has &nvars variable(s) and &nobs observation(s).;

%mend ;



%macro concatenate0 ;
 
	%do cc1 = 1 %to &nobs ;
		%let skunumber= &&results_sku&cc1 ;
			data temp0 ;
				set &results_lib0..Cat_&category._sku&skunumber ;
				  rename promoall_&skunumber = promoall ;
				  rename forecast = forecast_original ;
				  rename q = q_0 ;
				  rename ae = ae_0 ;
				  length category $ 22 ;
				  category= "&category" ;
				  sku= &skunumber ;
			run ;
			proc append base= model0 data= temp0 force ;
			run ;

	
			data temp1 ;
				set &results_lib1..Cat_&category._sku&skunumber ;
				  rename promoall_&skunumber = promoall ;
				  rename forecast = forecast_sb_adjusted ;
				  rename q = q_1 ;
				  rename ae = ae_1 ;
				  length category $ 22 ;
				  category= "&category" ;
				  sku= &skunumber ;
			run ;
			proc append base= model1 data= temp1 force ;
			run ;
 
	%end ;
%mend ;
%macro catlist ;
	/* %let category= 	Paptowl	;%extract_sku_numbers ; %concatenate0 ;	  */
	%let category= 	saltsnck;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	beer	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	carbbev	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	blades	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	cigets	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	coffee	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	coldcer	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	deod	;%extract_sku_numbers ; %concatenate0 ; 
	%let category= 	factiss	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	fzdinent;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	fzpizza	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	hhclean	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	hotdog	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	laundet	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	margbutr;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	mayo	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	milk	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	mustketc;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	peanbutr;%extract_sku_numbers ; %concatenate0 ;
 	%let category= 	photo	;%extract_sku_numbers ; %concatenate0 ; 
 	/* %let category= 	razors	;%extract_sku_numbers ; %concatenate0 ; */
	%let category= 	shamp	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	soup	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	spagsauc;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	sugarsub;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	toitisu	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	toothbr	;%extract_sku_numbers ; %concatenate0 ;
	%let category= 	toothpa	;%extract_sku_numbers ; %concatenate0 ; 
	%let category= 	yogurt	;%extract_sku_numbers ; %concatenate0 ;   
%mend ;
%macro concatenate1 (model0, model1 ) ;

	%let results_lib0= r_&model0 ;
	%let results_lib1= r_&model1 ;
	%catlist ;
		proc sort data= model0 ;
			by category sku start horizon ;
		proc sort data= model1 ;
			by category sku start horizon ;
		run ;
		data expl_str.Overall_r_&model0._versus_r_&model1 ;
			merge model0 model1 ;
			by category sku start horizon ;
		run ;
%mend ;
 /*
*proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, ow2_ic );
*proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, ow2_ew );



*proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, base );

*proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, adl4 );
*/
proc datasets library=work kill nolist ; run; quit ;%concatenate1 (adl4, ad4_ic );
proc datasets library=work kill nolist ; run; quit ;%concatenate1 (adl4, ad4_ew );
proc datasets library=work kill nolist ; run; quit ;%concatenate1 (adl4, ewc_ic );

proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, base );
proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, adl4 );
proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, ow2_ic );
proc datasets library=work kill nolist ; run; quit ;%concatenate1 (own2, ow2_ew );






