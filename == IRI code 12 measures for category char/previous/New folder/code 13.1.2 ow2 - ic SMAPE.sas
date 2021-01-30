options nosource nonotes ;

 

%let measure=  smape ;
%let improvement= %str(improvement_ow2_ic) ;
 

/* general model */
 
proc model data= expl_cat._reg_&measure.2 ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
		&improvement= int  +     

 
a17	*	outliers_pct		+
   
 
b12	*	category_hotdog	+
 
 
b16	*	category_milk	+
 
b18	*	category_Paptowl	+
 
b20	*	category_photo	+
 
b24	*	category_soup	+
 
b27	*	category_toitisu	 

 
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
 
