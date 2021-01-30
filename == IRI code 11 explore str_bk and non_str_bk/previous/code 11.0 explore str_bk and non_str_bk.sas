options nosource nonotes ;


  

 



data test ;
	set expl_str.Overall_r_adl4_versus_r_ad4_ic ;
	if forecast_original = forecast_sb_adjusted ;
run ;

data test ;
	set expl_str.Overall_r_own2_versus_r_ow2_ic ;
	if forecast_original = forecast_sb_adjusted ;
run ;


