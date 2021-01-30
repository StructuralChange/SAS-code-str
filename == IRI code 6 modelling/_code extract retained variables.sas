options nonotes nosource ;

 

%macro kk_model  ;

	 
		%global catstring_&skunumber ;
		/* we extract the variables from library data_v0, here we rearrange the retained dataset*/
		data temp_&skunumber ;
			set &var_library..Vs_&start._&end._&category._all ;
			keep r&skunumber ;
			if r&skunumber="" then delete ;
		run ;

 
 
	%obsnvars(temp_&skunumber) ;
/* we distinguish the cases depending on whether or not there are variables retained in the previous step (e.g., LASSO 10-fold selection) */
/* case 1: yes, so temp_&skunumber is not an empty dataset, then we do: */

				%macro concatenateparms1 ;
					/* %put &nobs "xxxxxx" ;*/
					 
						data temp_parm ;
							%do p= 1 %to &nobs ;
								length parm $ 10 ;
								parm= "parm&p.*" ;
								output ;
							%end ;
						run ;
						data temp_plus ;
								%do p= 1 %to %eval(&nobs-1) ;
								plus= "+" ;
								output ;
							%end ;
					 


						data string_for_proc_model ;
							merge temp_parm temp_&skunumber temp_plus ;
							string= parm|| r&skunumber || plus ;
							keep string ;
						run ;

					 
						/* then, for each SKU, we concatenate all their retained variables into strings */
						/* the following macro ONLY reads the variables and dimensions for this specfic SKU */
							data _null_ ;
									set string_for_proc_model  ;
									i= _n_ ;
									*sku_list= compress(_name_,"logs_");
									*sku_list_numeric= input(sku_list, 12.) ;
									call symput('explanotry_var'||strip(i),string);
									 
								run ;	

						
							%macro construct_string2   ;
								%global sku s_final     ;
								%do c2= 1 %to 1 ;
									%let sku= &&explanotry_var&c2 ;
									%let s_final=  &sku ;
								%end ;
							 	%do c2= 2 %to &nobs ;
									%let sku= &&explanotry_var&c2 ;
									%let s_final = &s_final &sku  ;
								%end ;	
							%mend ;
							%construct_string2 ;
							/* we concatenate the original retained variables and their corresponding lagged terms , plus the calendar effects*/
						%let catstring_&skunumber = %str(+) &s_final ;
							 	
 				%mend ;
/* case 1: no, but temp_&skunumber only contains 1 variable, then we do: */
%macro concatenateparms2 ;
					/* %put &nobs "xxxxxx" ;*/
					 
						data temp_parm ;
							%do p= 1 %to &nobs ;
								length parm $ 10 ;
								parm= "parm&p.*" ;
								output ;
							%end ;
						run ;
 
						data string_for_proc_model ;
							merge temp_parm temp_&skunumber   ;
							string= parm|| r&skunumber   ;
							keep string ;
						run ;

					 
						/* then, for each SKU, we concatenate all their retained variables into strings */
						/* the following macro ONLY reads the variables and dimensions for this specfic SKU */
							data _null_ ;
									set string_for_proc_model  ;
									i= _n_ ;
									*sku_list= compress(_name_,"logs_");
									*sku_list_numeric= input(sku_list, 12.) ;
									call symput('explanotry_var'||strip(i),string);
									 
								run ;	

						
							%macro construct_string2   ;
								%global sku s_final     ;
								%do c2= 1 %to 1 ;
									%let sku= &&explanotry_var&c2 ;
									%let s_final=  &sku ;
								%end ;
							 	%do c2= 2 %to &nobs ;
									%let sku= &&explanotry_var&c2 ;
									%let s_final = &s_final &sku  ;
								%end ;	
							%mend ;
							%construct_string2 ;
							/* we concatenate the original retained variables and their corresponding lagged terms , plus the calendar effects*/
						%let catstring_&skunumber = %str(+) &s_final ;
							 	
 				%mend ;
/* case 3: no, and temp_&skunumber contains at least 2 variables, then we simply put catstring_&skunumber as an empty string  */
				%macro concatenateparms3 ;
				 	%let catstring_&skunumber = %str()    ; 
					%put %str(no variable retained by the algorithm) ;
					%put &&catstring_&skunumber      ; 
				%mend ;
				
  /*
%put &nobs ;

%put &&catstring_&skunumber  ;
				*/


 	%if &nobs>1 %then %concatenateparms1  ;
	%if &nobs=1 %then %concatenateparms2  ;
 	%if &nobs=0 %then %concatenateparms3  ;
 


%mend ;

%kk_model ;
/*
 
%let start=1 ;  %let end=121 ;
%let category=beer ;

%let skunumber= 37 ;
 

%kk_model  ; 
%let catstring_21 = %str(+)   2121; 
%put &catstring_35 ;*/
