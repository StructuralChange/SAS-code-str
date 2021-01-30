
/* this macro identify the SKU's with 0 weekly sales (slow movers)
the results indicate that there is no such SKU existing among the retained SKU's (with more than 90% valid sales data- the 10% missing data were replaced with previous sales
, so there is no 0 values for unit sales and this eliminates the potential problem for logarithm transformation in later steps )*/


%macro detect_slow_mover0 (category) ;
data units_1 ;
	set data1c.Data_groc_&category ;
	keep units_1 - units_5000 ;
run ;

ods listing close ;

proc means data= units_1 min    ;
 
	output out= aaa min=min ;
ods  output summary= summary  ;
run ;


ods listing   ;

proc transpose data= summary out= s_&category ;
run ;

data s_&category ;
	set s_&category ;
	category= "&category" ;
run ;
data all ;
	set s_&category ;
run ;

%mend ;

%macro detect_slow_mover (category) ;
data units_1 ;
	set data1c.Data_groc_&category ;
	keep units_1 - units_5000 ;
run ;

ods listing close ;

proc means data= units_1 min    ;
 
	output out= aaa min=min ;
ods  output summary= summary  ;
run ;


ods listing   ;

proc transpose data= summary out= s_&category ;
run ;

data s_&category ;
	set s_&category ;
	category= "&category" ;
run ;
data all ;
	set all s_&category ; 
run ;

%mend ;
 


%detect_slow_mover0 (	Paptowl	) ;
%detect_slow_mover (	beer	) ;
%detect_slow_mover (	carbbev	) ;
%detect_slow_mover (	blades	) ;
%detect_slow_mover (	cigets	) ;
%detect_slow_mover (	coffee	) ;
%detect_slow_mover (	coldcer	) ;
%detect_slow_mover (	deod	) ;
/* %detect_slow_mover (	diapers	) ;*/
%detect_slow_mover (	factiss	) ;
%detect_slow_mover (	fzdinent	) ;
%detect_slow_mover (	fzpizza	) ;
%detect_slow_mover (	hhclean	) ;
%detect_slow_mover (	hotdog	) ;
%detect_slow_mover (	laundet	) ;
%detect_slow_mover (	margbutr	) ;
%detect_slow_mover (	mayo	) ;
%detect_slow_mover (	milk	) ;
%detect_slow_mover (	mustketc	) ;
%detect_slow_mover (	peanbutr	) ;
%detect_slow_mover (	photo	) ;
%detect_slow_mover (	razors	) ;
%detect_slow_mover (	saltsnck	) ;
%detect_slow_mover (	shamp	) ;
%detect_slow_mover (	soup	) ;
%detect_slow_mover (	spagsauc	) ;
%detect_slow_mover (	sugarsub	) ;
%detect_slow_mover (	toitisu	) ;
%detect_slow_mover (	toothbr	) ;
%detect_slow_mover (	toothpa	) ;
%detect_slow_mover (	yogurt	) ;


data all2 ;
	set all ;
	if col1=0 ;
run ;
