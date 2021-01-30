options nonotes nosource ;
proc printto  ; run;
%include "Q:\= IRI data research\== External macros\code x count rows and columns.sas" ; run ;
 


/* %let category=blade ;*/


%macro extract_sku_numbers ;
	** step 0, we extract the sku numbers from the original dataset, e.g. 21, 28 et al. from the beer category, and 
	we then code to organize the error measure results based on their sku numbers ;
	* step 0.1, we extract the unit sales ;
	data Data_groc_&category ;
		set data4.Data_groc_&category ;
		keep  logs_1- logs_2200 ;
		if week< 2 ;* week 1322 is the first week in year 5 ;
	run ;
	* we organize the dataset by transposing them ;
	proc transpose data= Data_groc_&category out=Data_groc_&category ;
	run ;
	* now we store the SKU numbers into macro variables ; 
	data temp ;
		set Data_groc_&category ;
		i= _n_ ;
		retail_list= compress(_name_,"logs_");
		retail_list_numeric= input( retail_list, 12.) ;
		call symput('results_sku'||strip(i),retail_list_numeric);
	run ;
	 
	%obsnvars(temp) ;
	**  %put &dset has &nvars variable(s) and &nobs observation(s).;

%mend ;





 
%macro error1 (category ) ;
	%extract_sku_numbers ;
	%include "Q:\= IRI data research\== IRI code 12 measures for category char\Code evaluation 2 error measure &tune..sas" ; 
	%calculate_&measure ; run ;
%mend ;


%macro con1  ;
	data &output_category..R_h&horizon._allcat_&measure._&model._&tune ;
		set  	Results_beer_&measure._&model 
 
 
			 
		
			  Results_carbbev_&measure._&model
			Results_blades_&measure._&model
			Results_cigets_&measure._&model
			Results_coffee_&measure._&model
			Results_coldcer_&measure._&model
			Results_deod_&measure._&model
			Results_factiss_&measure._&model
			Results_fzdinent_&measure._&model
			Results_fzpizza_&measure._&model
			Results_hhclean_&measure._&model
			Results_hotdog_&measure._&model
			Results_laundet_&measure._&model
			Results_margbutr_&measure._&model
			Results_mayo_&measure._&model
			Results_milk_&measure._&model
			Results_mustketc_&measure._&model
			Results_peanbutr_&measure._&model
			Results_photo_&measure._&model 
			 
			Results_saltsnck_&measure._&model
			Results_shamp_&measure._&model
			Results_soup_&measure._&model
			Results_spagsauc_&measure._&model
			Results_sugarsub_&measure._&model
			Results_toitisu_&measure._&model
			Results_toothbr_&measure._&model
			Results_toothpa_&measure._&model 
			Results_yogurt_&measure._&model 

		 
	;
 
	run ;
 

%mend ;


  






