/* this macro create price variable and display dummy variables ;*/
 %macro construct ;
	%do k=1 %to &nobs  ;
	%let a= &&retained_valid_sku&k ; 
	data data1c.data_&channel._&category (rename = (temp_d_&a= d_&a    temp_f_&a=  f_&a)) ;
		set data1c.data_&channel._&category ;
	 	price_&a = dollars_&a/ units_&a ;

		if f_&a= " NONE" then temp_f_&a= 0 ;
			else if f_&a= "" then temp_f_&a= "" ;
			else temp_f_&a= 1 ;
		if d_&a= 0 then temp_d_&a= 0 ;
			else if d_&a= "" then temp_d_&a= "" ;
			else temp_d_&a= 1 ;
		
		logp_&a= log(price_&a) ;
		logs_&a= log(units_&a) ; /* here we do not add 1 to avoid 0 values becuase there is no 0 values (missing values were replaced with previous values)*/

		drop f_&a d_&a ;
	run ;



	%end ;
%mend ;
%construct ;



 
