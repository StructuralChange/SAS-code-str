options nonotes nosource ;
/* we load an external macro which extract the number of rows and columns of a table */
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;


 


 /* this macro calcualtes the number of SKUs on display for each category across the 208 weeks, and

		 				  the number of SKUs on display for each category for each week

*/









/* count how the number of active and non-slow movers change over time for each category */

 
 %macro rebuild ( category) ;


 
		data temp_all0 ;
			set data1c.Data_groc_&category ;
			keep d_1- d_5000 ;
			if _n_=1 ;
		run ;
		proc transpose data= temp_all0 out = temp_all  ;
		run ;



		/*
		now we retain the SKU number of the SKU's with enough data, and put them into global variables, 
			e.g.&retained_valid_sku1  
				&retained_valid_sku7
				&retained_valid_sku9 , given 1, 7, and 9 are retained based on the 9x% threshold ;*/
		data temp_all ;
			set temp_all ;
			i= _n_ ;
			retail_list= compress(_name_,"d_");
			retail_list_numeric= input( retail_list, 12.) ;
			call symput('retained_valid_sku'||strip(i),retail_list_numeric);
		run ;
		 
		 

		/* we also need to know how many SKU's are retained, so we re-run the exteral-macro, and the dataset we 
			used as the input is now the dataset 'temp_all' ;*/
		%obsnvars(temp_all) ;
	 

	%do k=1 %to 1  ;
	/* extract the data for each SKU with enough valid data ;*/
		%let a= &&retained_valid_sku&k ; 
		 data temp_&a ;
			set data1c.Data_groc_&category ;
			  if d_&a=1  then count_&a= 1 ;  else count_&a= 0 ;
				 keep  count_&a ;
	     run ;
		 data temp_&category (rename= (count_&a= active_all)) ;
		  category= "&category" ;
		 	set temp_&a ;
		 run ;
	%end ;
	%do k=2 %to &nobs  ;
	/* extract the data for each SKU with enough valid data ;*/
		%let a= &&retained_valid_sku&k ; 
		 data temp_&a ;
			set data1c.Data_groc_&category ;
			 if d_&a=1  then count_&a= 1 ;  else count_&a= 0 ;
					 keep count_&a ;
		 run ;
		 data temp_&category ;
		 	merge temp_&category temp_&a ;
			active_all= active_all+ count_&a ;
			 category= "&category" ;
			keep  category active_all ;
		 run ;
		 proc delete data= temp_&a ;
		run ;
	%end ;


	 
%mend ;
 


%macro rebuild2_0 (category)  ;
	%rebuild(&category) ;


	data tt (rename =(active_all= active_all_&category))  ;
		set temp_&category ;
		keep active_all ;
	run ;
	data Data1c.count_all_cat_ot_d ;
		set tt ;
	run ;

%mend ;
%macro rebuild2 (category)  ;
	%rebuild(&category) ;


	data tt (rename =(active_all= active_all_&category))  ;
		set temp_&category ;
		keep active_all ;
	run ;
	data Data1c.count_all_cat_ot_d ;
		merge Data1c.count_all_cat_ot_d tt ;
	run ;

%mend ;



	%rebuild2_0(Paptowl) ;	
	%rebuild2(saltsnck) ;
	%rebuild2(beer	) ;
	%rebuild2(carbbev	) ;
	%rebuild2(blades	) ;
	%rebuild2(cigets	) ;
	%rebuild2(coffee	) ;
	%rebuild2(coldcer	) ;
	%rebuild2(deod	);
	%rebuild2(factiss	) ;
	%rebuild2(fzdinent) ;
	%rebuild2(fzpizza	) ;
	%rebuild2(hhclean	) ;
	%rebuild2(hotdog	) ;
	%rebuild2(laundet	) ;
	%rebuild2(margbutr) ;
	%rebuild2(mayo	) ;
	%rebuild2(milk	) ;
	%rebuild2(mustketc) ;
	%rebuild2(peanbutr) ;
	%rebuild2(photo	) ;
	%rebuild2(razors	) ;
	%rebuild2(shamp	) ;
	%rebuild2(soup	) ;
	%rebuild2(spagsauc) ;
	%rebuild2(sugarsub) ;
	%rebuild2(toitisu	) ;
	%rebuild2(toothbr	) ;
	%rebuild2(toothpa	) ;
	%rebuild2(yogurt	) ;   
%macro rebuild3_0 (category) ;
	proc means data= data1c.count_all_cat_ot_d mean std noprint ;
		var active_all_&category ;
		output out= stat_&category mean= valid_sku_mean_d std= valid_sku_std_d ;
	run ;
	data Data1c.stat_all_cat_d ;
		set stat_&category ;
		category= "&category" ;
	run ;
%mend ;
%macro rebuild3 (category) ;
	proc means data= data1c.count_all_cat_ot_d mean std noprint ;
		var active_all_&category ;
		output out= stat_&category mean= valid_sku_mean_d std= valid_sku_std_d ;
	run ;
	data stat_&category ;
		set stat_&category ;
		category= "&category" ;
	run ;
	data Data1c.stat_all_cat_d ;
		set Data1c.stat_all_cat_d stat_&category ;
	run ;
%mend ;
 

	%rebuild3_0(Paptowl) ;	
	%rebuild3(saltsnck) ;
	%rebuild3(beer	) ;
	%rebuild3(carbbev	) ;
	%rebuild3(blades	) ;
	%rebuild3(cigets	) ;
	%rebuild3(coffee	) ;
	%rebuild3(coldcer	) ;
	%rebuild3(deod	);
	%rebuild3(factiss	) ;
	%rebuild3(fzdinent) ;
	%rebuild3(fzpizza	) ;
	%rebuild3(hhclean	) ;
	%rebuild3(hotdog	) ;
	%rebuild3(laundet	) ;
	%rebuild3(margbutr) ;
	%rebuild3(mayo	) ;
	%rebuild3(milk	) ;
	%rebuild3(mustketc) ;
	%rebuild3(peanbutr) ;
	%rebuild3(photo	) ;
	%rebuild3(razors	) ;
	%rebuild3(shamp	) ;
	%rebuild3(soup	) ;
	%rebuild3(spagsauc) ;
	%rebuild3(sugarsub) ;
	%rebuild3(toitisu	) ;
	%rebuild3(toothbr	) ;
	%rebuild3(toothpa	) ;
	%rebuild3(yogurt	) ;   
  
