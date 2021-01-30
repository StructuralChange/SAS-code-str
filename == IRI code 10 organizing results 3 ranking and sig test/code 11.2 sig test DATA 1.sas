options nosource nonotes ;

/* this marco distinguish the forecasts between (non)promoted periods */
/* produce datasets for promoted period */
/*

data expl_str.pro_r_adl4_versus_r_ad4_ew ;
	set expl_str.Overall_r_adl4_versus_r_ad4_ew ;
	if promoall= 1 ;
data expl_str.pro_r_adl4_versus_r_ad4_ic ;
	set expl_str.Overall_r_adl4_versus_r_ad4_ic ;
	if promoall= 1 ;
data expl_str.pro_r_adl4_versus_r_ewc_ic ;
	set expl_str.Overall_r_adl4_versus_r_ewc_ic ;
	if promoall= 1 ;
run ;
/* produce datasets for non promoted period */
/*
data expl_str.non_r_adl4_versus_r_ad4_ew ;
	set expl_str.Overall_r_adl4_versus_r_ad4_ew ;
	if promoall= 0 ;
data expl_str.non_r_adl4_versus_r_ad4_ic ;
	set expl_str.Overall_r_adl4_versus_r_ad4_ic ;
	if promoall= 0 ;

data expl_str.non_r_adl4_versus_r_ewc_ic ;
	set expl_str.Overall_r_adl4_versus_r_ewc_ic ;
	if promoall= 0 ;
run ;
*/
%macro periods1(model1, model2) ;

data expl_str.pro_r_&model1._versus_r_&model2 ;
	set expl_str.Overall_r_&model1._versus_r_&model2 ;
	if promoall= 1 ;
data expl_str.non_r_&model1._versus_r_&model2 ;
	set expl_str.Overall_r_&model1._versus_r_&model2 ;
	if promoall= 0 ;
run ;

%mend ;

%periods1 (adl4, ad4_ew)  ;
%periods1 (adl4, ad4_ic)  ;
%periods1 (adl4, ewc_ic)  ;

%periods1 (own2, base)  ;
%periods1 (own2, ow2_ic)  ;
%periods1 (own2, ow2_ew)  ;
%periods1 (own2, adl4)  ;

* eliminating duplicates ;
%macro eliminate_dup (period, model1, model2) ;


proc sort data=expl_str.&period._r_&model1._versus_r_&model2 nodup ;
     by category sku start horizon ;
 
run;
%mend ;
%eliminate_dup(overall, adl4, ad4_ew) ;
%eliminate_dup(overall, adl4, ad4_ic) ;
%eliminate_dup(overall, adl4, ewc_ic) ;

%eliminate_dup(non, adl4, ad4_ew) ;
%eliminate_dup(non, adl4, ad4_ic) ;
%eliminate_dup(non, adl4, ewc_ic) ;


%eliminate_dup(pro, adl4, ad4_ew) ;
%eliminate_dup(pro, adl4, ad4_ic) ;
%eliminate_dup(pro, adl4, ewc_ic) ;

%eliminate_dup(overall, own2, base) ;
%eliminate_dup(overall, own2, ow2_ic) ;
%eliminate_dup(overall, own2, ow2_ew) ;
%eliminate_dup(overall, own2, adl4) ;

%eliminate_dup(non, own2, base) ;
%eliminate_dup(non, own2, ow2_ic) ;
%eliminate_dup(non, own2, ow2_ew) ;
%eliminate_dup(non, own2, adl4) ;

%eliminate_dup(pro, own2, base) ;
%eliminate_dup(pro, own2, ow2_ic) ;
%eliminate_dup(pro, own2, ow2_ew) ;
%eliminate_dup(pro, own2, adl4) ;
 



