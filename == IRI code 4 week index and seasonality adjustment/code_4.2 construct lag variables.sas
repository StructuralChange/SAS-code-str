 

/* we now allocate a new week index */
%macro create_index (category) ;
 
	data data4.Data_groc_&category ;
		 merge  data3.Data_groc_&category 
				data1.Week_holiday_dummy ;
		  by week ;
		
			Halloween_lag		=	lag(Halloween) ;
			Thanksgiving_lag	=	lag(Thanksgiving);
			Christmas_lag		=	lag(Christmas);
			NewYear_lag			=	lag(NewYear);
			Presidents_lag		=	lag(Presidents);
			Easter_lag			=	lag(Easter);
			July_4_lag			=	lag(July_4);
			Labor_lag			=	lag(Labor);
			Memoday_lag			=	lag(Memoday) ;
			;
	 
	run ;
	data temp (rename= (index= week )) ;
		set data2.Data_groc_&category  ;
		index= _n_ ;
		drop week ;
	run ;
	data data4_0.Data_groc_&category ;
		 merge  temp
				data1.Week_holiday_dummy ;
		  by week ;
		 drop 
			
		 	units_1 - units_3000 
			dollars_1 - dollars_3000 
			price_1 - price_3000 
			; /* pr_1 - pr_3000 , we cannot drop pr becuase it is an indicator of price reductions */
	 
	run ;


%mend ;

%create_index (	Paptowl	) ;
%create_index (	beer	) ;
%create_index (	carbbev	) ;
%create_index (	blades	) ;
%create_index (	cigets	) ;
%create_index (	coffee	) ;
%create_index (	coldcer	) ;
%create_index (	deod	) ;
*%create_index (diapers	) ;
%create_index (	factiss	) ;
%create_index (	fzdinent	) ;
%create_index (	fzpizza	) ;
%create_index (	hhclean	) ;
%create_index (	hotdog	) ;
%create_index (	laundet	) ;
%create_index (	margbutr	) ;
%create_index (	mayo	) ;
%create_index (	milk	) ;
%create_index (	mustketc	) ;
%create_index (	peanbutr	) ;
%create_index (	photo	) ;
%create_index (	razors	) ;
%create_index (	saltsnck	) ;
%create_index (	shamp	) ;
%create_index (	soup	) ;
%create_index (	spagsauc	) ;
%create_index (	sugarsub	) ;
%create_index (	toitisu	) ;
%create_index (	toothbr	) ;
%create_index (	toothpa	) ;
%create_index (	yogurt	) ;

 
