

proc means data = expl_cat._reg_smape_8 noprint ;
	by category ;
	output out= expl_cat.mean ;
run ;

data expl_cat.mean ;
	set expl_cat.mean ;
	if _stat_="MEAN" ;
	drop sku ;
run ;





**********************************************************;

	   ods graphics on;



data factor1 ;
	set expl_cat.mean ;
		keep 
			price_mean
			price_std
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
			abs_linear_trend ;
run ;
	proc stdize data= factor1		out= std_factor1 ;
		var price_mean
			price_std
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
			abs_linear_trend ;
	run ;




	   title3 'Principal Component Factor Analysis with Varimax Rotation';
	   proc factor data= std_factor1   
	      msa residual corr scree  PRIORS=MAX hey
		  method = ml
	      rotate = varimax reorder
		 nfactors= 4 

	      outstat=  fact_all_1 
		  score 
		  ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	ods output  orthrotfactpat=  rotfactpattern  
				corr=  correlations 	
				Varexplain= Varexplain 
				finalcommun=  finalcommun 
				;
	   run;


	   	proc score  data= std_factor1  
					score=  fact_all_1  
					out=scores  ;
		run ;
	   ods graphics off;



	   ****************************************************** ;


%macro dooall0 (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;

data xx ;	
	set expl_cat._reg_smape_8 ;
	keep improvement_ad4_ew ;
data xx2 ;	
	merge xx scores ;
 
run ;
proc model data= xx2 ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
improvement_ad4_ew= int  +     

	a1	*	 Factor1  +
	a2	*	 factor2  +
	a3	*	 factor3  +


	a4	*	 factor4   
 
			; /* NOTICE, here we need to include potential '+' in the core_string variable, 
				just in case the core_string does not contain any variable (so we remove the + symbol) */
	 
    fit improvement_ad4_ew
 
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

 
%macro dooall0_raw (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;

 
proc model data= expl_cat._reg_smape_8 ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
improvement_ad4_ew= int  +     

			a1* price_mean+
			a2	*price_std+
			a3	*price_c_v+
			a4	*sales_mean+
			a5	*sales_std+
			a6	*sales_SKEWNESS+
			a7	*sales_range+
			a8	*sales_KURTOSIS+
			a9	*sales_c_v+
			a10	*d_freq+
			a11	*f_freq+
			a12	*outliers_pct+
			a13	*randomness+
			a14	*abs_linear_trend ;



 
			; /* NOTICE, here we need to include potential '+' in the core_string variable, 
				just in case the core_string does not contain any variable (so we remove the + symbol) */
	 
    fit improvement_ad4_ew
 
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


%dooall0(ad4_ew, smape, improvement_ad4_ew, 8);
%dooall0_raw (ad4_ew, smape, improvement_ad4_ew, 8);
