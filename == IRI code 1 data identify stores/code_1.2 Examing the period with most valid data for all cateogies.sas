/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/

/*
from the raw dataset,
we aim to base on the time period from week 1114 to 1321 (208 weeks in total)
however, some stores have available data for shorter periods of time.
thus we need to find them out (so that we would not use these stores).

the output datasets are:
Valid_period_fzpizza
merged_period_fzpizza (this datasets indicate the starting and end of the time period for each store, and also 
the total sales (in USD).


/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/

options nonotes nosource ;

* macro step 1: find out the time period with valid data for each store for the specific category ; 
%macro valid_period_0 (first_week,last_week, category) ;
	data temp ;
		set data.&category._groc_all  ;
			if &first_week < week <&last_week ; * we focus on the weeks before 1322 ;
	run ;
	proc sort data= temp   ;
		by   iri_key ;
	run ;
	proc means data= temp min max noprint ;
		var week ;
		by iri_key ;
		output out= &category max=max min=min ;
	run ;
	data s_info.valid_period_&category (rename= (iri_key = &category._iri_key))  ;
		set &category ;
		keep iri_key min max ;
	run ;
	%merge1 (&category) ;
%mend ;
* macro step 2: merge the data obtained previously to the dataset which contains the sales volume (in unit sales) of each store for the category ;
* merge sales volume (in unit) and valid time period for each store for each category ;
%macro merge1 (category) ;
	proc sort data= s_info.size_store_&category  ;
		by &category._iri_key ;
	run ;

	data s_info.merged_&category ;
		merge s_info.size_store_&category 
			  s_info.valid_period_&category ;
		by &category._iri_key ;
	run ;
%mend ;



%valid_period_0(1113, 1322, Paptowl) ;
%valid_period_0(1113, 1322, beer) ; 

%valid_period_0(1113, 1322, carbbev) ;
%valid_period_0(1113, 1322, blades) ; 
%valid_period_0(1113, 1322, cigets );
%valid_period_0(1113, 1322, coffee );

%valid_period_0(1113, 1322, coldcer) ;
%valid_period_0(1113, 1322, deod );
%valid_period_0(1113, 1322, diapers );
%valid_period_0(1113, 1322, factiss );
%valid_period_0(1113, 1322, fzdinent );

%valid_period_0(1113, 1322, fzpizza) ;
%valid_period_0(1113, 1322, hhclean );
%valid_period_0(1113, 1322, hotdog );
%valid_period_0(1113, 1322, laundet );
%valid_period_0(1113, 1322, margbutr );

%valid_period_0(1113, 1322, mayo );
%valid_period_0(1113, 1322, milk) ;
%valid_period_0(1113, 1322, mustketc) ;
*%valid_period_0(1113, 1322, paptowl );
%valid_period_0(1113, 1322, peanbutr);

%valid_period_0(1113, 1322, photo);
%valid_period_0(1113, 1322, razors );
%valid_period_0(1113, 1322, saltsnck );
%valid_period_0(1113, 1322, shamp );
%valid_period_0(1113, 1322, soup);

%valid_period_0(1113, 1322, spagsauc);
%valid_period_0(1113, 1322, sugarsub );
%valid_period_0(1113, 1322, toitisu);
%valid_period_0(1113, 1322, toothbr );
%valid_period_0(1113, 1322, toothpa );

%valid_period_0(1113, 1322, yogurt );



















 

