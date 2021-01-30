
options nonotes nosource ;
ods html;

/* average_pct_improve_ewc and average_pct_improve_ic contains the information for the average value of the MASE for each category */
%macro alll0 (model) ;
	data aa_&model  (rename= (&model = results )) ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		length model $ 30;
		model="&model" ;
		keep sku category   &model  model ;
	run ;
 
 data all ;
 	set aa_&model ;
run ;
%mend ;
 
%macro alll (model) ;
	data aa_&model  (rename= (&model = results )) ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		length model $ 30;
		model="&model" ;
		keep sku category   &model  model ;
	run ;
 
 data all ;
 	set all aa_&model ;
run ;
%mend ;





%macro boxplotdraw (measure, horizon) ;

%alll0 (base) ;
%alll(own2) ;
%alll(adl4) ;
%alll(ow2_ew) ;
%alll(ow2_ic) ;
%alll(ad4_ew) ;
%alll(ad4_ic) ;
 %alll(ewc_ic) ;

	data aa_improve_ADL_intra_ic  ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		improve_&measure._ADL_intra_ic= (adl4- ad4_ic)/adl4 ;
		keep sku category improve_&measure._ADL_intra_ic ;
	run ;

	data aa_improve_ADL_intra_ew  ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		improve_&measure._ADL_intra_ew= (adl4- ad4_ew)/adl4 ;
		keep sku category improve_&measure._ADL_intra_ew ;
	run ;
	data aa_improve_ADL_ewc_ic  ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		improve_&measure._ADL_ewc_ic= (adl4- ewc_ic)/adl4 ;
		keep sku category improve_&measure._ADL_ewc_ic ;
	run ;




proc sort data= Aa_improve_ADL_intra_ic ;
	by category  sku  ;
proc sort data= Aa_improve_ADL_intra_ew ;
	by category  sku ;
proc sort data= Aa_improve_ADL_ewc_ic ;
	by category  sku ;
run ;
data both ;
	merge Aa_improve_ADL_intra_ic Aa_improve_ADL_intra_ew Aa_improve_ADL_ewc_ic ;
	by category sku ;
run ;



data temp ;
	set data1.category_names ;
	rename category= new ;
	rename old= category ;
run ;
 




proc sort data= temp ;
	by category ;
run ;
data aa_improve_ADL_intra_ic (rename= (new= Categories) ) ;;
	merge aa_improve_ADL_intra_ic temp ;
	by category ;
	drop category ;
run ;
data aa_improve_ADL_intra_ew (rename= (new= Categories) ) ;
	merge aa_improve_ADL_intra_ew temp ;
	by category ;
	drop category ;
run ;
data aa_improve_ADL_ewc_ic (rename= (new= Categories) ) ;
	merge aa_improve_ADL_ewc_ic temp ;
	by category ;
	drop category ;
run ;
data both1 (rename= (new= Categories) ) ;
	merge both temp ;
	by category ;
	drop category ;
run ;



/* ewc */
proc sort data= Aa_improve_adl_intra_ew ;
	by categories ;
proc means data= Aa_improve_adl_intra_ew mean noprint ;
	var improve_&measure._ADL_intra_ew ;
	by categories ;
	output out= mean_1_ew mean= mean ;
run ;

proc sort data= mean_1_ew ;
	by  descending mean;
run ;

data mean_1_ew ;
	set mean_1_ew ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
	 
run;


data mean_2_ew_&horizon (rename= (mean= mean_category)) ;
	set mean_1_ew ;
	order= _n_ ;
	if _n_>6 then delete ; /*here we only choose to illustrate the 20% top categories */
run;
proc sort data= mean_2_ew_&horizon ;
	by  order ;
run ;

data use_ew_&horizon ;
	merge Aa_improve_adl_intra_ew mean_2_ew_8 ;/* here we stick to the order defined by h=8 */
	by categories ;
	if mean_category=. then delete ;/*here we only choose to illustrate the 20% top categories */
run ;
proc sort data= use_ew_&horizon ;
	by order ;
run ;


/* ic */
proc sort data= Aa_improve_adl_intra_ic ;
	by categories ;
proc means data= Aa_improve_adl_intra_ic mean noprint ;
	var improve_&measure._ADL_intra_ic ;
	by categories ;
	output out= mean_1_ic mean= mean ;
run ;

proc sort data= mean_1_ic ;
	by  descending mean;
run ;

