/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/

/*
from code 1.2,
we now only retain those stores with available data from   week 1114 to 1321 (208 weeks in total)

the output dataset is all_data which contains the store number, its total sales (in USD), and the starting and ending week (i.e., week 1114 to 1321 )
 

/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/


%macro merge2_0 (category) ;
	/* we only retain the stores with sales for the full period of the 4 years */
	data s_info.all_data (rename= (max= max_&category min= min_&category &category._iri_key=iri_key  ) ) ;
		set s_info.Merged_&category ;
		if max= 1321 and min= 1114 ;
		drop _freq_ _type_ ;
	run ;
%mend ;
%macro merge2 (category) ;
	data Merged_&category (rename= (max= max_&category min= min_&category &category._iri_key=iri_key ) ) ;
		set s_info.Merged_&category ;
		if max= 1321 and min= 1114 ;
		drop _freq_ _type_ ;
	run ;
	data s_info.all_data ;
		merge s_info.all_data Merged_&category ;
		by  iri_key ;
	run ;
%mend ;

 
%merge2_0 (beer) ; 

%merge2 (carbbev) ;
%merge2 (blades) ; 
%merge2 (cigets );
%merge2 (coffee );

%merge2 (coldcer) ;
%merge2 (deod );
%merge2 (diapers );
%merge2 (factiss );
%merge2 (fzdinent );

%merge2 (fzpizza) ;
%merge2 (hhclean );
%merge2 (hotdog );
%merge2 (laundet );
%merge2 (margbutr );

%merge2 (mayo );
%merge2 (milk) ;
%merge2 (mustketc) ;
%merge2 (paptowl );
%merge2 (peanbutr);

%merge2 (photo);
%merge2 (razors );
%merge2 (saltsnck );
%merge2 (shamp );
%merge2 (soup);

%merge2 (spagsauc);
%merge2 (sugarsub );
%merge2 (toitisu);
%merge2 (toothbr );
%merge2 (toothpa );

%merge2 (yogurt );





















 

