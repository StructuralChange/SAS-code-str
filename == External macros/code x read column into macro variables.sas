data contents ;
	set contents ;
	i= _n_ ;
	retail_list= compress(name,"units_"); * units_ is the prefix of the sku number ;
	retail_list_numeric= input( retail_list, 12.) ;
	call symput('sku_number_v1_'||strip(i),retail_list_numeric); * the new macro variable is sku_number_v1_1, sku_number_v1_2, sku_number_v1_3, etc. ;
run ;


 
