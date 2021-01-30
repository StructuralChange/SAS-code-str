options nosource nonotes ;

 /* poolability test */

/* model 0: pooled model */
 data xx ;
 	set Expl_cat._reg_mape2_12;
run ;

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
run;




 
proc reg data = GLMDesign;
  model   improvement_ad4_ic=  	

  
col2-col42

/ noint vif tol collin alpha=0.05;
 

test 

col2	=
col3	=
col4	=
col5	=
col6	=
col7	=
col8	=
col9	=
col10	=
col11	=
col12	=

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
col42	

;
run;
quit ;




 
%macro dooall0 (string1, measure, improvement, horizon) ;
/* general model */
ods listing close ;
 data xx ;
 	set expl_cat._reg_&measure.2_&horizon;
run ;

proc reg data = xx;
  model   improvement_ad4_ic=  	price_mean		 
 	price_std		 
 	price_SKEWNESS		 
 	price_range		 
 	price_KURTOSIS		 
 
 
 	price_c_v		 
 	sales_mean		 
 	sales_std		 
 	sales_SKEWNESS		 
 	sales_range		 
 	sales_KURTOSIS		 
 	sales_c_v		 
 	d_freq		 
 	f_freq		 
 	outliers_pct		 
 	randomness		 
 	abs_linear_trend	 

/ vif tol collin;
run;



quit;


 

%mend ;

  
%dooall0(ad4_ic, mape,  improvement_ad4_ic, 12 );
%dooall(ad4_ic, smape, improvement_ad4_ic, 12);
%dooall(ad4_ic, mase,  improvement_ad4_ic, 12);
%dooall(ad4_ew, mape,  improvement_ad4_ew, 12);
%dooall(ad4_ew, smape, improvement_ad4_ew, 12);
%dooall(ad4_ew, mase,  improvement_ad4_ew, 12);
%dooall(ow2_ic, mape,  improvement_ow2_ic, 12);
%dooall(ow2_ic, smape, improvement_ow2_ic, 12);
%dooall(ow2_ic, mase,  improvement_ow2_ic, 12);
%dooall(ow2_ew, mape,  improvement_ow2_ew, 12);
%dooall(ow2_ew, smape, improvement_ow2_ew, 12);
%dooall(ow2_ew, mase,  improvement_ow2_ew, 12);

%dooall0(ad4_ic, mape,  improvement_ad4_ic, 4 );
%dooall(ad4_ic, smape, improvement_ad4_ic, 4);
%dooall(ad4_ic, mase,  improvement_ad4_ic, 4);
%dooall(ad4_ew, mape,  improvement_ad4_ew, 4);
%dooall(ad4_ew, smape, improvement_ad4_ew, 4);
%dooall(ad4_ew, mase,  improvement_ad4_ew, 4);
%dooall(ow2_ic, mape,  improvement_ow2_ic, 4);
%dooall(ow2_ic, smape, improvement_ow2_ic, 4);
%dooall(ow2_ic, mase,  improvement_ow2_ic, 4);
%dooall(ow2_ew, mape,  improvement_ow2_ew, 4);
%dooall(ow2_ew, smape, improvement_ow2_ew, 4);
%dooall(ow2_ew, mase,  improvement_ow2_ew, 4);

%dooall0(ad4_ic, mape,  improvement_ad4_ic, 1 );
%dooall(ad4_ic, smape, improvement_ad4_ic, 1);
%dooall(ad4_ic, mase,  improvement_ad4_ic, 1);
%dooall(ad4_ew, mape,  improvement_ad4_ew, 1);
%dooall(ad4_ew, smape, improvement_ad4_ew, 1);
%dooall(ad4_ew, mase,  improvement_ad4_ew, 1);
%dooall(ow2_ic, mape,  improvement_ow2_ic, 1);
%dooall(ow2_ic, smape, improvement_ow2_ic, 1);
%dooall(ow2_ic, mase,  improvement_ow2_ic, 1);
%dooall(ow2_ew, mape,  improvement_ow2_ew, 1);
%dooall(ow2_ew, smape, improvement_ow2_ew, 1);
%dooall(ow2_ew, mase,  improvement_ow2_ew, 1);
