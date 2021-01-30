

/* this macro export the dataset containing the error measure for each SKU.
the output dataset will be used for the boxplot for each product category */



options nonotes nosource ;



%macro export2csv   ;

proc export data=rank_0.All_comparison_all_8_mase
    outfile="Q:\= IRI data research\Manuscript for  SUBMISSION\= output improvement per category boxplot\All_comparison_all_8_mase.csv"
    dbms=csv
    replace;
 
run;
%mend ;
%export2csv ;
