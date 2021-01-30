* construct a table containing the valid percentage for all the categories ;
* this macro follows up the execution of 2.0 ;

%macro change1_0 (category) ;
	data valid_all_categories (rename = (col1= cat_&category)) ;
		set data1.Valid_picture_&category ;
		keep col1 ;
	run ;

%mend ;
%macro change1 (category) ;
	data Valid_picture_&category (rename = (col1= cat_&category)) ;
		set data1.Valid_picture_&category ;
		keep col1 ;
	run ;

	data valid_all_categories ;
		merge valid_all_categories Valid_picture_&category ;
	run ;
%mend ;

%change1_0(beer) ; 

%change1(carbbev) ;
%change1(blades) ; 
%change1(cigets );
%change1(coffee );

%change1(coldcer) ;
%change1(deod );
%change1(diapers );
%change1(factiss );
%change1(fzdinent );

%change1(fzpizza) ;
%change1(hhclean );
%change1(hotdog );
%change1(laundet );
%change1(margbutr );

%change1(mayo );
%change1(milk) ;
%change1(mustketc) ;
%change1(paptowl );
%change1(peanbutr);

%change1(photo);
%change1(razors );
%change1(saltsnck );
%change1(shamp );
%change1(soup);

%change1(spagsauc);
%change1(sugarsub );
%change1(toitisu);
%change1(toothbr );
%change1(toothpa );

%change1(yogurt );
