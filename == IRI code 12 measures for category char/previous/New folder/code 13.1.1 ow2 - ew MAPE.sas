options nosource nonotes ;

 

%let measure=  mape ;
%let improvement= %str(improvement_ow2_ew) ;
 

/* general model */
 
proc model data= expl_cat._reg_&measure.2 ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
		&improvement= int  +     

a1	*	price_mean		+
a2	*	price_std		+
a3	*	price_SKEWNESS		+
a4	*	price_range		+
a5	*	price_KURTOSIS		+
 
 
a8	*	price_c_v		+
a9	*	sales_mean		+
a10	*	sales_std		+
a11	*	sales_SKEWNESS		+
a12	*	sales_range		+
a13	*	sales_KURTOSIS		+
a14	*	sales_c_v		+
a15	*	d_freq		+
a16	*	f_freq		+
a17	*	outliers_pct		+
a18	*	randomness		+
a19	*	linear_trend	+	 

b1	*	category_beer	+
b2	*	category_blades	+
b3	*	category_carbbev	+
b4	*	category_cigets	+
b5	*	category_coffee	+
b6	*	category_coldcer	+
b7	*	category_deod	+
b8	*	category_factiss	+
b9	*	category_fzdinen	+
b10	*	category_fzpizza	+
b11	*	category_hhclean	+
b12	*	category_hotdog	+
b13	*	category_laundet	+
b14	*	category_margbut	+
b15	*	category_mayo	+
b16	*	category_milk	+
b17	*	category_mustket	+
b18	*	category_Paptowl	+
b19	*	category_peanbut	+
b20	*	category_photo	+
b21	*	category_razors	+
b22	*	category_saltsnc	+
b23	*	category_shamp	+
b24	*	category_soup	+
b25	*	category_spagsau	+
b26	*	category_sugarsu	+
b27	*	category_toitisu	+
b28	*	category_toothbr	+
b29	*	category_toothpa	 


 
			; /* NOTICE, here we need to include potential '+' in the core_string variable, 
				just in case the core_string does not contain any variable (so we remove the + symbol) */
	 
    fit &improvement 
 
            / hccme=1    white  outresid  outall 
							  out=model_adl 
							  outest=parms  ; 
	  		  ;

ods  output parameterestimates= pvalues residsummary= stat;

     
 
   	run;

ods listing ;
quit ;
 
