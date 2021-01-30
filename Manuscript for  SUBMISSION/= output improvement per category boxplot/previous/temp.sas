
options nonotes nosource ;
ods html;


%macro alll0 (model) ;
	data aa_&model  (rename= (&model = results )) ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		length model $ 30;
		model="&model" ;
		keep sku category   &model  model ;
			if  category= 	saltsnck then delete ;
		if  category= 	beer	 then delete ;

		if  category= 	blades	 then delete ;
		if  category= 	cigets	 then delete ;
		if  category= 	coffee	 then delete ;
		if  category= 	coldcer	 then delete ;
		if  category= 	deod	 then delete ; 


		if  category= 	factiss	 then delete ;
		if  category= 	soup	 then delete ;
		if  category= 	hotdog	 then delete ;
		if  category= 	fzdinent then delete ;
		if  category= 	carbbev	 then delete ;
		if  category= 	fzpizza	 then delete ;
		if  category= 	toothbr	 then delete ;
	 
	 	if  category= 	photo	 then delete ; 



	 

		if  category= 	laundet	 then delete ;
		if  category= 	margbutr then delete ;
		if  category= 	mayo	 then delete ;
		if  category= 	milk	 then delete ;
		if  category= 	mustketc then delete ;
		if  category= 	peanbutr then delete ;

	 
		if  category= 	shamp	 then delete ;
		
	 
		if  category= 	sugarsub then delete ;
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
			if  category= 	saltsnck then delete ;
	if  category= 	beer	 then delete ;

	if  category= 	blades	 then delete ;
	if  category= 	cigets	 then delete ;
	if  category= 	coffee	 then delete ;
	if  category= 	coldcer	 then delete ;
	if  category= 	deod	 then delete ; 


	if  category= 	factiss	 then delete ;
	if  category= 	soup	 then delete ;
	if  category= 	hotdog	 then delete ;
	if  category= 	fzdinent then delete ;
	if  category= 	carbbev	 then delete ;
	if  category= 	fzpizza	 then delete ;
	if  category= 	toothbr	 then delete ;
 
 	if  category= 	photo	 then delete ; 



 

	if  category= 	laundet	 then delete ;
	if  category= 	margbutr then delete ;
	if  category= 	mayo	 then delete ;
	if  category= 	milk	 then delete ;
	if  category= 	mustketc then delete ;
	if  category= 	peanbutr then delete ;

 
	if  category= 	shamp	 then delete ;
	
 
	if  category= 	sugarsub then delete ;
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
 

	data aa_improve_ADL_intra_ic  ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		improve_&measure._ADL_intra_ic= (adl4- ad4_ic)/ad4_ic ;
		keep sku category improve_&measure._ADL_intra_ic ;
	run ;

	data aa_improve_ADL_intra_ew  ;
		set rank_0.All_comparison_all_&horizon._&measure ;
		improve_&measure._ADL_intra_ew= (adl4- ad4_ew)/ad4_ew ;
		keep sku category improve_&measure._ADL_intra_ew ;
	run ;

proc sort data= Aa_improve_ADL_intra_ic ;
	by category  sku  ;
proc sort data= Aa_improve_ADL_intra_ew ;
	by category  sku ;
run ;
data both ;
	merge Aa_improve_ADL_intra_ic Aa_improve_ADL_intra_ew ;
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
data mean_2_ew_&horizon (rename= (mean= mean_category)) ;
	set mean_1_ew ;
	order= _n_ ;
run;
proc sort data= mean_2_ew_&horizon ;
	by  categories ;
run ;

data use_ew_&horizon ;
	merge Aa_improve_adl_intra_ew mean_2_ew_8 ;/* here we stick to the order defined by h=8 */
	by categories ;
run ;
proc sort data= use_ew_&horizon ;
	by order ;
run ;


/* ewc */
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
data mean_2_ic_&horizon (rename= (mean= mean_category)) ;
	set mean_1_ic ;
	order= _n_ ;
run;
proc sort data= mean_2_ic_&horizon ;
	by  categories ;
run ;

data use_ic_&horizon ;
	merge Aa_improve_adl_intra_ic mean_2_ic_8 ; /* here we stick to the order defined by h=8 */
	by categories ;
run ;
proc sort data= use_ic_&horizon ;
	by order ;
run ;








/******* boxplot */
 data use_ic_&horizon ;
	set use_ic_&horizon ;
	if categories= "Paper Towels" then delete ;
	if categories= "Razors"  then delete ;
	 
run ;  
proc boxplot data=use_ic_&horizon ;
   plot improve_&measure._ADL_intra_ic*categories /
      boxstyle  = schematicid boxwidthscale = 0.1 clipfactor = 3
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
      boxstyle = skeletal  boxwidthscale = 0.1 clipfactor = 3
       vREF= 0
	   cvREF=red 
      bwslegend
	 boxconnect=mean
 
 horizontal
  ;
;

run ;
quit ;
%mend ;
 


/* in use */
/* 

%let horizon=8 ;
%let measure=mase ;
*/
 
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
*/
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
