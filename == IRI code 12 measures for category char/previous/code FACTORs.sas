options nonotes nosource ;


 
/* part 1/2, std */
/* this macro re-arrange the results ;*/
%macro construct_variable (variable) ;
	proc means data= std_&variable._&category std noprint ;
		output out= x1   ;
	run ;
	data x1 ;
		set x1 ;
		if _stat_="STD" ;
	run ;
	proc transpose data= x1 out=x1 ;
	run ;
	data x1 ;
		set x1 ;
		if col1=0 then delete ;
		if _name_="_TYPE_" then delete ;
		if _name_="_FREQ_" then delete ;
		rename col1 = var ;
	run ;
	proc transpose data= std_&variable._&category out=y1 ;
	run ;
	proc sort data= y1 ;
		by _name_ ;
	proc sort data= x1 ;
		by _name_ ;
	run ;
	data z1 ;
		merge y1 x1 ;
		by _name_ ;
		if var="" then delete ;
		drop var ;
	run ;
	proc transpose data= z1 out=z1 ;
	run ;
	data std_&variable._&category ;
		set z1 ;
		drop _name_ ;
	run ;
%mend ;
/* this macro standardizes the data for a category ;*/
%macro standizing1 (category)  ;
	data logp_&category ;
		set data4_f._cleaned_data_groc_&category ;
		keep  logp_1- logp_2000 ;
	data f_&category ;
		set data4_f._cleaned_data_groc_&category ;
		keep  f_1- f_2000 ;
	data d_&category ;
		set data4_f._cleaned_data_groc_&category ;
		keep  d_1- d_2000 ;
	run ;
	proc stdize data= logp_&category 	out= std_logp_&category ; run ;
	proc stdize data= f_&category 		out= std_f_&category ; run ;
	proc stdize data= d_&category 		out= std_d_&category ;
	run ;

	%construct_variable (logp) ;
	%construct_variable (f) ;
	%construct_variable (d) ;

	proc delete data= x1 ;
	proc delete data= y1 ;
	proc delete data= z1 ;
	run ;
 

%mend ;

%macro standizing1_cig (category)  ;
	data logp_&category ;
		set data4_f._cleaned_data_groc_&category ;
		keep  logp_1- logp_2000 ;
 
	proc stdize data= logp_&category 	out= std_logp_&category ; run ;
 

	%construct_variable (logp) ;
 

	proc delete data= x1 ;
	proc delete data= y1 ;
	proc delete data= z1 ;
	run ;
 

%mend ;
 
/* part 2/2, conduct PCA ;
/* in this macro we arbitrarily construct n factors for logp, f, and d, for each category ;
 * the following macro conduct the factor analysis;*/

%macro pca2_2(category, variable, nn ) ;
	   ods graphics on;
	   title3 'Principal Component Factor Analysis with Varimax Rotation';
	   proc factor data= std_&variable._&category    
	      msa residual corr scree  PRIORS=MAX
		  method = ml
	      rotate = varimax reorder
		  NFACTORS= &nn

	      outstat=  fact_all_&variable._&category 
		  score 
		  ;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	ods output  orthrotfactpat=  rotfactpattern_&variable._&category 
				corr=  correlations_&variable._&category	
				Varexplain= Varexplain_&variable._&category
				finalcommun=  finalcommun_&variable._&category
				;
	   run;
	   	proc score  data= std_&variable._&category 
					score=  fact_all_&variable._&category 
					out=scores_&variable._&category ;
		run ;
	   ods graphics off;
%mend ;

/* the following macro change the name of the factor into the price/promotion diffusion indexes ;*/
%macro rename1    ;
	data scores_logp_&category ;
		set scores_logp_&category ;
			%do i= 1 %to &nfactors_logp ;
				rename factor&i = factor_logp_&i ;
			%end ;
			week= _n_+1113 ;
	data scores_logp_&category ;
		set scores_logp_&category ;
			keep week factor_logp_1- factor_logp_4 ; run ;
	data scores_f_&category ;
		set scores_f_&category ;
			%do i= 1 %to &nfactors_f ;
				rename factor&i = factor_f_&i ;
			%end ;
			week= _n_+1113 ;
	data scores_f_&category ;
		set scores_f_&category ;
			keep week factor_f_1- factor_f_4 ; run ;
	data scores_d_&category ;
		set scores_d_&category ;
			%do i= 1 %to &nfactors_d ;
				rename factor&i = factor_d_&i ;
			%end ;
			week= _n_+1113 ;
	data scores_d_&category ;
		set scores_d_&category ;
			keep week factor_d_1- factor_d_4 ;
	run ;
