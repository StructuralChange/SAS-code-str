options nonotes nosource ;

 

%macro kk_model  ;
/*
%let skunumber= 125 ;
%let start=1 ;
%let end= 160 ;
%let category= Paptowl ; 
*/
 
		%global catstring_&skunumber ;
		%global catstring2_&skunumber ;
		/* we extract the variables from library data_v0, here we rearrange the retained dataset*/
		data temp_&skunumber ;
			set &var_library..Vs_&start._&end._&category._all ;
			keep r&skunumber ;
			if r&skunumber="" then delete ;
		run ;

 
 
	%obsnvars(temp_&skunumber) ;
/* we distinguish the cases depending on whether or not there are variables retained in the previous step (e.g., LASSO 10-fold selection) */
/* case 1: yes, so temp_&skunumber is not an empty dataset, then we do: */
 

			data aa ;
				set temp_&skunumber ;
				if substr(r&skunumber,1,2) = "d_"  then v_d_all=1 ;
					else v_d_all=0 ;
				if substr(r&skunumber,1, 2+length(&skunumber)) = "d_&skunumber"  then v_d_own=1 ;
					else v_d_own=0 ;

				if substr(r&skunumber,1,2) = "f_"  then v_f_all=1 ;
					else v_f_all=0 ;
				if substr(r&skunumber,1, 2+length(&skunumber)) = "f_&skunumber"  then v_f_own=1 ;
					else v_f_own=0 ;

				if substr(r&skunumber,1,5) = "logp_"  then v_logp_all=1 ;
					else v_logp_all=0 ;
				if substr(r&skunumber,1, 5+length(&skunumber)) = "logp_&skunumber"  then v_logp_own=1 ;
					else v_logp_own=0 ;



				v_logp_competitive= v_logp_all - v_logp_own ;	 /* competitiv price */
				v_d_competitive= v_d_all - v_d_own ;			/* competitiv d */
				v_f_competitive= v_f_all - v_f_own ;			/* competitiv f */

				v_f_d_own= v_d_own +  v_f_own ;				/* own d and f */
				v_f_d_competitive= v_d_competitive +  v_f_competitive ; /* competitive d and f */
				
				v_f_d_logp_own= v_f_d_own+ v_logp_own ;     /* own price, d, and f */
				v_f_d_logp_competitive=  v_f_d_competitive +v_logp_own ; /* competitive price, d, and f */

				sc_1= v_logp_all+ v_f_d_own ;		/* all price, own d and f */
				sc_2= v_logp_own+ v_f_all+v_d_all ; /* own price, all d and f */

			run ;
			/* scenario 1, we model own price as tvp, others with constant parm */
			
	/*********************************************************/
			
	/*********************************************************/

			/* Scenario 1: no variable is modelled as tvp */
					data v_tvp0 ;
						set _null_ ;

					data v_constant0 ;
						set aa ;
						 
					run ;

			/* Scenario 2:   own price as tvp */
					data v_tvp1 ;
						set aa ;
						if v_logp_own=1 ;
						keep r&skunumber ;
					data v_constant1 ;
						set aa ;
						if v_logp_own=0 ;
					run ;
			/* Scenario 3:   own d and f as tvp */
					data v_tvp2 ;
						set aa ;
						if v_f_d_own=1 ;
						keep r&skunumber ;
					data v_constant2 ;
						set aa ;
						if v_f_d_own=0 ;
					run ;
			/* Scenario 4: own price, f and d as tvp */

					data v_tvp3 ;
						set aa ;
						if v_f_d_logp_own=1 ;
						keep r&skunumber ;
					data v_constant3 ;
						set aa ;
						if v_f_d_logp_own=0 ;
					run ;
			/* Scenario 5: all price, own f and d as tvp */

					data v_tvp4 ;
						set aa ;
						if sc_1=1 ;
						keep r&skunumber ;
					data v_constant4 ;
						set aa ;
						if sc_1=0 ;
					run ;
			/* Scenario 6: own price, all f and d as tvp */

					data v_tvp5 ;
						set aa ;
						if sc_2=1 ;
						keep r&skunumber ;
					data v_constant5 ;
						set aa ;
						if sc_2=0 ;
					run ;

 

	/*********************************************************/
	%obsnvars(v_tvp&scenario) ;
				%macro concatenateparms1 ;
					/* %put &nobs "xxxxxx" ;*/
						data temp_parm ;
							%do p= 1 %to &nobs ;
								length parm $ 10 ;
								parm= "randomreg " ;
								output ;
							%end ;
						run ;
						data temp_plus ;
								%do p= 1 %to &nobs ;
								plus= ";" ;
								output ;
							%end ;
						data string_for_proc_model ;
							merge temp_parm v_tvp&scenario temp_plus ;
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
						%let catstring_&skunumber =  &s_final ;
						%put &&catstring_&skunumber   ;
 				%mend ;
 /* case 3: no, and temp_&skunumber contains at least 2 variables, then we simply put catstring_&skunumber as an empty string  */
				%macro concatenateparms3 ;
				 	%let catstring_&skunumber = %str()    ; 
					%put %str(no variable retained by the algorithm) ;
					%put &&catstring_&skunumber      ; 
				%mend ;
				%macro xxx ;
				 	%if &nobs>1 %then %concatenateparms1  ;
					%if &nobs=1 %then %concatenateparms1  ;
				 	%if &nobs=0 %then %concatenateparms3  ;
				 %mend ;
 %xxx ;

/*******************************************************************/

	%obsnvars(v_constant&scenario) ;
				%macro concatenateparms1 ;
					/* %put &nobs "xxxxxx" ;*/
						data temp_parm ;
							%do p= 1 %to &nobs ;
								length parm $ 10 ;
								parm= "  " ;
								output ;
							%end ;
						run ;
						data temp_plus ;
								%do p= 1 %to &nobs ;
								plus= " " ;
								output ;
							%end ;
						data string_for_proc_model ;
							merge temp_parm v_constant&scenario temp_plus ;
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
						%let catstring2_&skunumber = %str(=) &s_final ;
						%put &&catstring2_&skunumber   ;
 				%mend ;
 /* case 3: no, and temp_&skunumber contains at least 2 variables, then we simply put catstring_&skunumber as an empty string  */
				%macro concatenateparms3 ;
				 	%let catstring2_&skunumber = %str()    ; 
					%put %str(no variable retained by the algorithm) ;
					%put &&catstring2_&skunumber      ; 
				%mend ;
				%macro xxx ;
				 	%if &nobs>1 %then %concatenateparms1  ;
					%if &nobs=1 %then %concatenateparms1  ;
				 	%if &nobs=0 %then %concatenateparms3  ;
				 %mend ;
 %xxx ;

	/*********************************************************/
%mend ;

%kk_model ;
 
