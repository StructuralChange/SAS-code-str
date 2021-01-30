options nosource nonotes ;

/* test sig for h=12, for all, not only for sb period */

%include "Q:\= IRI data research\== External macros\code x count rows and columns.sas" ; run ;
 


/* %let category=blade ;*/


%macro extract_sku_numbers ;
	** step 0, we extract the sku numbers from the original dataset, e.g. 21, 28 et al. from the beer category, and 
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


 

/* calculate MAPE */
%macro comparison_ew   ;
 
 
	%do cc1 = 1 %to &nobs ;
	%let skunumber= &&results_sku&cc1 ;
			data temp0_&cc1 (rename= (promoall_&skunumber= promoall)) ;
				merge &lib0..Cat_&category._sku&skunumber  	(rename= (forecast= forecast_original ae=ae_0 q=q_0 )) 
					  &lib1..Cat_&category._sku&skunumber  (rename= (forecast= forecast_sb_adjusted ae=ae_1 q=q_1)) ;
				by start week ;
				sku=&skunumber ;
				length category $22 ;
				category= "&category" ;
				 
			if forecast_original = forecast_sb_adjusted then delete    ;
			run ;
			proc append base= temp0_all_&category data= temp0_&cc1 force ;
			run ;	

		 proc delete data= temp0_&cc1 ; 
		run ;
 
	%end ;

 
%mend ;


 %macro concatenate2_0 (category) ;
  %extract_sku_numbers ; 
 
	%comparison_ew  ;

	data expl_str.str_bk_&lib0._versus_&lib1 ;
		set temp0_all_&category ;
	run ;

%mend ;

  %macro concatenate2 (category) ;
  %extract_sku_numbers ; %comparison_ew  ;

	data expl_str.str_bk_&lib0._versus_&lib1 ;
		set expl_str.str_bk_&lib0._versus_&lib1 temp0_all_&category ;
	run ;

%mend ;

  %macro concatenate_last (category) ;
  %extract_sku_numbers ; %comparison_ew  ;

	data expl_str.str_bk_&lib0._versus_&lib1 ;
		set expl_str.str_bk_&lib0._versus_&lib1 temp0_all_&category ;
		 if category= "spagsauc" and sku= 176 then delete ; 
		 if category= "cigets" and sku= 614 then delete ; 
		 if category= "toothpa" and sku= 536 then delete ; 
		 if category= "saltsnck" and sku= 1530 then delete ; 
	 
	run ;

%mend ;

 
	%concatenate2_0 (beer) ; 
	%concatenate2 (Paptowl) ;  
	%concatenate2 (carbbev) ;
	%concatenate2 (blades) ;
	%concatenate2 (cigets) ;
	%concatenate2 (coffee) ;
	%concatenate2 (coldcer) ;
	%concatenate2 (deod) ;
	%concatenate2 (factiss) ;
	%concatenate2 (fzdinent) ;
	%concatenate2 (fzpizza) ;
	%concatenate2 (hhclean) ;
	%concatenate2 (hotdog) ;
	%concatenate2 (laundet) ;
	%concatenate2 (margbutr) ;
	%concatenate2 (mayo) ;
	%concatenate2 (milk) ;
	%concatenate2 (mustketc) ;
	%concatenate2 (peanbutr) ;
	%concatenate2 (photo) ; 
	%concatenate2 (razors) ; 
	%concatenate2 (saltsnck) ;
	%concatenate2 (shamp) ;
	%concatenate2 (soup) ;
	%concatenate2 (spagsauc) ;
	%concatenate2 (sugarsub) ;
	%concatenate2 (toitisu) ;
	%concatenate2 (toothbr) ;
	%concatenate2 (toothpa) ;
	%concatenate_last (yogurt) ;  

