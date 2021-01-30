/* organize 1*/
%macro table (dir) ;
data d1 ;
	set &dir..Ranking_mape ;
	i= _n_ ;
data d2 ;
	set &dir..Ranking_smape ;
	i= _n_ ;
data d3 ;
	set &dir..Ranking_mase ;
	i= _n_ ;
run ;

 

data all_&dir ;
	merge d1 d2 d3 
	;
	by i ;
	drop i ;
run ;
%mend ;
%table (t_g_1_3) ;
%table (t_g_4_3) ;
%table (t_g_12_3) ;

/* organize 2*/
/* COMPARE adl adl-ewc adl-ic */
%macro table2 (dir) ;
%macro dall (measure) ;
	data d0 ;
		set &dir..Comparison_&measure ;
		keep category ;

	data d1 ;
		set &dir..Comparison_&measure ;
		keep &measure._adl
			 &measure._adl_ew
			 &measure._adl_ic ;
	run ;
	data d_&measure ;
		merge d0 d1 ;
		i=_n_ ;
	run ;
%mend ;

%dall(mape) ;
%dall(smape) ;
%dall(mase) ;

data d_all_&dir ;
	merge d_mape d_smape d_mase ;
	by i ;
	drop i ;
run ;
%mend ;
%table2(r_g_1_1)
%table2(r_g_4_1)
%table2(r_g_12_1)


%table2(t_g_1_1)
%table2(t_g_4_1)
%table2(t_g_12_1)


/* COMPARE own own-ewc own-ic */
%macro table2 (dir) ;
%macro dall (measure) ;
	data d0 ;
		set &dir..Comparison_&measure ;
		keep category ;

	data d1 ;
		set &dir..Comparison_&measure ;
		keep &measure._own
			 &measure._own_ew
			 &measure._own_ic ;
	run ;
	data d_&measure ;
		merge d0 d1 ;
		i=_n_ ;
	run ;
%mend ;

%dall(mape) ;
%dall(smape) ;
%dall(mase) ;

data d_all_&dir ;
	merge d_mape d_smape d_mase ;
	by i ;
	drop i ;
run ;
%mend ;
%table2(r_g_1_1)
%table2(r_g_4_1)
%table2(r_g_12_1)

%table2(t_g_1_1)
%table2(t_g_4_1)
%table2(t_g_12_1)













