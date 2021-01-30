options nonotes nosource ;
%macro copyall (library1) ;
	%macro copy1 ;
		data &library1..All_comparison_&measure ;
			set All_comparison_&measure ;
		run ;
		data &library1..Ranking_&measure ;
			set Ranking_&measure ;
		run ;
		data &library1..Sig_&measure ;
			set Sig_&measure ;
		run ;
		data &library1..Comparison_&measure ;
			set rank_2.Comparison_&measure ;
		run ;
	%mend ;


	%let measure=mae ; %copy1 ;
	%let measure=mape ; %copy1 ;
	%let measure=smape ; %copy1 ;
	%let measure=mase ; %copy1 ;
	%let measure=mpe ; %copy1 ;

	proc datasets library=work kill noprint;
	proc datasets library=rank_all kill noprint;
	proc datasets library=rank_2 kill noprint;
	run;
	quit ;
 

%mend ;

/* rolling events */ 
/* all forecast period */ ;
%let horizon0=1 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console C significance test.sas" ;
%copyall (r_g_1_1) ;

%let horizon0=4 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console C significance test.sas" ;
%copyall (r_g_4_1) ;

%let horizon0=12 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 0 console C significance test.sas" ;
%copyall (r_g_12_1) 


/* non period */ ;
%let horizon0=1 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console C significance test.sas" ;
%copyall (r_g_1_2) ;

%let horizon0=4 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console C significance test.sas" ;
%copyall (r_g_4_2) ;

%let horizon0=12 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period non\code 0 console C significance test.sas" ;
%copyall (r_g_12_2) 


/* promoted period */ ;
%let horizon0=1 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console C significance test.sas" ;
%copyall (r_g_1_3) ;

%let horizon0=4 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console C significance test.sas" ;
%copyall (r_g_4_3) ;

%let horizon0=12 ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\Forecasting period promoted\code 0 console C significance test.sas" ;
%copyall (r_g_12_3) 


/* fixed events */

/* all forecast period */ ;
%let horizon0=1 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console C significance test.sas" ;
%copyall (t_g_1_1) ;

%let horizon0=4 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console C significance test.sas" ;
%copyall (t_g_4_1) ;

%let horizon0=12 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period all\code 0 console C significance test.sas" ;
%copyall (t_g_12_1) 


/* non period */ ;
%let horizon0=1 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console C significance test.sas" ;
%copyall (t_g_1_2) ;

%let horizon0=4 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console C significance test.sas" ;
%copyall (t_g_4_2) ;

%let horizon0=12 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period non\code 0 console C significance test.sas" ;
%copyall (t_g_12_2) 


/* promoted period */ ;
%let horizon0=1 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console C significance test.sas" ;
%copyall (t_g_1_3) ;

%let horizon0=4 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console C significance test.sas" ;
%copyall (t_g_4_3) ;

%let horizon0=12 ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console A calculate overall results.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console B ranking.sas" ;
%include "Q:\= IRI data research\== IRI code findings\fixed\Forecasting period promoted\code 0 console C significance test.sas" ;
%copyall (t_g_12_3) 


 
