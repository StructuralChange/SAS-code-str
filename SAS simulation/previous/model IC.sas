				
options nosource nonotes  ;
  
/* step 1:	data */
ods listing close ;

data data_estimate ;
	set simu1.data ;
	if i<71 ;
	keep i y ;
data data_x ;
	set simu1.data ;
	drop y ;
data data_forecast ;
	merge data_estimate data_x ;
	by i ;
run ;


data data_estimate0 ;
	set simu1.data ;
	if i<71 ;
run ;

 
/* detect structural break */ 

proc model data= data_estimate0 ; 
		*parms d1 - d12 b1-b3 a1-a5 a1_1 ;
 		y= int + a*x ;											
			;
	id i ; 
    fit y
 
            /       outresid  outall
							  out= model_ic
chow= (1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	
25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40	41	42	43	44	45	46	47	48	49	50	
51	52	53	54	55	56	57	58	59	60	61	62	63	64	65	66	67	68	69	70	 	)   
	 	outest=parms  ; 
	  		range i= 1 to 70 ;

ods  output parameterestimates= pvalues residsummary= stat chowtest= chowtest ;;
      solve y / data= data_forecast 
							  estdata= parms 
							  out=forecast forecast;
			
			 
	 		*range i= %eval(&start+4) to &forecast_end ;
 
   	run;

ods listing ;	
quit; 



 

 
