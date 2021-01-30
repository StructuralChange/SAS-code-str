
options nosource nonotes  ;
 
quit ;

proc printto log='Q:\= IRI data research\logsas2.log' print='Q:\= IRI data research\logsas2list.list' new;
run;

%let end_of_rolling= 35 ; *35 ; /* 35 gives us 18 rolling events */
%let jump=2 ; /* the interval between each rolling event */
%let full_window= 160 ;

%let ewc_window= 140 ; /* the size of the smallest estimation window */
%let ewc_jump= 2 ;  /* the interval for the retained window in the EWC method */

%let ic_obs= 16 ; /* the number of observations we used in the IC method */
%let max_hoirzon= 8 ;
 
 /* 1 Baselift 
%include "Q:\= IRI data research\== IRI code 6 modelling\_code 1.0 CONSOLE r_base.sas" ;
*/
 
 /* 3 r_own2 */ 
%include "Q:\= IRI data research\== IRI code 6 modelling\_code 3.0 CONSOLE r_own2.sas" ;

 
 /* 7 r_adl4 */ 
%include "Q:\= IRI data research\== IRI code 6 modelling\_code 7.0 CONSOLE r_adl4.sas" ;

 


  /* 11 r_own2_ic */ 
%include "Q:\= IRI data research\== IRI code 6 modelling\_code 11.0 CONSOLE r_ow2_ic.sas" ;




 /* 13 r_ad4_ic */ 
%include "Q:\= IRI data research\== IRI code 6 modelling\_code 13.0 CONSOLE r_ad4_ic.sas" ;

 
 /* 11 r_ow2_ew */ 
%include "Q:\= IRI data research\== IRI code 6 modelling\_code 8.0 CONSOLE r_ow2_ew.sas" ;





 /* 10 r_ad4_ew */ 
%include "Q:\= IRI data research\== IRI code 6 modelling\_code 10.0 CONSOLE r_ad4_ew.sas" ;



 
