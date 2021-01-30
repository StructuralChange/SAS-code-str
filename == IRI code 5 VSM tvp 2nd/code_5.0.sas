options nonotes nosource ;
 %include "Q:\= IRI data research\code 5_ VSM settings.sas" ;
/* for each SKU, we choose the following variables:
 extract from data_t1, and add seasonalities including
		Halloween	Thanksgiving	Christmas	NewYear	Presidents	Easter	July_4	Labor	Memoday	
		m1	m2	m3	m4	m5	m6	m7	m8	m9	m10	m11	m12	
		Halloween_lag	Thanksgiving_lag	Christmas_lag	NewYear_lag	Presidents_lag	Easter_lag	July_4_lag	Labor_lag	Memoday_lag
		; 
and then we implement LASSO with 10 split cross validation, 
the retained variables are stored in library data_t2
*/






/* we load an external macro which extract the number of rows and columns of a table */
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;



/* this two files (including the one quoted below) conduct the VSM stage 2 */
%macro implement_sub (category) ;
	dm 'odsres; select all;clear;';  
	dm"odsres; clear; out; clear;";
	%include "Q:\= IRI data research\== IRI code 5 VSM tvp 2nd\code_5.1.sas" ;
%mend ;

 

/* this file selects via LASSO the core explanatory variables for each SKU in a category */
/* we can respecify the start and the end date so we can 're-select' the variables for each rolling event */
 
/* N rolling events in total */
 

%dooo ;










