options nonotes nosource ; 





proc means data= rk_armae.Armae_own_vs_base_h12 ;
	var avg_rel_mae ;
	output out= Armae_own_vs_base mean=mean ;
run ;
