options nonotes nosource ;
/* we load an external macro which extract the number of rows and columns of a table */
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;


 /* this macro calcualte the pct of active SKUs for each category across the 206 weeks, and

		 				 the pct of active SKUs for each category for each week

*/


/* count active and non-slow movers for each category */
%macro count0(category) ;
	data count_active_sku ;
		set data1c.Valid_picture_&category ;
		if col1>0.1 then col1_2 = 1 ;
			else col1_2 = 0 ;
		if   col1>0 ;
	run ;

	proc means data= count_active_sku mean sum noprint ;
		var col1_2 ;
		output out= xx mean= active_sku_pct sum= active_sku_n ;
	run ;
	data count_&category  ;
		set xx ;
		category="&category" ;
		drop _type_ _freq_ ;
	run ;
	data Data1c.count_all_cat ;
		set count_&category ;
	run ;
%mend ;

%macro count1(category) ;
	data count_active_sku ;
		set data1c.Valid_picture_&category ;
		if col1>0.1 then col1_2 = 1 ;
			else col1_2 = 0 ;
		if   col1>0 ;
	run ;

	proc means data= count_active_sku mean sum noprint ;
		var col1_2 ;
		output out= xx mean= active_sku_pct sum= active_sku_n ;
	run ;
	data count_&category  ;
		set xx ;
		category="&category" ;
		drop _type_ _freq_ ;
	run ;
	data Data1c.count_all_cat ;
		set Data1c.count_all_cat count_&category ;
	run ;

%mend ;

	%count0(Paptowl) ;	
	%count1(saltsnck) ;
	%count1(beer	) ;
	%count1(carbbev	) ;
	%count1(blades	) ;
	%count1(cigets	) ;
	%count1(coffee	) ;
	%count1(coldcer	) ;
	%count1(deod	);
	%count1(factiss	) ;
	%count1(fzdinent) ;
	%count1(fzpizza	) ;
	%count1(hhclean	) ;
	%count1(hotdog	) ;
	%count1(laundet	) ;
	%count1(margbutr) ;
	%count1(mayo	) ;
	%count1(milk	) ;
	%count1(mustketc) ;
	%count1(peanbutr) ;
	%count1(photo	) ;
	%count1(razors	) ;
	%count1(shamp	) ;
	%count1(soup	) ;
	%count1(spagsauc) ;
	%count1(sugarsub) ;
	%count1(toitisu	) ;
	%count1(toothbr	) ;
	%count1(toothpa	) ;
	%count1(yogurt	) ;   








/* count how the number of active and non-slow movers change over time for each category */

 
 %macro rebuild ( category) ;


 
		data temp_all0 ;
			set data1c.Data_groc_&category ;
			keep units_1- units_5000 ;
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
			retail_list= compress(_name_,"units_");
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
			  if units_&a=.  then count_&a= 0 ;  else count_&a= 1 ;
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
			 if units_&a=.  then count_&a= 0 ;  else count_&a= 1 ;
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
	data Data1c.count_all_cat_ot ;
		set tt ;
	run ;

%mend ;
%macro rebuild2 (category)  ;
	%rebuild(&category) ;


	data tt (rename =(active_all= active_all_&category))  ;
		set temp_&category ;
		keep active_all ;
	run ;
	data Data1c.count_all_cat_ot ;
		merge Data1c.count_all_cat_ot tt ;
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
	proc means data= data1c.Count_all_cat_ot mean std noprint ;
		var active_all_&category ;
		output out= stat_&category mean= valid_sku_mean std= valid_sku_std ;
	run ;
	data Data1c.stat_all_cat ;
		set stat_&category ;
		category= "&category" ;
	run ;
%mend ;
%macro rebuild3 (category) ;
	proc means data= data1c.Count_all_cat_ot mean std noprint ;
		var active_all_&category ;
		output out= stat_&category mean= valid_sku_mean std= valid_sku_std ;
	run ;
	data stat_&category ;
		set stat_&category ;
		category= "&category" ;
	run ;
	data Data1c.stat_all_cat ;
		set Data1c.stat_all_cat stat_&category ;
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
  
