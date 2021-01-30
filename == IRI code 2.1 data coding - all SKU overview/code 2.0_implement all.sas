options nonotes nosource ;
/* we load an external macro which extract the number of rows and columns of a table */
%include 'Q:\= IRI data research\== External macros\code x count rows and columns.sas' ; run ;

/* in this study we focus on the grocery channel, (there is another channel called 'drug' in the raw data)*/ ;
%let channel= groc ; 
 
/* implement the sub macros 2.1, 2.2, 2.3, and 2.4 */
%macro loopall (category, store)  ;
	%include 'Q:\= IRI data research\== IRI code 2.1 data coding - all SKU overview\code 2.1_restructuring the data.sas' ;run ;
	%include 'Q:\= IRI data research\== IRI code 2.1 data coding - all SKU overview\code 2.2_select valid SKUs and data imputation.sas' ;run ;
	%include 'Q:\= IRI data research\== IRI code 2.1 data coding - all SKU overview\code 2.3_pre processing data.sas' ;run ;
	%include 'Q:\= IRI data research\== IRI code 2.1 data coding - all SKU overview\code 2.4_construct complete variable set.sas' ;run ;
%mend ;
 
 
/* we try to focus on the scores with high sales for each category ; 
i.e., the data for different product categories are from different stores 
the store numbers are extracted from All_merged_all.
*/
 
%loopall(paptowl,222077) ;
%loopall(carbbev,646857) ;
%loopall(blades,278571) ;
%loopall(beer,258282) ;
%loopall(cigets,258282) ;
%loopall(coffee,649405) ;
%loopall(coldcer,225023) ;
%loopall(deod,278571) ;
%loopall(diapers,229757) ;
%loopall(factiss,283639) ;
%loopall(fzdinent,648235) ;
%loopall(fzpizza,649405) ;
%loopall(hhclean,268492) ;
%loopall(hotdog,293283) ;
%loopall(laundet,648235) ;
%loopall(margbutr,648235) ;
%loopall(mayo,288146) ;
%loopall(milk,649405) ;
%loopall(mustketc,288146) ;
%loopall(peanbutr,288146) ;
%loopall(photo,283639) ;
%loopall(razors,278571) ;
%loopall(saltsnck,225023) ;
%loopall(shamp,278571) ;
%loopall(soup,648235) ;
%loopall(spagsauc,283639) ;
%loopall(sugarsub,648235) ;
%loopall(toitisu,648235) ;
%loopall(toothbr,278571) ;
%loopall(toothpa,293283) ;
%loopall(yogurt,268492) ;
