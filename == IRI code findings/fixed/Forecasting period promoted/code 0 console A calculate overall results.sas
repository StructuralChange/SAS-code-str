*
this macro rank the models with respect to various measures ;
 options nonotes nosource  ;
 
* first we input the library where the results data are stored ;
*%let horizon0=1 ;
%let limit_horizon= %str(if horizon>&horizon0 then delete ; ) ; * this include the forecast horizons from 1 to 12 ;
%global limit_horizon ; run ;
%put &limit_horizon ;
%let rolling=%str(t) ; /* change to t or r for 150/12 or 120/12/20(rolling) setting */
%put &rolling ; 



%macro org1 (measure) ;
	%executeall (adl ) ;
	%executeall (adl_ew ) ;
	%executeall (adl_ic ) ;
	%executeall (base ) ;
	%executeall (f ) ;
	%executeall (f_ic ) ;
	%executeall (f_ewc ) ;
	%executeall (own_ew ) ;
	%executeall (own_ic ) ;
	%executeall (own ) ;
 ;

	data rank_2.comparison_&measure ;
		merge rank_2.all_&measure._adl
				rank_2.all_&measure._adl_ew
				rank_2.all_&measure._adl_ic
				rank_2.all_&measure._base
				rank_2.all_&measure._f
				rank_2.all_&measure._f_ewc
				rank_2.all_&measure._f_ic
				rank_2.all_&measure._own
				rank_2.all_&measure._own_ew
				rank_2.all_&measure._own_ic 
 ;
	run ;

%mend ;

 
%macro executeall ( model ) ;
	%let lib= &rolling._&model ;
	%let destinated1= rank_2.all_&measure._&model ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1.1 calculate MAE.sas" ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1b calculate measure for each category.sas" ;
	proc sort data= &destinated1 ;
		by category ;
	run ;
%mend ;

%org1 (mae);

 


%macro executeall ( model ) ;
	%let lib= &rolling._&model ;
	%let destinated1= rank_2.all_&measure._&model ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1.2 calculate MAPE.sas" ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1b calculate measure for each category.sas" ;
%mend ;
 
%org1 (mape) ;


%macro executeall ( model ) ;
	%let lib= &rolling._&model ;
	%let destinated1= rank_2.all_&measure._&model ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1.3 calculate SMAPE.sas" ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1b calculate measure for each category.sas" ;
%mend ;

%org1 (smape) ;



 
%macro executeall ( model ) ;
	%let lib= &rolling._&model ;
	%let destinated1= rank_2.all_&measure._&model ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1.5 calculate MPE.sas" ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1b calculate measure for each category.sas" ;
%mend ;

%org1 (mpe) ;

 

%macro executeall ( model ) ;
	%let lib= &rolling._&model ;
	%let destinated1= rank_2.all_&measure._&model ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1.4 calculate MASE.sas"  ;
	%include " Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 1b calculate measure for each category.sas" ;
%mend ;

%org1 (mase) ;






 
