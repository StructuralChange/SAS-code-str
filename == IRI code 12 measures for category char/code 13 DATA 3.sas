options nosource nonotes ;


  
%macro performance_model (measure, horizon) ;
data _&measure._&horizon ;
	set rank_0.All_comparison_all_&horizon._&measure ;
	improvement_ow2_ew= (own2- ow2_ew)/own2 ;
	improvement_ow2_ic= (own2- ow2_ic)/own2 ;
	improvement_ad4_ew= (adl4- ad4_ew)/adl4 ;
	improvement_ad4_ic= (adl4- ad4_ic)/adl4 ;


	improvement_ew_ic= (ad4_ew- ad4_ic)/ad4_ew ; /* this measures the percentage improvement by IC compared to EWC */
run ;

proc sort data=  _&measure._&horizon ;
	by category sku ;

data tt (rename=(skunumber=sku)) ;
	set expl_cat.Stat_all_allcat3  ;
run ;
proc sort data= tt ;
	by category sku   ;
run ;
data _reg_&measure._&horizon ;
	merge tt  _&measure._&horizon ; 
	by category sku ;
run ;
data expl_cat._reg_&measure._&horizon ;
	set _reg_&measure._&horizon ;
	if category="Paptowl" then delete ;
	if category="razors" then delete ;
	/*
	if category="beer"    then  category_beer	=	1 ;	else  category_beer	=	0;
	if category="blades"   then  category_blades	=	1 ;	else  category_blades	=	0;
	if category="carbbev"   then  category_carbbev	=	1 ;	else  category_carbbev	=	0;
	if category="cigets"   then  category_cigets	=	1 ;	else  category_cigets	=	0;
	if category="coffee"   then  category_coffee	=	1 ;	else  category_coffee	=	0;
	if category="coldcer"   then  category_coldcer	=	1 ;	else  category_coldcer	=	0;
	if category="deod"   then  category_deod	=	1 ;	else  category_deod	=	0;
	if category="factiss"   then  category_factiss	=	1 ;	else  category_factiss	=	0;
	if category="fzdinen"   then  category_fzdinen	=	1 ;	else  category_fzdinen	=	0;
	if category="fzpizza"   then  category_fzpizza	=	1 ;	else  category_fzpizza	=	0;
	if category="hhclean"   then  category_hhclean	=	1 ;	else  category_hhclean	=	0;
	if category="hotdog"   then  category_hotdog	=	1 ;	else  category_hotdog	=	0;
	if category="laundet"   then  category_laundet	=	1 ;	else  category_laundet	=	0;
	if category="margbut"   then  category_margbut	=	1 ;	else  category_margbut	=	0;
	if category="mayo"   then  category_mayo	=	1 ;	else  category_mayo	=	0;
	if category="milk"   then  category_milk	=	1 ;	else  category_milk	=	0;
	if category="mustket"   then  category_mustket	=	1 ;	else  category_mustket	=	0;
	if category="Paptowl"   then  category_Paptowl	=	1 ;	else  category_Paptowl	=	0;
	if category="peanbut"   then  category_peanbut	=	1 ;	else  category_peanbut	=	0;
	if category="photo"   then  category_photo	=	1 ;	else  category_photo	=	0;
	if category="razors"   then  category_razors	=	1 ;	else  category_razors	=	0;
	if category="saltsnc"   then  category_saltsnc	=	1 ;	else  category_saltsnc	=	0;
	if category="shamp"   then  category_shamp	=	1 ;	else  category_shamp	=	0;
	if category="soup"   then  category_soup	=	1 ;	else  category_soup	=	0;
	if category="spagsau"   then  category_spagsau	=	1 ;	else  category_spagsau	=	0;
	if category="sugarsu"   then  category_sugarsu	=	1 ;	else  category_sugarsu	=	0;
	if category="toitisu"   then  category_toitisu	=	1 ;	else  category_toitisu	=	0;
	if category="toothbr"   then  category_toothbr	=	1 ;	else  category_toothbr	=	0;
	if category="toothpa"   then  category_toothpa	=	1 ;	else  category_toothpa	=	0;
	if category="yogurt"   then  category_yogurt	=	1 ;	else  category_yogurt	=	0;
	*/

run ;

%mend ;

 

%performance_model(smape, 8) ;
%performance_model(mase,  8) ;
%performance_model(mae,  8) ;
 

%performance_model(smape, 4) ;
%performance_model(mase,  4) ;
%performance_model(mae,  4) ;
 
%performance_model(smape, 1) ;
%performance_model(mase,  1) ;
%performance_model(mae,  1) ;

 


