options nosource nonotes ;

 


%macro dooall0 ( MODEL, measure, improvement, horizon) ;

	ods listing  ;
	/* Method: LASSO ;*/
	proc glmselect data= expl_cat._reg_&measure.2_&horizon  ;
		model &improvement= 

	
 	price_mean		 
 	price_std		 
 	price_SKEWNESS		 
 	price_range		 
 	price_KURTOSIS		 
 
 
 	price_c_v		 
 	sales_mean		 
 	sales_std		 
 	sales_SKEWNESS		 
 	sales_range		 
 	sales_KURTOSIS		 
 	sales_c_v		 
 	d_freq		 
 	f_freq		 
 	outliers_pct		 
 	randomness		 
 	abs_linear_trend	

 	category_beer	 
 	category_blades	 
 	category_carbbev	 
 	category_cigets 
 	category_coffee	 
 	category_coldcer	 
 	category_deod	 
 	category_factiss	 
 	category_fzdinen	 
 	category_fzpizza	 
 	category_hhclean	 
 	category_hotdog	 
 	category_laundet	 
 	category_margbut	 
 	category_mayo	 
 	category_milk 
 	category_mustket	 
 	category_Paptowl	 
 	category_peanbut 
 	category_photo	 
 	category_razors	 
 	category_saltsnc	 
 	category_shamp	 
 	category_soup 
 	category_spagsau	 
 	category_sugarsu	 
 	category_toitisu	 
 	category_toothbr	 
 	category_toothpa	 



/ 
				selection= lasso (choose= cvex) cvmethod=split(10) ;
		ods output selectionsummary=lasso_table ;
	run;
data lasso (rename= (EffectEntered=&improvement._&measure._&horizon))  ;
		length EffectEntered $ 16;
		set Lasso_table ;
		keep EffectEntered ;
		if EffectEntered="Intercept" then delete ;
		if EffectEntered="" then delete ;
	run ; 

	data lasso_all ;
		set lasso ;
	run ;
 %mend ;

%macro dooall ( MODEL, measure, improvement, horizon) ;

	ods listing  ;
	/* Method: LASSO ;*/
	proc glmselect data= expl_cat._reg_&measure.2_&horizon  ;
		model &improvement= 

	
 	price_mean		 
 	price_std		 
 	price_SKEWNESS		 
 	price_range		 
 	price_KURTOSIS		 
 
 
 	price_c_v		 
 	sales_mean		 
 	sales_std		 
 	sales_SKEWNESS		 
 	sales_range		 
 	sales_KURTOSIS		 
 	sales_c_v		 
 	d_freq		 
 	f_freq		 
 	outliers_pct		 
 	randomness		 
 	abs_linear_trend	

 



/ 
				selection= lasso (choose= cvex) cvmethod=split(10) ;
		ods output selectionsummary=lasso_table ;
	run;
	data lasso (rename= (EffectEntered=&improvement._&measure._&horizon))  ;
		length EffectEntered $ 16;
		set Lasso_table ;
		keep EffectEntered ;
		if EffectEntered="Intercept" then delete ;
		if EffectEntered="" then delete ;
	run ; 

	data lasso_all ;
		merge lasso_all lasso ;
	run ;
 %mend ;




 
%dooall0(ad4_ic, mape,  improvement_ad4_ic, 12 );
%dooall(ad4_ic, smape, improvement_ad4_ic, 12);
%dooall(ad4_ic, mase,  improvement_ad4_ic, 12);
%dooall(ad4_ew, mape,  improvement_ad4_ew, 12);
%dooall(ad4_ew, smape, improvement_ad4_ew, 12);
%dooall(ad4_ew, mase,  improvement_ad4_ew, 12);
%dooall(ow2_ic, mape,  improvement_ow2_ic, 12);
%dooall(ow2_ic, smape, improvement_ow2_ic, 12);
%dooall(ow2_ic, mase,  improvement_ow2_ic, 12);
%dooall(ow2_ew, mape,  improvement_ow2_ew, 12);
%dooall(ow2_ew, smape, improvement_ow2_ew, 12);
%dooall(ow2_ew, mase,  improvement_ow2_ew, 12);

%dooall0(ad4_ic, mape,  improvement_ad4_ic, 4 );
%dooall(ad4_ic, smape, improvement_ad4_ic, 4);
%dooall(ad4_ic, mase,  improvement_ad4_ic, 4);
%dooall(ad4_ew, mape,  improvement_ad4_ew, 4);
%dooall(ad4_ew, smape, improvement_ad4_ew, 4);
%dooall(ad4_ew, mase,  improvement_ad4_ew, 4);
%dooall(ow2_ic, mape,  improvement_ow2_ic, 4);
%dooall(ow2_ic, smape, improvement_ow2_ic, 4);
%dooall(ow2_ic, mase,  improvement_ow2_ic, 4);
%dooall(ow2_ew, mape,  improvement_ow2_ew, 4);
%dooall(ow2_ew, smape, improvement_ow2_ew, 4);
%dooall(ow2_ew, mase,  improvement_ow2_ew, 4);

%dooall0(ad4_ic, mape,  improvement_ad4_ic, 1 );
%dooall(ad4_ic, smape, improvement_ad4_ic, 1);
%dooall(ad4_ic, mase,  improvement_ad4_ic, 1);
%dooall(ad4_ew, mape,  improvement_ad4_ew, 1);
%dooall(ad4_ew, smape, improvement_ad4_ew, 1);
%dooall(ad4_ew, mase,  improvement_ad4_ew, 1);
%dooall(ow2_ic, mape,  improvement_ow2_ic, 1);
%dooall(ow2_ic, smape, improvement_ow2_ic, 1);
%dooall(ow2_ic, mase,  improvement_ow2_ic, 1);
%dooall(ow2_ew, mape,  improvement_ow2_ew, 1);
%dooall(ow2_ew, smape, improvement_ow2_ew, 1);
%dooall(ow2_ew, mase,  improvement_ow2_ew, 1);
