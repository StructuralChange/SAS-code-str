options nonotes nosource ;

proc printto log='Q:\= IRI data research\logsas_evaluation.log';
run;




%include "Q:\= IRI data research\== External macros\code x count rows and columns.sas" ; run ;
%include "Q:\= IRI data research\== IRI code 9 organizing results 2 calculate error measures\EWC_IC generate results\Code X evaluation 1.sas" ;


%macro allcat2 ;


 	*%error1 (Paptowl);
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

	*%error1 (razors);
	%error1 (saltsnck);
	%error1 (shamp);
	%error1 (soup);
	%error1 (spagsauc);

	%error1 (sugarsub);
	%error1 (toitisu);
	%error1 (toothbr);
	%error1 (toothpa);
	%error1 (yogurt);
 
  

%mend ;

%allcat2 ; 

