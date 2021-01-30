options nonotes nosource ;


%macro conductall (separate_str, horizon) ;

%let measure= mape ; 

%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 1.sas" ;
%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 2.sas" ; 

%let measure= smape ; 

%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 1.sas" ;
%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 2.sas" ; 

 

%let measure= mae ; 

%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 1.sas" ;
%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 2.sas" ; 

 

%let measure= mase ; 

%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 1.sas" ;
%include "Q:\= IRI data research\== IRI code 12 measures for category char\code ranking 2.sas" ; 

 


/* part 1/2 rank across categories */
/*
data Ranking_mase ;
	set Ranking_mase ;
	order= _n_ ;
run ;
data Ranking_mpe ;
	set Ranking_mpe ;
	order= _n_ ;
data Ranking_smape ;
	set Ranking_smape ;
	order= _n_ ;
run ;
data Ranking_mae ;
	set Ranking_mae ;
	order= _n_ ;
data Ranking_mape ;
	set Ranking_mape ;
	order= _n_ ;
data Ranking_rmse ;
	set Ranking_rmse ;
	order= _n_ ;
run ;
*/
/*
data rank_0.Rank_allm_h&horizon._&separate_str ;
 
data Rank_allm_h&horizon._&separate_str ;
	merge 
		Ranking_mae
		Ranking_mape
		Ranking_smape
		Ranking_mpe
		Ranking_mase 
		ranking_rmse ;
		by order ;
		period= "&separate_str" ;
		drop order ;
run ;
	/* part 2/2 rank category level 	

data ranking_category_mae ;
	set ranking_category_mae ;
	length measure $8  ;
	measure= "mae" ;
data ranking_category_mape ;
	set ranking_category_mape ;
	length measure $8  ;
	measure= "mape" ;
data ranking_category_mase ;
	set ranking_category_mase ;
	length measure $8  ;
	measure= "mase" ;
data ranking_category_mpe ;
	set ranking_category_mpe ;
	length measure $8  ;
	measure= "mpe" ;
data ranking_category_smape ;
	set ranking_category_smape ;
	length measure $8  ;
	measure= "smape" ;
data ranking_category_rmse ;
	set ranking_category_rmse ;
	length measure $8  ;
	measure= "rmse" ;
run ;

data Rank_allm_category_h&horizon._&separate_str ;
	set 
		ranking_category_mae
		ranking_category_mape
		ranking_category_smape
		ranking_category_mpe
		ranking_category_mase 
		ranking_category_rmse ;
 
		period= "&separate_str" ;
	 
run ;
*/

 %mend ;






/*
%conductall (all, 12);
%conductall (pro, 12);
%conductall (non, 12);
*/
%conductall (all, 8);
/*
%conductall (pro, 8);
%conductall (non, 8);
*/

%conductall (all, 4);
/*
%conductall (pro, 4);
%conductall (non, 4);
*/
%conductall (all, 1);
/*
%conductall (pro, 1);
%conductall (non, 1);
/* significance test */


