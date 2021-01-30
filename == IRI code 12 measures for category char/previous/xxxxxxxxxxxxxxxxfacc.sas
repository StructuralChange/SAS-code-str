options nosource nonotes ;

 

 
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


	a4	*	 factor4  +
	a5	*	 factor5   

 
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

 
