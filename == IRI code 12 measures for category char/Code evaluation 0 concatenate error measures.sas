options nonotes nosource ;

proc printto log='Q:\= IRI data research\logsas_evaluation.log';
run;




%include "Q:\= IRI data research\== External macros\code x count rows and columns.sas" ; run ;
%include "Q:\= IRI data research\== IRI code 12 measures for category char\Code evaluation 1 across categories.sas" ;


%macro allcat2 ;


 	/*%error1 (Paptowl);*/
	%error1 (beer ) ;
 
	%error1 (carbbev);
	%error1 (blades);
	%error1 (cigets);

	%error1 (coffee);
	%error1 (coldcer);
	%error1 (deod);
	%error1 (factiss);
	%error1 (fzdinent);

	%error1 (fzpizza);
	%error1 (hhclean);
	%error1 (hotdog);
	%error1 (laundet);
	%error1 (margbutr);

	%error1 (mayo);
	%error1 (milk);
	%error1 (mustketc);
	%error1 (peanbutr);
	%error1 (photo);

	/* %error1 (razors);*/
	%error1 (saltsnck);
	%error1 (shamp);
	%error1 (soup);
	%error1 (spagsauc);

	%error1 (sugarsub);
	%error1 (toitisu);
	%error1 (toothbr);
	%error1 (toothpa);
	%error1 (yogurt);
 
 
%con1  ;  

%mend ;


/* %let output_category= rank_0 ;*/
%let output_category= rank_0 ;


%macro organize1 (model, horizon) ;
 
 
 


	%let measure= mape ; %let model= &model  ; %let tune= all ; %allcat2 ;
	*%let measure= mape ; %let model= &model  ; %let tune= pro ; %allcat2 ;
	*%let measure= mape ; %let model= &model  ; %let tune= non ; %allcat2 ;
 

	%let measure= mae ; %let model= &model  ; %let tune= all ; %allcat2 ;
	*%let measure= mae ; %let model= &model  ; %let tune= pro ; %allcat2 ;
	*%let measure= mae ; %let model= &model  ; %let tune= non ; %allcat2 ;

	%let measure= smape ; %let model= &model  ; %let tune= all ; %allcat2 ;
	*%let measure= smape ; %let model= &model  ; %let tune= pro ; %allcat2 ;
	*%let measure= smape ; %let model= &model  ; %let tune= non ; %allcat2 ;
 
	%let measure= mase ; %let model= &model  ; %let tune= all ; %allcat2 ;
	*%let measure= mase ; %let model= &model  ; %let tune= pro ; %allcat2 ;
	*%let measure= mase ; %let model= &model  ; %let tune= non ; %allcat2 ;
 
 

%mend ;




%organize1(ewc_ic, 8 ); 
%organize1(ewc_ic, 4 ); 
%organize1(ewc_ic, 1 ); 




/*
	%organize1(base,   12 );
	%organize1(own2,   12 ); 
	%organize1(adl4,   12 ); 
	%organize1(ow2_ew, 12 ); 
	%organize1(ad4_ew, 12 ); 
	%organize1(ow2_ic, 12 ); 
	%organize1(ad4_ic, 12 ); 
*/

	%organize1(base,   8 );
	%organize1(own2,   8 ); 
	%organize1(adl4,   8 ); 
	%organize1(ow2_ew, 8 ); 
	%organize1(ad4_ew, 8 ); 
	%organize1(ow2_ic, 8 ); 
	%organize1(ad4_ic, 8 ); 
 
	 
	%organize1(base,   4 );
	%organize1(own2,   4 ); 
	%organize1(adl4,   4 ); 
	%organize1(ow2_ew, 4 ); 
	%organize1(ad4_ew, 4 ); 
	%organize1(ow2_ic, 4 ); 
	%organize1(ad4_ic, 4 ); 

	 
	%organize1(base,   1 );
	%organize1(own2,   1 ); 
	%organize1(adl4,   1 ); 
	%organize1(ow2_ew, 1 ); 
	%organize1(ad4_ew, 1 ); 
	%organize1(ow2_ic, 1 ); 
	%organize1(ad4_ic, 1 ); 
 
