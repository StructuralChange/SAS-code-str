%macro significance_calculate (dataset, var1, var2)   ;
	data all ; 
		set &dataset ;
		dif = &var1- &var2 ;
	proc univariate data = all noprint ;
		var dif;
		output out=test PROBS=p_sr PROBT=p_t;
	proc means data=all noprint mean ;
		var dif ;
		output out= def ;
	data def ;
		set def ;
		if _stat_="MEAN" ;
		keep dif ;
	data sig_&var1._&var2 ;
		merge def test ;
	data temp1 ;
		set sig_&var1._&var2 ;
		format model1 $12. ;
		format model2 $12. ;
		model1= "&var1" ;
		model2= "&var2" ;
			 
	run ;
%mend   ;


  
%significance_calculate (kk, mape_original, mape_adj) ;
