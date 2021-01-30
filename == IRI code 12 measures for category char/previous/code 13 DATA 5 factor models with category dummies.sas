options nosource nonotes ;

  

 
%macro dooall0 (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;


/* here we combine the data set contianing the orginal variables (e.g., the percentage improved forecasting accuracy, and the category variable) with the data set containing the constructed factors */ 
data xx ;	
	set expl_cat._reg_&measure._&horizon ;
	keep improvement_&string1 category ;
data xx2 ;	
	merge xx scores ;
if category="beer"			then		category_beer		=	1	; else	category_beer		=	0;
if category="blades"			then		category_blades		=	1	; else	category_blades		=	0;
if category="carbbev"			then		category_carbbev		=	1	; else	category_carbbev		=	0;
if category="cigets"			then		category_cigets		=	1	; else	category_cigets		=	0;
if category="coffee"			then		category_coffee		=	1	; else	category_coffee		=	0;
if category="coldcer"			then		category_coldcer		=	1	; else	category_coldcer		=	0;
if category="deod"			then		category_deod		=	1	; else	category_deod		=	0;
if category="factiss"			then		category_factiss		=	1	; else	category_factiss		=	0;
if category="fzdinent"			then		category_fzdinent		=	1	; else	category_fzdinent		=	0;
if category="fzpizza"			then		category_fzpizza		=	1	; else	category_fzpizza		=	0;
if category="hhclean"			then		category_hhclean		=	1	; else	category_hhclean		=	0;
if category="hotdog"			then		category_hotdog		=	1	; else	category_hotdog		=	0;
if category="laundet"			then		category_laundet		=	1	; else	category_laundet		=	0;
if category="margbutr"			then		category_margbutr		=	1	; else	category_margbutr		=	0;
if category="mayo"			then		category_mayo		=	1	; else	category_mayo		=	0;
if category="milk"			then		category_milk		=	1	; else	category_milk		=	0;
if category="mustketc"			then		category_mustketc		=	1	; else	category_mustketc		=	0;
if category="peanbutr"			then		category_peanbutr		=	1	; else	category_peanbutr		=	0;
if category="photo"			then		category_photo		=	1	; else	category_photo		=	0;
if category="saltsnck"			then		category_saltsnck		=	1	; else	category_saltsnck		=	0;
if category="shamp"			then		category_shamp		=	1	; else	category_shamp		=	0;
if category="soup"			then		category_soup		=	1	; else	category_soup		=	0;
if category="spagsauc"			then		category_spagsauc		=	1	; else	category_spagsauc		=	0;
if category="sugarsub"			then		category_sugarsub		=	1	; else	category_sugarsub		=	0;
if category="toitisu"			then		category_toitisu		=	1	; else	category_toitisu		=	0;
if category="toothbr"			then		category_toothbr		=	1	; else	category_toothbr		=	0;
if category="toothpa"			then		category_toothpa		=	1	; else	category_toothpa		=	0;
if category="yogurt"			then		category_yogurt		=	1	; else	category_yogurt		=	0;



run ;
proc model data= xx2 ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 
improvement_&string1= int  +     

	a1	*	 Factor1  +
	a2	*	 factor2  +
	a3	*	 factor3  +
	a4	*	 factor4  +
	a5	*	 factor5   + 

b1	*	category_beer		+
b2	*	category_blades		+
b3	*	category_carbbev		+
b4	*	category_cigets		+
b5	*	category_coffee		+
b6	*	category_coldcer		+
b7	*	category_deod		+
b8	*	category_factiss		+
b9	*	category_fzdinent		+
b10	*	category_fzpizza		+
b11	*	category_hhclean		+
b12	*	category_hotdog		+
b13	*	category_laundet		+
b14	*	category_margbutr		+
b15	*	category_mayo		+
b16	*	category_milk		+
b17	*	category_mustketc		+
b18	*	category_peanbutr		+
b19	*	category_photo		+
b20	*	category_saltsnck		+
b21	*	category_shamp		+
b22	*	category_soup		+
b23	*	category_spagsauc		+
b24	*	category_sugarsub		+
b25	*	category_toitisu		+
b26	*	category_toothbr		+
b27	*	category_toothpa	 
			; /* NOTICE, here we need to include potential '+' in the core_string variable, 
				just in case the core_string does not contain any variable (so we remove the + symbol) */
	 
    fit improvement_&string1
             /  white  outresid  outall 
							  out=model_adl 
							  outest=parms  ; 
	ods  output parameterestimates= pvalues residsummary= stat;
	   	run;
	ods listing ;
quit ;
 
data pvalues_&string1._&measure._&horizon (rename = ( Parameter= parm_&string1._&measure  estimate= estimate_&string1._&measure  Probt= probt_&string1._&measure  )) ;
	set pvalues ;
	keep Parameter estimate Probt  ;

data all_&horizon ;
	set pvalues_&string1._&measure._&horizon ;
run ;

%mend ;


 /* part 1: the "improvement " by the ewc model compared to the adl model */


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

	data t_all_ewc ;
		merge t1 t2 t3 t4 t5 t6 t7 t8 t9 ;
		by parm ;
	run ;
 
 
 /* part 2: the "improvement " by the IC model compared to the adl model */


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
 
 /* part 3: the "improvement " by the IC model compared to the adl-own model */


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

 /* part 4: the "improvement " by the EWC model compared to the adl-own model */
 
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
 /* part 5: the "improvement " by the EWC-IC model compared to the adl-intra model */


	%dooall0(ew_ic, smape, improvement_ew_ic, 8);
	%dooall0(ew_ic, smape, improvement_ew_ic, 4);
	%dooall0(ew_ic, smape, improvement_ew_ic, 1);

	%dooall0(ew_ic, mase, improvement_ew_ic, 8);
	%dooall0(ew_ic, mase, improvement_ew_ic, 4);
	%dooall0(ew_ic, mase, improvement_ew_ic, 1);

	%dooall0(ew_ic, mae, improvement_ew_ic, 8);
	%dooall0(ew_ic, mae, improvement_ew_ic, 4);
	%dooall0(ew_ic, mae, improvement_ew_ic, 1);

	%macro t1(model, measure, horizon, number) ;
	data t&number  ;
		set Pvalues_&model._&measure._&horizon ;
			rename parm_&model._&measure		= parm ;
			rename estimate_&model._&measure	= est_&model._&measure._&horizon ;
			rename probt_&model._&measure		= probt_&model._&measure._&horizon ;
	 run ;
	 %mend ;
	%t1(ew_ic,mae,1, 1) ;
	%t1(ew_ic,mae,4, 2) ;
	%t1(ew_ic,mae,8, 3) ;
	%t1(ew_ic,mase,1, 4) ;
	%t1(ew_ic,mase,4, 5) ;
	%t1(ew_ic,mase,8, 6) ;
	%t1(ew_ic,smape,1, 7) ;
	%t1(ew_ic,smape,4, 8) ;
	%t1(ew_ic,smape,8, 9) ;

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

	data t_all_ew_ic ;
		merge t1 t2 t3 t4 t5 t6 t7 t8 t9 ;
		by parm ;
	run ;