%mend ;
%macro rename1_cig    ;
	data scores_logp_&category ;
		set scores_logp_&category ;
			%do i= 1 %to &nfactors_logp ;
				rename factor&i = factor_logp_&i ;
			%end ;
			week= _n_+1113 ;
	data scores_logp_&category ;
		set scores_logp_&category ;
			keep week factor_logp_1- factor_logp_4 ; 
	run ;
	 
%mend ;



%macro producefactor (category) ;
	   %pca2_2 (&category, logp, &nfactors_logp) ;
	   %pca2_2 (&category,    d, &nfactors_d) ;	   
	   %pca2_2 (&category,    f, &nfactors_f) ;
	%rename1    ;
	data &target..data_factor_&category ;
		merge   data4.Data_groc_&category
				Scores_logp_&category
				Scores_f_&category
				Scores_d_&category ;
  
	run ;
	%macro delete1 (variable) ;
		proc delete data= Varexplain_&variable._&category ;
		proc delete data= correlations_&variable._&category ;
		proc delete data= fact_all_&variable._&category ;
		proc delete data= finalcommun_&variable._&category ;
		proc delete data= Rotfactpattern_&variable._&category ;

		proc delete data= Scores_&variable._&category ;
		proc delete data= std_&variable._&category ;
		proc delete data= &variable._&category ;
		run ;
	%mend ;
	%delete1 (logp) ;
	%delete1 (f) ;
	%delete1 (d) ;
%mend ;

%macro producefactor_cig (category) ;
	   %pca2_2 (&category, logp, &nfactors_logp) ;
	   /* %pca2_2 (&category,    d, &nfactors_d) ;	   
	   %pca2_2 (&category,    f, &nfactors_f) ; */
	%rename1_cig    ;
	data &target..data_factor_&category ;
		merge   data4.Data_groc_&category
				Scores_logp_&category
		 ;
  
	run ;
	%macro delete1 (variable) ;
		proc delete data= Varexplain_&variable._&category ;
		proc delete data= correlations_&variable._&category ;
		proc delete data= fact_all_&variable._&category ;
		proc delete data= finalcommun_&variable._&category ;
		proc delete data= Rotfactpattern_&variable._&category ;

		proc delete data= Scores_&variable._&category ;
		proc delete data= std_&variable._&category ;
		proc delete data= &variable._&category ;
		run ;
	%mend ;
	%delete1 (logp) ;
 
%mend ;




%let target= data4_f2 ;

 

 /* %let nfactors= 2 ;	%standizing1 (	Paptowl	) ; %producefactor (	Paptowl	 ) ; there are too few competitive variables for this category */
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;   %standizing1 (	beer	) ; %producefactor (	beer	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 2 ; %let nfactors_d= 4 ;	%standizing1 (	carbbev	) ; %producefactor (	carbbev	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 2 ; %let nfactors_d= 4 ;	%standizing1 (	blades	) ; %producefactor (	blades	 ) ;
%let nfactors_logp= 4 ;											 %standizing1_cig (	cigets	) ; %producefactor_cig (	cigets	 ) ;

%let nfactors_logp= 2 ; 	%standizing1_cig (	coffee	) ; %producefactor_cig (	coffee	 ) ;



%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	coldcer	) ; %producefactor (	coldcer	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 2 ;	%standizing1 (	deod	) ; %producefactor (	deod	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	factiss	) ; %producefactor (	factiss	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	fzdinent) ; %producefactor (	fzdinent ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	fzpizza	) ; %producefactor (	fzpizza	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	hhclean	) ; %producefactor (	hhclean	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	hotdog	) ; %producefactor (	hotdog	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	laundet	) ; %producefactor (	laundet	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	margbutr) ; %producefactor (	margbutr ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	mayo	) ; %producefactor (	mayo	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	milk	) ; %producefactor (	milk	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	mustketc) ; %producefactor (	mustketc ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	peanbutr) ; %producefactor (	peanbutr ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	photo	) ; %producefactor (	photo	 ) ;
/* %let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	razors	) ; %producefactor (	razors	 ) ; there are too few competitive variables for this category */
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	saltsnck) ; %producefactor (	saltsnck ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	shamp	) ; %producefactor (	shamp	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	soup	) ; %producefactor (	soup	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	spagsauc) ; %producefactor (	spagsauc ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	sugarsub) ; %producefactor (	sugarsub ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	toitisu	) ; %producefactor (	toitisu	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	toothbr	) ; %producefactor (	toothbr	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	toothpa	) ; %producefactor (	toothpa	 ) ;
%let nfactors_logp= 4 ;	%let nfactors_f= 4 ; %let nfactors_d= 4 ;	%standizing1 (	yogurt	) ; %producefactor (	yogurt	 ) ;

				









