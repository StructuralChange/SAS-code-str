options nonotes nosource ;
* this macro implement data imputation for all the categories ;
%macro implement1 ;
	%include 'Q:\= IRI data research\== IRI code 3 data imputation\code 3.1_data imputation.sas' ;run ;
%mend ;

 

%let target_category= data1.Data_groc_beer  	 ; %let target1= data2.Data_groc_beer  ; %implement1 ;

%let target_category= data1.Data_groc_carbbev	 ; %let target1= data2.Data_groc_carbbev	 ; %implement1 ;
%let target_category= data1.Data_groc_blades 	 ; %let target1= data2.Data_groc_blades 	 ; %implement1 ;
%let target_category= data1.Data_groc_cigets 	 ; %let target1= data2.Data_groc_cigets 	 ; %implement1 ;
%let target_category= data1.Data_groc_coffee 	 ; %let target1= data2.Data_groc_coffee 	 ; %implement1 ;

%let target_category= data1.Data_groc_coldcer	 ; %let target1= data2.Data_groc_coldcer     ; %implement1 ;
%let target_category= data1.Data_groc_deod 		 ; 	%let target1= data2.Data_groc_deod  	 ; %implement1 ;
/* %let target_category= data1.Data_groc_diapers  ; %let target1= data2.Data_groc_diapers  	 ; %implement1 ; too many slow movers */ 
%let target_category= data1.Data_groc_factiss 	 ; %let target1= data2.Data_groc_factiss 	 ; %implement1 ;
%let target_category= data1.Data_groc_fzdinent	 ; %let target1= data2.Data_groc_fzdinent 	 ; %implement1 ;

%let target_category= data1.Data_groc_fzpizza	 ; %let target1= data2.Data_groc_fzpizza	 ; %implement1 ;
%let target_category= data1.Data_groc_hhclean 	 ; %let target1= data2.Data_groc_hhclean 	 ; %implement1 ;
%let target_category= data1.Data_groc_hotdog 	 ; %let target1= data2.Data_groc_hotdog 	 ; %implement1 ;
%let target_category= data1.Data_groc_laundet  	 ; %let target1= data2.Data_groc_laundet 	 ; %implement1 ;
%let target_category= data1.Data_groc_margbutr 	 ; %let target1= data2.Data_groc_margbutr 	 ; %implement1 ;

%let target_category= data1.Data_groc_mayo  	 ; %let target1= data2.Data_groc_mayo  		 ; %implement1 ;
%let target_category= data1.Data_groc_milk 		 ; %let target1= data2.Data_groc_milk 		 ; %implement1 ;
%let target_category= data1.Data_groc_mustketc   ; %let target1= data2.Data_groc_mustketc    ; %implement1 ;
%let target_category= data1.Data_groc_paptowl 	 ; %let target1= data2.Data_groc_paptowl 	 ; %implement1 ;
%let target_category= data1.Data_groc_peanbutr	 ; %let target1= data2.Data_groc_peanbutr	 ; %implement1 ;

%let target_category= data1.Data_groc_photo 	 ; %let target1= data2.Data_groc_photo 			 ; %implement1 ;
%let target_category= data1.Data_groc_razors 	 ; %let target1= data2.Data_groc_razors  		 ; %implement1 ;
%let target_category= data1.Data_groc_saltsnck   ; %let target1= data2.Data_groc_saltsnck 		 ; %implement1 ;
%let target_category= data1.Data_groc_shamp 	 ; %let target1= data2.Data_groc_shamp 			 ; %implement1 ;
%let target_category= data1.Data_groc_soup		 ; %let target1= data2.Data_groc_soup 			 ; %implement1 ;

%let target_category= data1.Data_groc_spagsauc	 ; %let target1= data2.Data_groc_spagsauc 		 ; %implement1 ;
%let target_category= data1.Data_groc_sugarsub 	 ; %let target1= data2.Data_groc_sugarsub 		 ; %implement1 ;
%let target_category= data1.Data_groc_toitisu    ; %let target1= data2.Data_groc_toitisu 		 ; %implement1 ;
%let target_category= data1.Data_groc_toothbr 	 ; %let target1= data2.Data_groc_toothbr 		 ; %implement1 ;
%let target_category= data1.Data_groc_toothpa 	 ; %let target1= data2.Data_groc_toothpa 		 ; %implement1 ;

%let target_category= data1.Data_groc_yogurt 	 ; %let target1= data2.Data_groc_yogurt  		 ; %implement1 ;

  

 
 

