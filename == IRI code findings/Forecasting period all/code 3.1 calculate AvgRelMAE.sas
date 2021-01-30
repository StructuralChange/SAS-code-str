options nonotes nosource ;
*calculating AvgRelMAE ;


 
/*

%let limit_horizon= %str(if horizon>12 then delete ; ) ; * this include the forecast horizons from 1 to 12 ;
%global limit_horizon ;
%put &limit_horizon ;
%let roll=1 ;
%let benchmark=base ;
%let horizon=12 ;
%let model=adl ;
*/


* Candidate ;
%macro produce0( horizon, model, benchmark, category, sku, roll) ;
data candidate_&category._&sku ;
	set r_&model..cat_&category._&sku ;
	if roll=&roll ;
	&limit_horizon ;
proc means data= candidate_&category._&sku mean noprint ;
	var ae ;
	output out= candidate_&category._&sku._mae mean=mae_candidate ;
run ;
data candidate_&category._&sku._mae ;
	set candidate_&category._&sku._mae ;
	format category $20. ;
	drop _type_ _freq_ ;
	roll=&roll ;
	sku=&sku ;
	category="&category" ;
	horizon=&horizon ;
run ;

*benchmark ;
data bchmk_&category._&sku ;
	set r_&benchmark..Cat_&category._&sku ;
	if roll=&roll ;
	&limit_horizon ;
proc means data= bchmk_&category._&sku mean noprint ;
	var ae ;
	output out= bchmk_&category._&sku._mae mean=mae_bchmk ;
run ;
data bchmk_&category._&sku._mae ;
	set bchmk_&category._&sku._mae ;
	format category $20. ;
	drop _type_ _freq_ ;
	roll=&roll ;
	sku=&sku ;
	category="&category" ;
	horizon=&horizon ;
run ;



%mend ;




%macro produce1( horizon, model, benchmark, category, sku, roll) ;
data candidate_&category._&sku. ;
	set r_&model..Cat_&category._&sku ;
	if roll=&roll ;
	&limit_horizon ;
proc means data= candidate_&category._&sku mean noprint ;
	var ae ;
	output out= candidate_&category._&sku._mae mean=mae_candidate ;
run ;
data candidate_&category._&sku._mae ;
	set candidate_&category._&sku._mae ;
	format category $20. ;
	drop _type_ _freq_ ;
	roll=&roll ;
	sku=&sku ;
	category="&category" ;
	horizon=&horizon ;
run ;

*benchmark ;
data bchmk_&category._&sku. ;
	set r_&benchmark..Cat_&category._&sku ;
	if roll=&roll ;
	&limit_horizon ;
proc means data= bchmk_&category._&sku. mean noprint ;
	var ae ;
	output out= bchmk_&category._&sku._mae mean=mae_bchmk ;
run ;
data bchmk_&category._&sku._mae ;
	set bchmk_&category._&sku._mae ;
	format category $20. ;
	drop _type_ _freq_ ;
	roll=&roll ;
	sku=&sku ;
	category="&category" ;
	horizon=&horizon ;
run ;

data all_bchmk ;
	set all_bchmk bchmk_&category._&sku._mae ; 
data all_candidate ;
	set all_candidate candidate_&category._&sku._mae ; 
run ;
 
proc delete data= bchmk_&category._&sku._mae ;
proc delete data= candidate_&category._&sku._mae ;
proc delete data= bchmk_&category._&sku ;
proc delete data= candidate_&category._&sku ;
run ;
 
%mend ;

%let number=&roll ;
%produce0( &horizon, &model, &benchmark ,beer,21,&number);


data all_bchmk ;
	set Bchmk_beer_21_mae ; 
data all_candidate ;
	set Candidate_beer_21_mae ; 
run ;
 


%produce1( &horizon, &model, &benchmark ,beer,28,&number);
%produce1( &horizon, &model, &benchmark ,beer,35,&number);

