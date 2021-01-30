options nosource nonotes ;

 

 
%macro dooall0 (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;

data xx ;	
	set expl_cat._reg_&measure.2_&horizon ;
	xx= log(&improvement.+1) ;
	if xx=. then delete ;
	if price_range=0 then delete ;
run ;
proc model data= xx ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
xx= int  +     

a1	*	log(price_mean+1)		+
a2	*	log(price_std+1)		+
a3	*	log(price_SKEWNESS+1)		+
a4	*	log(price_range+1)		+
a5	*	log(price_KURTOSIS+1)		+
 
 
a8	*	log(price_c_v+1)		+
a9	*	log(sales_mean+1)		+
a10	*	log(sales_std+1)		+
a11	*	log(sales_SKEWNESS+1)		+
a12	*	log(sales_range+1)		+
a13	*	log(sales_KURTOSIS+1)		+
a14	*	log(sales_c_v+1)		+
a15	*	d_freq		+
a16	*	f_freq		+
a17	*	log(outliers_pct+1)		+
a18	*	log(randomness+1)		+
a19	*	log(abs_linear_trend+1)	  +
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
	 
    fit xx
 
            / hccme=1    white  outresid  outall 
							  out=model_adl 
							  outest=parms  ; 
	  		  ;

ods  output parameterestimates= pvalues residsummary= stat;

     
 
   	run;

ods listing ;
quit ;
 
data pvalues_&string1._&measure (rename = ( Parameter= parm_&string1._&measure  estimate= estimate_&string1._&measure  Probt= probt_&string1._&measure  )) ;
	set pvalues ;
	/* if Probt<0.05 then sig_&string1._&measure=1 ;
		else sig_&string1._&measure=0 ;*/
  

	keep Parameter estimate Probt  ;
run ;

data all_&horizon ;
	set pvalues_&string1._&measure ;
run ;

%mend ;

 
%macro dooall (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;

data xx ;	
	set expl_cat._reg_&measure.2_&horizon ;
	xx= log(&improvement.+1) ;
	if xx=. then delete ;
	if price_range=0 then delete ;
run ;
proc model data= xx ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
xx= int  +     

a1	*	log(price_mean+1)		+
a2	*	log(price_std+1)		+
a3	*	log(price_SKEWNESS+1)		+
a4	*	log(price_range+1)		+
a5	*	log(price_KURTOSIS+1)		+
 
 
a8	*	log(price_c_v+1)		+
a9	*	log(sales_mean+1)		+
a10	*	log(sales_std+1)		+
a11	*	log(sales_SKEWNESS+1)		+
a12	*	log(sales_range+1)		+
a13	*	log(sales_KURTOSIS+1)		+
a14	*	log(sales_c_v+1)		+
a15	*	d_freq		+
a16	*	f_freq		+
a17	*	log(outliers_pct+1)		+
a18	*	log(randomness+1)		+
a19	*	log(abs_linear_trend+1)	 +

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
	 
    fit xx
 
            / hccme=1    white  outresid  outall 
							  out=model_adl 
							  outest=parms  ; 
	  		  ;

ods  output parameterestimates= pvalues residsummary= stat;

     
 
   	run;

ods listing ;
quit ;
 
data pvalues_&string1._&measure (rename = (  estimate= estimate_&string1._&measure  Probt= probt_&string1._&measure  )) ;
	set pvalues ;
	/* if Probt<0.05 then sig_&string1._&measure=1 ;
		else sig_&string1._&measure=0 ;*/
	/*
	estimate= round(estimate*1000)/1000 ;
	Probt= round(Probt*1000)/1000 ;
	keep   estimate Probt  ;
	*/
 
	keep     estimate Probt  ;
run ;

data all_&horizon ;
	merge all_&horizon pvalues_&string1._&measure ;
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
