options nosource nonotes ;


  
 proc sort data= expl_cat.Stat_all_allcat2 ;
 	by category ;
 proc sort data= data1c.Stat_all_cat ;
 	by category ;
 proc sort data= data1c.Stat_all_cat_d ;
 	by category ;
 proc sort data= data1c.Stat_all_cat_f ;
 	by category ;
 proc sort data= data1c.Count_all_cat ;
 	by category ;
run ;

data expl_cat.Stat_all_allcat3 ;
	set expl_cat.Stat_all_allcat2 ;
	/*
			data1c.Stat_all_cat 
			data1c.Stat_all_cat_d 
			data1c.Stat_all_cat_f 
			data1c.Count_all_cat ;
	*/
	by category ;
run ;
