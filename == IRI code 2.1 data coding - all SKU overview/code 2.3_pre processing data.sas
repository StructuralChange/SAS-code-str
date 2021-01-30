/*
* this macro impute the data, construct dummy variables etc. ;
* having implemnted macro 2.2, we retain the variables which have more than 9x% of valid data. However, 
	we may still have sporadic missing observations ;
* this macro imputes the missing observations (e.g., e.g. units, dollars, d, and pr etc.) with previous values, 
but not reverse (i.e., if there are missing values in the first a few weeks, 
this macro will be unable to impute these observations ;
*/ 
%obsnvars(temp_all) ;

/* we decribe the existing condition of the category, so we do not impute the data this time*/











data data1c.data_&channel._&category ;
	set sku_valid_all ;
run ;
 
 





