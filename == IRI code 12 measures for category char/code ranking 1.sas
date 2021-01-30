
options nonotes nosource ;
 


%macro sort1 ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._base_&separate_str  ;
		by category sku ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._own2_&separate_str ;
		by category sku ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._adl4_&separate_str ;
		by category sku ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._ow2_ew_&separate_str ;
		by category sku ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._ad4_ew_&separate_str ;
		by category sku ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._ow2_ic_&separate_str ;
		by category sku ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._ad4_ic_&separate_str ;
		by category sku ;
	proc sort data = rank_0.r_h&horizon._allcat_&measure._ewc_ic_&separate_str ;
		by category sku ;
	run ;

%mend ;
%sort1 ;
 

%macro mergeall   ;
data rank_0.all_comparison_&separate_str._&horizon._&measure  ;
	merge  
		 
		rank_0.r_h&horizon._allcat_&measure._base_&separate_str
		rank_0.r_h&horizon._allcat_&measure._own2_&separate_str
		rank_0.r_h&horizon._allcat_&measure._adl4_&separate_str
		rank_0.r_h&horizon._allcat_&measure._ow2_ew_&separate_str
		rank_0.r_h&horizon._allcat_&measure._ad4_ew_&separate_str 
		rank_0.r_h&horizon._allcat_&measure._ow2_ic_&separate_str
		rank_0.r_h&horizon._allcat_&measure._ad4_ic_&separate_str
		rank_0.r_h&horizon._allcat_&measure._ewc_ic_&separate_str
 
		    ;  
		  by category sku ;
run ;
%mend ;
%mergeall   ;

 







