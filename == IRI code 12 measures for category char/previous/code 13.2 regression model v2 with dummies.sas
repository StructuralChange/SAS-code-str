options nosource nonotes ;

 

 
%macro dooall0 (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;
proc model data= expl_cat._reg_&measure._&horizon ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
		&improvement= int  +     

a1	*	price_mean		+
a2	*	price_std		+
a3	*	price_SKEWNESS +
a4	*	price_c_v		+
a5	*	price_KURTOSIS +

 
a6	*	sales_mean		+
a7	*	sales_std		+
a8	*	sales_SKEWNESS +
a9	*	sales_c_v		+
a10	*	sales_KURTOSIS +

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
 
%dooall0(ad4_ic, mase,  improvement_ad4_ic, 4 ); 

data data1 ;
	set expl_cat._reg_mase_4  ;
	if price_range= "" then delete ;
	keep price_mean
price_std
price_SKEWNESS

price_KURTOSIS


price_c_v
sales_mean
sales_std
sales_SKEWNESS

sales_KURTOSIS
sales_c_v
 
;
run ;

proc stdize data= data1 	out= xx ; run ;

	   title3 'Principal Component Factor Analysis with Varimax Rotation';
	   proc factor data= xx    
	      msa residual corr scree  PRIORS=MAX
		  method = ml
	      rotate = varimax reorder
		  NFACTORS= 3

	      outstat=  fact_all  
		  score 
		  ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	ods output  orthrotfactpat=  rotfactpattern 
				corr=  correlations 	
				 
				;
	   run;
	   	proc score  data= xx 
					score=  fact_all 
					out=scores  ;
		run ;
 
