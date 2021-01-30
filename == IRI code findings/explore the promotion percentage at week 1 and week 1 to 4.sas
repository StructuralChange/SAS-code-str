options nonotes nosource ;
%macro runall ;


%org0(beer ,21);
%org1(beer ,28);
%org1(beer ,35);
%org1(beer ,38);
%org1(beer ,42);
%org1(beer ,50);
%org1(beer ,106);
%org1(beer ,130);
%org1(beer ,160);
%org1(carbbev,2);
%org1(carbbev,9);
%org1(carbbev,15);
%org1(carbbev,17);
%org1(carbbev,19);
%org1(carbbev,26);
%org1(carbbev,29);
%org1(carbbev,32);
%org1(carbbev,43);
%org1(coffee,92);
%org1(coffee,138);
%org1(coffee,247);
%org1(coffee,250);
%org1(coffee,253);
%org1(coffee,255);
%org1(coffee,294);
%org1(coffee,329);
%org1(coffee,381);
%org1(fzpizza,126);
%org1(fzpizza,149);
%org1(fzpizza,210);
%org1(fzpizza,212);
%org1(fzpizza,215);
%org1(fzpizza,217);
%org1(fzpizza,220);
%org1(fzpizza,236);
%org1(hhclean,26);
%org1(hhclean,183);
%org1(hhclean,256);
%org1(hhclean,376);
%org1(hhclean,402);
%org1(hhclean,399);
%org1(hhclean,223);
%org1(hhclean,288);
%org1(hhclean,222);
%org1(hotdog,20);
%org1(hotdog,43);
%org1(hotdog,98);
%org1(hotdog,161);
%org1(hotdog,91);
%org1(hotdog,145);
%org1(hotdog,109);
%org1(hotdog,176);
%org1(hotdog,101);
%org1(laundet,75);
%org1(laundet,440);
%org1(laundet,565);
%org1(laundet,660);
%org1(laundet,116);
%org1(laundet,434);
%org1(laundet,562);
%org1(laundet,680);
%org1(laundet,182);
%org1(margbutr,19);
%org1(margbutr,36);
%org1(margbutr,39);
%org1(margbutr,88);
%org1(margbutr,131);
%org1(margbutr,144);
%org1(margbutr,158);
%org1(margbutr,13);
%org1(margbutr,38);
%org1(mayo,10);
%org1(mayo,22);
%org1(mayo,28);
%org1(mayo,31);
%org1(mayo,33);
%org1(mayo,36);
%org1(mayo,40);
%org1(mayo,2);
%org1(mayo,9);
%org1(mustketc,1);
%org1(mustketc,9);
%org1(mustketc,22);
%org1(mustketc,30);
%org1(mustketc,59);
%org1(mustketc,62);
%org1(mustketc,70);
%org1(peanbutr,8);
%org1(peanbutr,11);
%org1(peanbutr,15);
%org1(peanbutr,17);
%org1(peanbutr,24);
%org1(peanbutr,28);
%org1(peanbutr,30);
%org1(peanbutr,9);
%org1(saltsnck,117);
%org1(saltsnck,162);
%org1(saltsnck,545);
%org1(saltsnck,603);
%org1(saltsnck,1161);
%org1(saltsnck,1276);
%org1(saltsnck,1510);
%org1(saltsnck,1521);
%org1(saltsnck,1539);
%org1(soup,86);
%org1(soup,279);
%org1(soup,300);
%org1(soup,306);
%org1(soup,308);
%org1(soup,311);
%org1(soup,314);
%org1(soup,316);
%org1(soup,318);
%org1(sugarsub,8);
%org1(sugarsub,34);
%org1(sugarsub,40);
%org1(sugarsub,15);
%org1(sugarsub,10);
%org1(sugarsub,29);
%org1(toothpa,437);
%org1(toothpa,118);
%org1(toothpa,540);
%org1(toothpa,174);
%org1(toothpa,276);
%org1(toothpa,164);
%org1(toothpa,546);
%org1(toothpa,440);
%org1(toothpa,615);
%mend ;