%produce1( &horizon, &model, &benchmark ,beer,38,&number);
%produce1( &horizon, &model, &benchmark ,beer,42,&number);
%produce1( &horizon, &model, &benchmark ,beer,50,&number);
%produce1( &horizon, &model, &benchmark ,beer,106,&number);
%produce1( &horizon, &model, &benchmark ,beer,130,&number);
%produce1( &horizon, &model, &benchmark ,beer,160,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,2,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,9,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,15,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,17,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,19,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,26,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,29,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,32,&number);
%produce1( &horizon, &model, &benchmark ,carbbev,43,&number);
%produce1( &horizon, &model, &benchmark ,coffee,92,&number);
%produce1( &horizon, &model, &benchmark ,coffee,138,&number);
%produce1( &horizon, &model, &benchmark ,coffee,247,&number);
%produce1( &horizon, &model, &benchmark ,coffee,250,&number);
%produce1( &horizon, &model, &benchmark ,coffee,253,&number);
%produce1( &horizon, &model, &benchmark ,coffee,255,&number);
%produce1( &horizon, &model, &benchmark ,coffee,294,&number);
%produce1( &horizon, &model, &benchmark ,coffee,329,&number);
%produce1( &horizon, &model, &benchmark ,coffee,381,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,126,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,149,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,210,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,212,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,215,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,217,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,220,&number);
%produce1( &horizon, &model, &benchmark ,fzpizza,236,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,26,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,183,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,222,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,223,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,256,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,288,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,376,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,399,&number);
%produce1( &horizon, &model, &benchmark ,hhclean,402,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,20,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,43,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,91,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,98,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,101,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,109,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,145,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,161,&number);
%produce1( &horizon, &model, &benchmark ,hotdog,176,&number);
%produce1( &horizon, &model, &benchmark ,laundet,75,&number);
%produce1( &horizon, &model, &benchmark ,laundet,116,&number);
%produce1( &horizon, &model, &benchmark ,laundet,182,&number);
%produce1( &horizon, &model, &benchmark ,laundet,434,&number);
%produce1( &horizon, &model, &benchmark ,laundet,440,&number);
%produce1( &horizon, &model, &benchmark ,laundet,562,&number);
%produce1( &horizon, &model, &benchmark ,laundet,565,&number);
%produce1( &horizon, &model, &benchmark ,laundet,660,&number);
%produce1( &horizon, &model, &benchmark ,laundet,680,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,13,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,19,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,36,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,38,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,39,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,88,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,131,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,144,&number);
%produce1( &horizon, &model, &benchmark ,margbutr,158,&number);
%produce1( &horizon, &model, &benchmark ,mayo,2,&number);
%produce1( &horizon, &model, &benchmark ,mayo,9,&number);
%produce1( &horizon, &model, &benchmark ,mayo,10,&number);
%produce1( &horizon, &model, &benchmark ,mayo,22,&number);
%produce1( &horizon, &model, &benchmark ,mayo,28,&number);
%produce1( &horizon, &model, &benchmark ,mayo,31,&number);
%produce1( &horizon, &model, &benchmark ,mayo,33,&number);
%produce1( &horizon, &model, &benchmark ,mayo,36,&number);
%produce1( &horizon, &model, &benchmark ,mayo,40,&number);
%produce1( &horizon, &model, &benchmark ,mustketc,1,&number);
%produce1( &horizon, &model, &benchmark ,mustketc,9,&number);
%produce1( &horizon, &model, &benchmark ,mustketc,22,&number);
%produce1( &horizon, &model, &benchmark ,mustketc,30,&number);
%produce1( &horizon, &model, &benchmark ,mustketc,59,&number);
%produce1( &horizon, &model, &benchmark ,mustketc,62,&number);
%produce1( &horizon, &model, &benchmark ,mustketc,70,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,8,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,9,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,11,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,15,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,17,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,24,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,28,&number);
%produce1( &horizon, &model, &benchmark ,peanbutr,30,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,117,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,162,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,545,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,603,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,1161,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,1276,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,1510,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,1521,&number);
%produce1( &horizon, &model, &benchmark ,saltsnck,1539,&number);
%produce1( &horizon, &model, &benchmark ,soup,86,&number);
%produce1( &horizon, &model, &benchmark ,soup,279,&number);
%produce1( &horizon, &model, &benchmark ,soup,300,&number);
%produce1( &horizon, &model, &benchmark ,soup,306,&number);
%produce1( &horizon, &model, &benchmark ,soup,308,&number);
%produce1( &horizon, &model, &benchmark ,soup,311,&number);
%produce1( &horizon, &model, &benchmark ,soup,314,&number);
%produce1( &horizon, &model, &benchmark ,soup,316,&number);
%produce1( &horizon, &model, &benchmark ,soup,318,&number);
%produce1( &horizon, &model, &benchmark ,sugarsub,8,&number);
%produce1( &horizon, &model, &benchmark ,sugarsub,10,&number);
%produce1( &horizon, &model, &benchmark ,sugarsub,15,&number);
%produce1( &horizon, &model, &benchmark ,sugarsub,29,&number);
%produce1( &horizon, &model, &benchmark ,sugarsub,34,&number);
%produce1( &horizon, &model, &benchmark ,sugarsub,40,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,118,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,164,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,174,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,276,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,437,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,440,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,540,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,546,&number);
%produce1( &horizon, &model, &benchmark ,toothpa,615,&number);


proc sort data= all_bchmk ;
	by roll category sku ;
proc sort data= all_candidate ;
	by roll category sku ;
run ;


* merge ;
data comparison ;
	merge all_bchmk all_candidate ;
	by roll category sku ;
	r_i= mae_candidate/mae_bchmk ;
	r_i_n= r_i**horizon ;
run ;

data results ;
	set comparison ;
	if _n_=1 then temp1= r_i_n ;
	if _n_=1 then temp2= temp1 ;
		else temp2= temp2*r_i_n ;
	retain temp2 ;
	drop temp1 ;
run ;

data results2 ;
	set results ;
	sum_n_i=horizon*&number_of_sku ; * we have 127 data series (skus) ;
	avg_rel_mae= temp2**(1/sum_n_i) ;
run ;


/* 
%let model=own ;
%let benchmark=base ;
%let horizon=12 ;


*/


data Armae_&model._vs_&benchmark._h&horizon._r&roll ;
	set results2 ;
	if _n_=&number_of_sku ; /* this is the last observation in the dataset, this shall be equal to the number of the SKUs */
	 benchmark="&benchmark" ;
	 model="&model" ;
	 horizon=&horizon ;
	 roll=&roll ;

	keep avg_rel_mae benchmark model horizon roll ;

run ;
/*
 








*/ 

