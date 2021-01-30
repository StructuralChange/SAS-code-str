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
	%include "Q:\= IRI data research\== IRI code 9 organizing results 2 calculate error measures\EWC_IC generate results\Code X evaluation error measure all - IC EWC combine.sas" ; 
	%produce1 ; run ;
%mend ;

 
  






