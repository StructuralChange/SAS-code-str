options nosource nonotes ;


 

proc means data= test noprint ;
	var units_&skunumber ;
	output out= stat_one_sku_&cc mean= mean std= std SKEWNESS=SKEWNESS range= range KURTOSIS=KURTOSIS ;
run ;

data stat_one_sku_&cc ;
	set stat_one_sku_&cc ;
	drop _type_ _freq_ ;
	skunumber= &skunumber ;
run ;
