options nosource nonotes ;

 

 
%macro dooall0 (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;
proc model data= expl_cat._reg_&measure.2_&horizon ; 
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
a19	*	abs_linear_trend	 

 
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
proc model data= expl_cat._reg_&measure.2_&horizon ; 
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
a19	*	abs_linear_trend	 

 
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
