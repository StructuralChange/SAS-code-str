


/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/

/*
from the raw dataset,
based on the time period from week 1114 to 1321 (208 weeks in total)
we try to find out the total revenue (in USD) for each store and for each category
the output dataset is Size_store_blades etc.


/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/


 
/* this macro generates the info of revenue (in USD), for the first 4 years, for each category, for each store */
options nonotes nosource ;
%macro volume_size(first_week, last_week, category) ;
	data s_info.temp ;
		set data.&category._groc_all ;
		if &first_week < week <&last_week ; * we focus on the weeks from week 1114 to 1321 (208 weeks in total) ;
	run ;
	proc sort data= s_info.temp   ;
		by iri_key ;
	run ;
	proc means data= s_info.temp   noprint  ;
		by iri_key ;
		var dollars ;
		output out= s_info.size_store_&category sum= sum ;
	run ;
	data s_info.size_store_&category (rename = (iri_key= &category._iri_key sum= &category._sum )) ;
		set s_info.size_store_&category ;
	run ;
	proc sort data= s_info.size_store_&category  ;
		by   descending  &category._sum;
	run ;
%mend ;
%volume_size(1113, 1322, Paptowl) ; * 1114- 1321 consists of the first 4 years, 2001, 2012, 2003, and 2004 ;

%volume_size(1113, 1322, beer) ; 
%volume_size(1113, 1322, carbbev) ;
%volume_size(1113, 1322, blades) ; 
%volume_size(1113, 1322, cigets );
%volume_size(1113, 1322, coffee );

%volume_size(1113, 1322, coldcer) ;
%volume_size(1113, 1322, deod );
%volume_size(1113, 1322, diapers );
%volume_size(1113, 1322, factiss );
%volume_size(1113, 1322, fzdinent );

%volume_size(1113, 1322, fzpizza) ;
%volume_size(1113, 1322, hhclean );
%volume_size(1113, 1322, hotdog );
%volume_size(1113, 1322, laundet );
%volume_size(1113, 1322, margbutr );

%volume_size(1113, 1322, mayo );
%volume_size(1113, 1322, milk) ;
%volume_size(1113, 1322, mustketc) ;
*%volume_size(1113, 1322, paptowl );
%volume_size(1113, 1322, peanbutr);

%volume_size(1113, 1322, photo);
%volume_size(1113, 1322, razors );
%volume_size(1113, 1322, saltsnck );
%volume_size(1113, 1322, shamp );
%volume_size(1113, 1322, soup);

%volume_size(1113, 1322, spagsauc);
%volume_size(1113, 1322, sugarsub );
%volume_size(1113, 1322, toitisu);
%volume_size(1113, 1322, toothbr );
%volume_size(1113, 1322, toothpa );

%volume_size(1113, 1322, yogurt );
