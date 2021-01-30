options nosource nonotes ;

 

 
%macro dooall0 (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;

data xx ;	
	set expl_cat._reg_&measure._&horizon ;
	keep improvement_&string1 ;
data xx2 ;	
	merge xx scores ;
 
run ;
proc model data= xx2 ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
improvement_&string1= int  +     

b1	*	price_mean	+
b2	*	price_std	+
b3	*	price_c_v	+
b4	*	sales_mean	+
b5	*	sales_std	+
b6	*	sales_SKEWNESS	+
b7	*	sales_range	+
b8	*	sales_KURTOSIS	+
b9	*	sales_c_v	+
b10	*	d_freq	+
b11	*	f_freq	+
b12	*	outliers_pct	+
b13	*	randomness	+
b14	*	abs_linear_trend ;	

 
			; /* NOTICE, here we need to include potential '+' in the core_string variable, 
				just in case the core_string does not contain any variable (so we remove the + symbol) */
	 
    fit improvement_&string1
 
            /  white  outresid  outall 
							  out=model_adl 
							  outest=parms  ; 
	  		  ;

ods  output parameterestimates= pvalues residsummary= stat;

     
 
   	run;

ods listing ;
quit ;
 
data pvalues_&string1._&measure._&horizon (rename = ( Parameter= parm_&string1._&measure  estimate= estimate_&string1._&measure  Probt= probt_&string1._&measure  )) ;
	set pvalues ;
	/* if Probt<0.05 then sig_&string1._&measure=1 ;
		else sig_&string1._&measure=0 ;*/
  

	keep Parameter estimate Probt  ;
run ;

data all_&horizon ;
	set pvalues_&string1._&measure._&horizon ;
run ;

%mend ;

 /* ewc model */

%dooall0(ad4_ew, smape, improvement_ad4_ew, 8);
%dooall0(ad4_ew, smape, improvement_ad4_ew, 4);
%dooall0(ad4_ew, smape, improvement_ad4_ew, 1);



%dooall0(ad4_ew, mase, improvement_ad4_ew, 8);
%dooall0(ad4_ew, mase, improvement_ad4_ew, 4);
%dooall0(ad4_ew, mase, improvement_ad4_ew, 1);

%dooall0(ad4_ew, mae, improvement_ad4_ew, 8);
%dooall0(ad4_ew, mae, improvement_ad4_ew, 4);
%dooall0(ad4_ew, mae, improvement_ad4_ew, 1);



%macro t1(model, measure, horizon, number) ;
data t&number  ;
	set Pvalues_&model._&measure._&horizon ;
		rename parm_&model._&measure		= parm ;
		rename estimate_&model._&measure	= est_&model._&measure._&horizon ;
		rename probt_&model._&measure		= probt_&model._&measure._&horizon ;
 run ;
 %mend ;
%t1(ad4_ew,mae,1, 1) ;
%t1(ad4_ew,mae,4, 2) ;
%t1(ad4_ew,mae,8, 3) ;
%t1(ad4_ew,mase,1, 4) ;
%t1(ad4_ew,mase,4, 5) ;
%t1(ad4_ew,mase,8, 6) ;
%t1(ad4_ew,smape,1, 7) ;
%t1(ad4_ew,smape,4, 8) ;
%t1(ad4_ew,smape,8, 9) ;

proc sort data = t1 ; by parm ;
proc sort data = t2 ; by parm ;
proc sort data = t3 ; by parm ;
proc sort data = t4 ; by parm ;
proc sort data = t5 ; by parm ;
proc sort data = t6 ; by parm ;
proc sort data = t7 ; by parm ;
proc sort data = t8 ; by parm ;
proc sort data = t9 ; by parm ;
run ;

data t_all ;
	merge t1 t2 t3 t4 t5 t6 t7 t8 t9 ;
	by parm ;
run ;
 
 
 /* IC model */

%dooall0(ad4_ic, smape, improvement_ad4_ic, 8);
%dooall0(ad4_ic, smape, improvement_ad4_ic, 4);
%dooall0(ad4_ic, smape, improvement_ad4_ic, 1);

%dooall0(ad4_ic, mase, improvement_ad4_ic, 8);
%dooall0(ad4_ic, mase, improvement_ad4_ic, 4);
%dooall0(ad4_ic, mase, improvement_ad4_ic, 1);

%dooall0(ad4_ic, mae, improvement_ad4_ic, 8);
%dooall0(ad4_ic, mae, improvement_ad4_ic, 4);
%dooall0(ad4_ic, mae, improvement_ad4_ic, 1);



%macro t1(model, measure, horizon, number) ;
data t&number  ;
	set Pvalues_&model._&measure._&horizon ;
		rename parm_&model._&measure		= parm ;
		rename estimate_&model._&measure	= est_&model._&measure._&horizon ;
		rename probt_&model._&measure		= probt_&model._&measure._&horizon ;
 run ;
 %mend ;
%t1(ad4_ic,mae,1, 1) ;
%t1(ad4_ic,mae,4, 2) ;
%t1(ad4_ic,mae,8, 3) ;
%t1(ad4_ic,mase,1, 4) ;
%t1(ad4_ic,mase,4, 5) ;
%t1(ad4_ic,mase,8, 6) ;
%t1(ad4_ic,smape,1, 7) ;
%t1(ad4_ic,smape,4, 8) ;
%t1(ad4_ic,smape,8, 9) ;

proc sort data = t1 ; by parm ;
proc sort data = t2 ; by parm ;
proc sort data = t3 ; by parm ;
proc sort data = t4 ; by parm ;
proc sort data = t5 ; by parm ;
proc sort data = t6 ; by parm ;
proc sort data = t7 ; by parm ;
proc sort data = t8 ; by parm ;
proc sort data = t9 ; by parm ;
run ;

data t_all_ic ;
	merge t1 t2 t3 t4 t5 t6 t7 t8 t9 ;
	by parm ;
run ;
 
/* own - ic */

 /* IC model */

%dooall0(ow2_ic, smape, improvement_ow2_ic, 8);
%dooall0(ow2_ic, smape, improvement_ow2_ic, 4);
%dooall0(ow2_ic, smape, improvement_ow2_ic, 1);

%dooall0(ow2_ic, mase, improvement_ow2_ic, 8);
%dooall0(ow2_ic, mase, improvement_ow2_ic, 4);
%dooall0(ow2_ic, mase, improvement_ow2_ic, 1);

%dooall0(ow2_ic, mae, improvement_ow2_ic, 8);
%dooall0(ow2_ic, mae, improvement_ow2_ic, 4);
%dooall0(ow2_ic, mae, improvement_ow2_ic, 1);



%macro t1(model, measure, horizon, number) ;
data t&number  ;
	set Pvalues_&model._&measure._&horizon ;
		rename parm_&model._&measure		= parm ;
		rename estimate_&model._&measure	= est_&model._&measure._&horizon ;
		rename probt_&model._&measure		= probt_&model._&measure._&horizon ;
 run ;
 %mend ;
%t1(ow2_ic,mae,1, 1) ;
%t1(ow2_ic,mae,4, 2) ;
%t1(ow2_ic,mae,8, 3) ;
%t1(ow2_ic,mase,1, 4) ;
%t1(ow2_ic,mase,4, 5) ;
%t1(ow2_ic,mase,8, 6) ;
%t1(ow2_ic,smape,1, 7) ;
%t1(ow2_ic,smape,4, 8) ;
%t1(ow2_ic,smape,8, 9) ;

proc sort data = t1 ; by parm ;
proc sort data = t2 ; by parm ;
proc sort data = t3 ; by parm ;
proc sort data = t4 ; by parm ;
proc sort data = t5 ; by parm ;
proc sort data = t6 ; by parm ;
proc sort data = t7 ; by parm ;
proc sort data = t8 ; by parm ;
proc sort data = t9 ; by parm ;
run ;

data t_all_ow2_ic ;
	merge t1 t2 t3 t4 t5 t6 t7 t8 t9 ;
	by parm ;
run ;

/* ow2 ew*/
 

%dooall0(ow2_ew, smape, improvement_ow2_ew, 8);
%dooall0(ow2_ew, smape, improvement_ow2_ew, 4);
%dooall0(ow2_ew, smape, improvement_ow2_ew, 1);

%dooall0(ow2_ew, mase, improvement_ow2_ew, 8);
%dooall0(ow2_ew, mase, improvement_ow2_ew, 4);
%dooall0(ow2_ew, mase, improvement_ow2_ew, 1);

%dooall0(ow2_ew, mae, improvement_ow2_ew, 8);
%dooall0(ow2_ew, mae, improvement_ow2_ew, 4);
%dooall0(ow2_ew, mae, improvement_ow2_ew, 1);



%macro t1(model, measure, horizon, number) ;
data t&number  ;
	set Pvalues_&model._&measure._&horizon ;
		rename parm_&model._&measure		= parm ;
		rename estimate_&model._&measure	= est_&model._&measure._&horizon ;
		rename probt_&model._&measure		= probt_&model._&measure._&horizon ;
 run ;
 %mend ;
%t1(ow2_ew,mae,1, 1) ;
%t1(ow2_ew,mae,4, 2) ;
%t1(ow2_ew,mae,8, 3) ;
%t1(ow2_ew,mase,1, 4) ;
%t1(ow2_ew,mase,4, 5) ;
%t1(ow2_ew,mase,8, 6) ;
%t1(ow2_ew,smape,1, 7) ;
%t1(ow2_ew,smape,4, 8) ;
%t1(ow2_ew,smape,8, 9) ;

proc sort data = t1 ; by parm ;
proc sort data = t2 ; by parm ;
proc sort data = t3 ; by parm ;
proc sort data = t4 ; by parm ;
proc sort data = t5 ; by parm ;
proc sort data = t6 ; by parm ;
proc sort data = t7 ; by parm ;
proc sort data = t8 ; by parm ;
proc sort data = t9 ; by parm ;
run ;

data t_all_ow2_ew ;
	merge t1 t2 t3 t4 t5 t6 t7 t8 t9 ;
	by parm ;
run ;
