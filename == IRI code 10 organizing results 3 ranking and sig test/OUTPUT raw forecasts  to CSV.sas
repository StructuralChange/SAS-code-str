




options nonotes nosource ;



%macro export2csv (period, model1, model2) ;

proc export data=expl_str.&period._r_&model1._versus_r_&model2 
    outfile="q:\= IRI data research\Manuscript for  SUBMISSION\= rank results and conduct significant test\Results and Diebold and Mariana test\results data\&period._r_&model1._versus_r_&model2..csv"
    dbms=csv
    replace;
 
run;
%mend ;
%export2csv(overall, adl4, ad4_ew) ;
%export2csv(overall, adl4, ad4_ic) ;
%export2csv(overall, adl4, ewc_ic) ;


%export2csv(non, adl4, ad4_ew) ;
%export2csv(non, adl4, ad4_ic) ;
%export2csv(non, adl4, ewc_ic) ;


%export2csv(pro, adl4, ad4_ew) ;
%export2csv(pro, adl4, ad4_ic) ;
%export2csv(pro, adl4, ewc_ic) ;

%export2csv(overall, own2, base) ;
%export2csv(overall, own2, ow2_ic) ;
%export2csv(overall, own2, ow2_ew) ;
%export2csv(overall, own2, adl4) ;

%export2csv(non, own2, base) ;
%export2csv(non, own2, ow2_ic) ;
%export2csv(non, own2, ow2_ew) ;
%export2csv(non, own2, adl4) ;

%export2csv(pro, own2, base) ;
%export2csv(pro, own2, ow2_ic) ;
%export2csv(pro, own2, ow2_ew) ;
%export2csv(pro, own2, adl4) ;
 

