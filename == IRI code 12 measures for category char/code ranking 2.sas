
options nonotes nosource ;
/* now we calculate error measures across all SKU's */
/* %let measure= mape ; */
%macro means1(model) ;

	data rank_0.all_comparison_&separate_str._&horizon._&measure  ;
		set rank_0.all_comparison_&separate_str._&horizon._&measure  ;
		/*
	

	 */
 
	 if category= "Paptowl"  then delete ; 
		 if category= "razors"   then delete ; 
	 




 	/* we discard these SKU's because the them the EWC model tend to have sub-estimation-windows where there is no/little variables for some of the explanatory variables and 
		 hence produce extremely bias estimates and estreme forecast values. Ideally we can write further codes to elimiate these occasions (e.g., we can retain only the forecasts
		 produced with some of the 'valid' estimation sub-windows- the coding takes time and we can simply drop these SKU's, which does not have any impact on the insight of our candidate models.
		 */

	run ;

	proc means data= rank_0.all_comparison_&separate_str._&horizon._&measure  noprint ;
		var  &model ;
		output out= r_&model mean=mean_&model ;
	run ;
	proc means data= rank_0.all_comparison_&separate_str._&horizon._&measure  noprint ;
		by category ;
		var  &model ;
		output out= r_category_&model mean=mean_&model ;
	run ;

%mend ;
	%means1(base) ;

	%means1(own2) ;
 
 	%means1(adl4) ;

	%means1(ow2_ew) ; 

	%means1(ad4_ew) ; 

	%means1(ow2_ic) ; 

	%means1(ad4_ic) ; 



/* part 1/2 across categories */
 /*	data r_allmodel ;
		merge 
			  r_base
		
			  r_own2
	
			  r_adl4
		 
			  r_ow2_ew
	
			  r_ad4_ew

			  r_ow2_ic
	
			  r_ad4_ic
  

 	   ;
		drop _freq_ _type_ ;
	run ;
proc transpose data= r_allmodel out= &measure._all ;
data &measure._all ;
	set &measure._all ;
	rename col1= &measure ;
run ;


/* rank */
	 /*	
%macro rank1  ;
	proc rank data= &measure._all out=ranking_&measure ;
		var &measure ;
		ranks rk_&measure ;
	run ;
	data ranking_&measure ;
		set ranking_&measure ;
		label rk_&measure= rk_&measure ;
	run ;
%mend ;
 
%rank1 ;


/* part 2/2 each category */
	 /*	
 	data r_allmodel_category ;
		merge 
			  r_category_base
		
			  r_category_own2
	
			  r_category_adl4
		 
			  r_category_ow2_ew
	
			  r_category_ad4_ew

			  r_category_ow2_ic
	
			  r_category_ad4_ic
  

 	   ;
		drop _freq_ _type_ ;
	run ;
proc transpose data= r_allmodel_category out= &measure._all_each_category ;
	id category ;
run ;

/* rank */
	 /*	
%macro rank2  ;
	proc rank data= &measure._all_each_category out=ranking_category_&measure ;
	
		var	saltsnck 	; ranks 	rk_saltsnck 	;
		var	beer		; ranks 	rk_beer	;
		var	carbbev		; ranks 	rk_carbbev	;
		var	blades		; ranks 	rk_blades	;
		var	cigets		; ranks 	rk_cigets	;
		var	coffee		; ranks 	rk_coffee	;
		var	coldcer		; ranks 	rk_coldcer	;
		var	deod		; ranks 	rk_deod	;
		var	factiss		; ranks 	rk_factiss	;
		var	fzdinent 	; ranks 	rk_fzdinent 	;
		var	fzpizza		; ranks 	rk_fzpizza	;
		var	hhclean		; ranks 	rk_hhclean	;
		var	hotdog		; ranks 	rk_hotdog	;
		var	laundet		; ranks 	rk_laundet	;
		var	margbutr 	; ranks 	rk_margbutr 	;
		var	mayo		; ranks 	rk_mayo	;
		var	milk		; ranks 	rk_milk	;
		var	mustketc 	; ranks 	rk_mustketc 	;
		var	peanbutr 	; ranks 	rk_peanbutr 	;
		var	photo		; ranks 	rk_photo	;
	
		var	shamp		; ranks 	rk_shamp	;
		var	soup		; ranks 	rk_soup	;
		var	spagsauc 	; ranks 	rk_spagsauc 	;
		var	sugarsub 	; ranks 	rk_sugarsub 	;
		var	toitisu		; ranks 	rk_toitisu	;
		var	toothbr		; ranks 	rk_toothbr	;
		var	toothpa		; ranks 	rk_toothpa	;
		var	yogurt		; ranks 	rk_yogurt	;




run ;

 
 
%mend ;
 
%rank2 ;
 
 
 
 */





