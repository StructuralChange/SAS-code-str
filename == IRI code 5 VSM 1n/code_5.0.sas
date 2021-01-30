options nonotes nosource ;
 %include "Q:\= IRI data research\code 5_ VSM settings.sas" ;
/* for each SKU, we choose the following variables:

the price, feature, and display of ALL the SKU's in the dataset

		; 
and then we implement LASSO with 10 split cross validation, 

NO ADD BACK, this is for tvp variants

the retained variables are stored in library data_v1
*/






/* we load an external macro which extract the number of rows and columns of a table */
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;


%macro implement_sub (category) ;
	dm 'odsres; select all;clear;';  
	dm"odsres; clear; out; clear;";
	%include "Q:\= IRI data research\== IRI code 5 VSM 1n\code_5.1.sas" ;


%mend ;






/* this file selects via LASSO the core explanatory variables for each SKU in a category */
/* we can respecify the start and the end date so we can 're-select' the variables for each rolling event */
 
/* N rolling events in total */
 

%dooo ;












