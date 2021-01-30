options nosource nonotes ;
 data xx ;
 	set Expl_cat._reg_mape2_12;
run ;

/* model 0: pooled model */


proc reg data = xx;
  model  

	improvement_ad4_ic=  	
	price_mean		 
 	price_std		 
 
 	price_c_v		 
 	sales_mean		 
 	sales_std		 
  
 	sales_c_v		 
 	d_freq		 
 	f_freq		 
 	outliers_pct		 
 	randomness		 
 	abs_linear_trend	/   vif tol collin alpha=0.05;

;

run ;
quit ;


 /* model 1: models with dummies */


proc glmmod data=xx outdesign=GLMDesign outparm=GLMParm;
   class category ;
   model improvement_ad4_ic=  	
			price_mean		 
		 	price_std		 
		 
		 	price_c_v		 
		 	sales_mean		 
		 	sales_std		 
		  
		 	sales_c_v		 
		 	d_freq		 
		 	f_freq		 
		 	outliers_pct		 
		 	randomness		 
		 	abs_linear_trend	 
		category
 ;
run ;


/* F test for poolability */
/* the null is rejected, so we prefer fixed effect models */ 

 
proc reg data = GLMDesign;
  model   improvement_ad4_ic=  	

  
col2-col42

/ noint vif tol collin alpha=0.05;
 

test 

 
col13	=
col14	=
col15	=
col16	=
col17	=
col18	=
col19	=
col20	=
col21	=
col22	=
col23	=
col24	=
col25	=
col26	=
col27	=
col28	=
col29	=
col30	=
col31	=
col32	=
col33	=
col34	=
col35	=
col36	=
col37	=
col38	=
col39	=
col40	=
col41	=
col42	= 0

;
run;
quit ;




 PROC MIXED DATA=  xx METHOD=ML; 
CLASS category; 
MODEL 

improvement_ad4_ic=  	
			price_mean		 
		 	price_std		 
		 
		 	price_c_v		 
		 	sales_mean		 
		 	sales_std		 
		  
		 	sales_c_v		 
		 	d_freq		 
		 	f_freq		 
		 	outliers_pct		 
		 	randomness		 
		 	abs_linear_trend	


  /SOLUTION; 
RANDOM INTERCEPT / SUBJECT=category TYPE=UN SOLUTION; 
RUN; 




 
