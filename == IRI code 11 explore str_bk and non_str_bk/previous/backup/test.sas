data aa ;
	set expl_str.Overall_r_own2_versus_r_ow2_ew ;
	if category="Paptowl" ;
run ;

data bb ;
	set expl_str.Overall_r_own2_versus_r_ow2_ic ;
	if category="Paptowl" ;
run ;

