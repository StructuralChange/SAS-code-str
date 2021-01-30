/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/

/*
from code 1.3,
we try to find out the store which generate the highest sales (in USD) for every product category
the output is all_Merged_all which contains the store number for each product category 



/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/

options nonotes nosource ;
%macro sort1_0 (category) ;
	data Merged_&category (rename= (max= max_&category min= min_&category &category._iri_key=iri_key ) ) ;
		set s_info.Merged_&category ;
		if max= 1321 and min= 1114 ;
		drop _freq_ _type_ ;
	run ;
	proc sort data= Merged_&category ;
		by descending &category._sum ;
	run ;	
	data all_Merged_all ;
		set Merged_&category ;
		if _n_=1 ;
		informat category $20. ;
		category= "&category" ;
		keep iri_key category ;
	run ;
%mend ;
%macro sort1 (category) ;
	data Merged_&category (rename= (max= max_&category min= min_&category &category._iri_key=iri_key ) ) ;
		set s_info.Merged_&category ;
		if max= 1321 and min= 1114 ;
		drop _freq_ _type_ ;
	run ;
	proc sort data= Merged_&category ;
		by descending &category._sum ;
	run ;	
	data Merged_&category ;
		set   Merged_&category ;
		if _n_=1 ; /* here we choose the mid sized store for that particular category */
		informat category $20. ;
		category= "&category" ;
		keep iri_key category ;
	data  all_Merged_all ;
		set all_Merged_all Merged_&category ;
	run ;
%mend ;

 
%sort1_0 (beer) ; 

%sort1 (carbbev) ;
%sort1 (blades) ; 
%sort1 (cigets );
%sort1 (coffee );

%sort1 (coldcer) ;
%sort1 (deod );
%sort1 (diapers );
%sort1 (factiss );
%sort1 (fzdinent );

%sort1 (fzpizza) ;
%sort1 (hhclean );
%sort1 (hotdog );
%sort1 (laundet );
%sort1 (margbutr );

%sort1 (mayo );
%sort1 (milk) ;
%sort1 (mustketc) ;
%sort1 (paptowl );
%sort1 (peanbutr);

%sort1 (photo);
%sort1 (razors );
%sort1 (saltsnck );
%sort1 (shamp );
%sort1 (soup);

%sort1 (spagsauc);
%sort1 (sugarsub );
%sort1 (toitisu);
%sort1 (toothbr );
%sort1 (toothpa );

%sort1 (yogurt );



data s_info.all_Merged_all ;
	set all_Merged_all ;
run ;













 