data mean_1_ic ;
	set mean_1_ic ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
	 
run;



data mean_2_ic_&horizon (rename= (mean= mean_category)) ;
	set mean_1_ic ;
	order= _n_ ;
	if _n_>6 then delete ; /*here we only choose to illustrate the 20% top categories */
run;
proc sort data= mean_2_ic_&horizon ;
	by order ;
run ;

data use_ic_&horizon ;
	merge Aa_improve_adl_intra_ic mean_2_ic_8 ; /* here we stick to the order defined by h=8 */
	by categories ;
	if mean_category=. then delete ;/*here we only choose to illustrate the 20% top categories */
run ;
proc sort data= use_ic_&horizon ;
	by order ;
run ;

 

/* ewc_ic */
/*
proc sort data= Aa_improve_adl_ewc_ic ;
	by categories ;
proc means data= Aa_improve_adl_ewc_ic mean noprint ;
	var improve_&measure._ADL_ewc_ic ;
	by categories ;
	output out= mean_1_ewc_ic mean= mean ;
run ;

proc sort data= mean_1_ewc_ic ;
	by  descending mean;
run ;

data mean_1_ewc_ic ;
	set mean_1_ewc_ic ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
	 
run;



data mean_2_ewc_ic_&horizon (rename= (mean= mean_category)) ;
	set mean_1_ewc_ic ;
	order= _n_ ;
	if _n_>6 then delete ; /*here we only choose to illustrate the 20% top categories */
/*
run;
proc sort data= mean_2_ewc_ic_&horizon ;
	by  categories ;
run ;
/*
data use_ewc_ic_&horizon ;
	merge Aa_improve_adl_ewc_ic mean_2_ewc_ic_8 ; /* here we stick to the order defined by h=8 *//*
	by categories ;
	if mean_category=. then delete ;/*here we only choose to illustrate the 20% top categories */
/*
run ;
proc sort data= use_ewc_ic_&horizon ;
	by order ;
run ;

*/



/******* boxplot */
 data use_ic_&horizon ;
	set use_ic_&horizon ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
	 
run ;  
proc boxplot data=use_ic_&horizon ;
   plot improve_&measure._ADL_intra_ic*categories /
      boxstyle  = schematicid boxwidthscale = 1  
      nohlabel
	  vREF= 0
	  cvREF=red 
      bwslegend
	 horizontal 
 	 boxconnect=mean
    ; /* the width of the plot is proporitionate to log(n) */
   
run;

  
 run ;

 
 
 data use_ew_&horizon ;
	set use_ew_&horizon ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
	 
run ;
 
proc boxplot data=use_ew_&horizon ;
   plot improve_&measure._ADL_intra_ew *categories /
      boxstyle = skeletal  boxwidthscale = 1  
       vREF= 0
	   cvREF=red 
      bwslegend
	 boxconnect=mean
 
 horizontal
  ;
;

run ;


/*

 
 data use_ewc_ic_&horizon ;
	set use_ewc_ic_&horizon ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
	 
run ;
 
proc boxplot data=use_ewc_ic_&horizon ;
   plot improve_&measure._ADL_ewc_ic *categories /
      boxstyle = skeletal  boxwidthscale = 0.1  
       vREF= 0
	   cvREF=red 
      bwslegend
	 boxconnect=mean
 
 horizontal
  ;
;

run ;



*/

quit ;
%mend ;
 


/* in use */
 
%boxplotdraw (mase,8);

/*
%boxplotdraw (mase,4);
%boxplotdraw (mase,1);


%boxplotdraw (smape,8);
%boxplotdraw (smape,4);
%boxplotdraw (smape,1);


%boxplotdraw (MAE,8);
%boxplotdraw (MAE,4);
%boxplotdraw (MAE,1);

data t_ew ;
	set Mean_1_ew ;
	rename mean = mean_ew ;
proc sort data = t_ew ;
	by categories ;
data t_ic ;
	set Mean_1_ic ;
	rename mean = mean_ic ;
proc sort data = t_ic ;
	by categories ;
run ;

data t_both ;
	merge t_ew t_ic ;
	by categories ;
run ;
*/

data average_pct_improve_ic ;
	set Mean_1_ic ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
proc sort data = average_pct_improve_ic ;
	by category ;
data average_pct_improve_ewc ;
	set Mean_1_ew ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
proc sort data = average_pct_improve_ewc ;
	by category ;
run ;





* %let horizon=8 ;
