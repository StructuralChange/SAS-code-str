﻿
 /* rank all the candidate models */

%let measure= smape ; 
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 2.1 ranking the models.sas" ;

%let measure= mae ;   
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 2.1 ranking the models.sas" ;

%let measure= mape ;  
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 2.1 ranking the models.sas" ;
%let measure= mase ;  
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 2.1 ranking the models.sas" ;
 
%let measure= mpe ;  
%include "Q:\= IRI data research\== IRI code findings\Forecasting period all\code 2.1 ranking the models.sas" ;