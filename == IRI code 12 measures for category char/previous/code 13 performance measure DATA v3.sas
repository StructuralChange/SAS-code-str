options nosource nonotes ;



/*
data _reg_mape_1 ;
	set expl_cat._reg_mape_1 ;
		h1=1 ;
data _reg_mape_4 ;
	set expl_cat._reg_mape_4 ;
		h4=1 ;
data _reg_mape_12 ;
	set expl_cat._reg_mape_12 ;
		h12=1 ;
run ;
data expl_cat._reg_mape_all_horizons ;
	set _reg_mape_1
		_reg_mape_4
		_reg_mape_12 ;

		if h1=. then h1=0 ;
		if h4=. then h4=0 ;
		if h12=. then h12=0 ;

			if price_c_v=0 then delete ;


;
run ;




*/
