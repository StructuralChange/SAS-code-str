options nonotes nosource ;
 %include "Q:\= IRI data research\code 5_ VSM settings.sas" ;
/* combine the variables in v0n and v2n
with and without competitive_in combine

*/
/* we load an external macro which extract the number of rows and columns of a table */
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;



/* this two files (including the one quoted below) conduct the VSM stage 2 */
%macro implement_sub (category) ;
	dm 'odsres; select all;clear;';  
	dm"odsres; clear; out; clear;";
	%include "Q:\= IRI data research\== IRI code 5 VSM 3n\code_5.1.sas" ;
%mend ;

 

/* this file selects via LASSO the core explanatory variables for each SKU in a category */
/* we can respecify the start and the end date so we can 're-select' the variables for each rolling event */
 
/* N rolling events in total */
%dooo ;










