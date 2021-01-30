options nosource nonotes ;


 /* preparing the data for the reg */


%macro sales1 (category) ;
data temp1 ; 
	set data2.Data_groc_&category ;
	keep units_1 - units_3000 ;
	if _n_ <201 ;
run ;

proc means data= temp1  noprint ;
	output out= x ;
run ;

data x ;
	set x;
	if _stat_="MEAN" ;
	drop _type_ _freq_ _stat_ ;
run ;


proc transpose data= x out= x2 ;
run ;

proc means data= x2 mean  std noprint ;
	var col1 ;
	output out= y mean= mean std= std ;
run ;

data y (rename= (mean= mean_mean std= mean_std)) ;
	set y ;
	category= "&category" ;
	keep category mean std ;
run ;
%mend ;

%sales1 (beer) ;