/* calculate pct of f and d for the first 1 week, fixed */
%macro org0(category, skunumber) ;
	data allall (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if week=151 ;
	run ;

%mend ;

%macro org1(category, skunumber) ;
	data temp (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if week=151 ;
	run ;
	data allall ;
		set allall temp  ;
	run ;
%mend ;

%runall ;


proc means data= allall sum noprint mean ; 
	var f ;
	output out= all_wk1_f sum=sum mean=mean  ;
run ;
proc means data= allall sum noprint mean ; 
	var d ;
	output out= all_wk1_d sum=sum mean=mean  ;
run ;
/* calculate pct of f and d for the first 4 weeks, fixed */
%macro org0(category, skunumber) ;
	data allall (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if 150<week<155 ;
	run ;

%mend ;

%macro org1(category, skunumber) ;
	data temp (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if 150<week<155 ;
	run ;
	data allall ;
		set allall temp  ;
	run ;
%mend ;

%runall ;

proc means data= allall sum mean noprint ; 
	var f ;
	output out= all_wk4_f sum=sum mean=mean ;
proc means data= allall sum mean noprint ; 
	var d ;
	output out= all_wk4_d sum=sum mean=mean ;
run ;


/* calculate pct of f and d for the first 12 weeks, fixed */
%macro org0(category, skunumber) ;
	data allall (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if 150<week<163 ;
	run ;

%mend ;

%macro org1(category, skunumber) ;
	data temp (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if 150<week<163 ;
	run ;
	data allall ;
		set allall temp  ;
	run ;
%mend ;


%runall ;

proc means data= allall sum mean noprint ; 
	var f ;
	output out= all_wk12_f sum=sum mean=mean ;
proc means data= allall sum mean noprint ; 
	var d ;
	output out= all_wk12_d sum=sum mean=mean ;
run ;


/* calculate pct of f and d for the n'th week, fixed */

%macro org0(category, skunumber) ;
	data allall (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if week= &week ;
	run ;

%mend ;

%macro org1(category, skunumber) ;
	data temp (rename = (f_&skunumber=f d_&skunumber=d)) ;
		set data4.Data_factor_&category ;
		keep f_&skunumber d_&skunumber ;
		if week= &week ;
	run ;
	data allall ;
		set allall temp  ;
	run ;
%mend ;

%macro doo(week) ;
%runall ;

	proc means data= allall sum mean noprint ; 
		var f ;
		output out= all_wk&week._f sum=sum mean=mean ;
	proc means data= allall sum mean noprint ; 
		var d ;
		output out= all_wk&week._d sum=sum mean=mean ;
	run ;
%mend ;

%doo (151) ;
%doo (152) ;
%doo (153) ;
%doo (154) ;
%doo (155) ;
%doo (156) ;
%doo (157) ;
%doo (158) ;
%doo (159) ;
%doo (160) ;
%doo (161) ;
%doo (162) ;

%macro doo(week) ;
 

	data each_&week._f ;
		set all_wk&week._f ;
		week= &week ;
	run ;
	data each_&week._d ;
		set all_wk&week._d ;
		week= &week ;
	run ;
%mend ;
%doo (151) ;
%doo (152) ;
%doo (153) ;
%doo (154) ;
%doo (155) ;
%doo (156) ;
%doo (157) ;
%doo (158) ;
%doo (159) ;
%doo (160) ;
%doo (161) ;
%doo (162) ;



data each_all_d ;
	set each_151_d
		each_152_d
		each_153_d
		each_154_d
		each_155_d
		each_156_d
		each_157_d
		each_158_d
		each_159_d
		each_160_d
		each_161_d
		each_162_d ;
data each_all_f ;
	set each_151_f
		each_152_f
		each_153_f
		each_154_f
		each_155_f
		each_156_f
		each_157_f
		each_158_f
		each_159_f
		each_160_f
		each_161_f
		each_162_f ;
run ;
