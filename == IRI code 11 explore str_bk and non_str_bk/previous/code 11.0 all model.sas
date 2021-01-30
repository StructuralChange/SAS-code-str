options nosource nonotes ;


 proc datasets lib=expl_str
 nolist kill;
quit;
run;


 
%macro doo1 (lib0, lib1) ;
proc datasets lib=work
 nolist kill;
quit;
run; 
	%include "Q:\= IRI data research\== IRI code 11 explore str_bk and non_str_bk\code 11.1b explore str_bk and non_str_bk.sas" ;  	/* for all data */
proc datasets lib=work
 nolist kill;
quit;
run; 


	%include "Q:\= IRI data research\== IRI code 11 explore str_bk and non_str_bk\code 11.1 explore str_bk and non_str_bk.sas" ;  	/* for all data */




%mend ;



 

%doo0(r_base, r_own2);
%doo1(r_base, r_adl4);
%doo1(r_base, r_ow2_ew);
%doo1(r_base, r_ad4_ew);
%doo1(r_base, r_ow2_ic);
%doo1(r_base, r_ad4_ic);

 
%doo1(r_own2, r_adl4);
%doo1(r_own2, r_ow2_ew);
%doo1(r_own2, r_ad4_ew);
%doo1(r_own2, r_ow2_ic);
%doo1(r_own2, r_ad4_ic);

 
%doo1(r_adl4, r_ow2_ew);
%doo1(r_adl4, r_ad4_ew);
%doo1(r_adl4, r_ow2_ic);
%doo1(r_adl4, r_ad4_ic);

 
%doo1(r_ow2_ew, r_ad4_ew);
%doo1(r_ow2_ew, r_ow2_ic);
%doo1(r_ow2_ew, r_ad4_ic);

%doo1(r_ad4_ew, r_ow2_ic);
%doo1(r_ad4_ew, r_ad4_ic);

%doo1(r_ow2_ic, r_ad4_ic);




