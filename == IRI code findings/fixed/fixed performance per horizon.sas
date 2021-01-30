




%macro calculate1_initial (skunumber) ;
	data temp1 ;
		set t_&model..Cat_&category._&skunumber ;
		if week= &week ;
		ape= ae/actual ;
		sape= ae/(actual+forecast) ;
		ase= q ;
		sku=&skunumber ;
		category="&category" ;
		keep sku week ape sape ase ae category ;
		
	run ;
	data temp_all_&week._&model ;
		set temp1 ;
	run ;
%mend ;
%macro calculate1 ( skunumber) ;
	data temp1 ;
		set t_&model..Cat_&category._&skunumber ;
		if week= &week ;
		ape= ae/actual ;
		sape= 2*ae/(actual+forecast) ;
		ase= q ;
		sku=&skunumber ;
		category="&category" ;
		keep sku week ape sape ase ae category ;
		
	run ;
	data temp_all_&week._&model ;
		set temp_all_&week._&model  temp1 ;
	run ;
%mend ;





%macro dooall ;




 
%macro organizing1 ;
 
	%let category= beer ; 
	%calculate1_initial (21) ;
	%calculate1 (28) ;
 
	%calculate1 (35) ;
	%calculate1 (38) ;
	%calculate1 (42) ;
	%calculate1 (50) ;
	%calculate1 (106) ;
	%calculate1 (130) ;
	%calculate1 (160) ;
 
%organizing0 ;
%mend ;%organizing1  ;

 

 
%macro organizing1 ;
 
%let category= carbbev ;

%calculate1(2) ;
%calculate1(9) ;
%calculate1(15) ;
%calculate1(17) ;
%calculate1(19) ;
%calculate1(26) ;
%calculate1(29) ;
%calculate1(32) ;
%calculate1(43) ;


%organizing0 ;
%mend ;%organizing1  ;
 
  
%macro organizing1 ;
 
 %let category= coffee ;

%calculate1(92) ;
%calculate1(138) ;
%calculate1(247) ;
%calculate1(250) ;
%calculate1(253) ;
%calculate1(255) ;
%calculate1(294) ;
%calculate1(329) ;
%calculate1(381) ;


%organizing0 ;
%mend ;%organizing1  ;

   
  
%macro organizing1 ;
 
 %let category= fzpizza ;

%calculate1(126) ;
%calculate1(149) ;
%calculate1(210) ;
%calculate1(212) ;
%calculate1(215) ;
%calculate1(217) ;
%calculate1(220) ;
%calculate1(236) ;
 


%organizing0 ;
%mend ;%organizing1  ;

  
%macro organizing1 ;
 
 %let category= hhclean ;

%calculate1(26) ;
%calculate1(183) ;
%calculate1(256) ;
%calculate1(376) ;
%calculate1(402) ;
%calculate1(399) ;
%calculate1(223) ;
%calculate1(288) ;
%calculate1(222) ;


%organizing0 ;
%mend ;%organizing1  ;

  
%macro organizing1 ;
 
 %let category= hotdog ;

%calculate1(20) ;
%calculate1(43) ;
%calculate1(98) ;
%calculate1(161) ;
%calculate1(91) ;
%calculate1(145) ;
%calculate1(109) ;
%calculate1(176) ;
%calculate1(101) ;


%organizing0 ;
%mend ;%organizing1  ;

  
%macro organizing1 ;
 
 %let category= laundet ;

%calculate1(75) ;
%calculate1(440) ;
%calculate1(565) ;
%calculate1(660) ;
%calculate1(116) ;
%calculate1(434) ;
%calculate1(562) ;
%calculate1(680) ;
%calculate1(182) ;


%organizing0 ;
%mend ;%organizing1  ;

  
%macro organizing1 ;
 
 %let category= margbutr ;

%calculate1(19) ;
%calculate1(36) ;
%calculate1(39) ;
%calculate1(88) ;
%calculate1(131) ;
%calculate1(144) ;
%calculate1(158) ;
%calculate1(13) ;
%calculate1(38) ;


%organizing0 ;
%mend ;%organizing1  ;

  
%macro organizing1 ;
 
 %let category= mayo ;

%calculate1(10) ;
%calculate1(22) ;
%calculate1(28) ;
%calculate1(31) ;
%calculate1(33) ;
%calculate1(36) ;
%calculate1(40) ;
%calculate1(2) ;
%calculate1(9) ;


%organizing0 ;
%mend ;%organizing1  ;
 
  
%macro organizing1 ;
 
 %let category= mustketc ;

%calculate1(1) ;
%calculate1(9) ;
%calculate1(22) ;
%calculate1(30) ;
%calculate1(59) ;
%calculate1(62) ;
%calculate1(70) ;
 
 


%organizing0 ;
%mend ;%organizing1  ;

 

  
%macro organizing1 ;
 
 %let category= peanbutr ;

%calculate1(8) ;
%calculate1(11) ;
%calculate1(15) ;
%calculate1(17) ;
%calculate1(24) ;
%calculate1(28) ;
%calculate1(30) ;
%calculate1(9) ;


%organizing0 ;
%mend ;%organizing1  ;

   
  
%macro organizing1 ;
 
 %let category= saltsnck ;

%calculate1(117) ;
%calculate1(162) ;
%calculate1(545) ;
%calculate1(603) ;
%calculate1(1161) ;
%calculate1(1276) ;
%calculate1(1510) ;
%calculate1(1521) ;
%calculate1(1539) ;


%organizing0 ;
%mend ;%organizing1  ;

   
  
%macro organizing1 ;
 
 %let category= soup ;

%calculate1(86) ;
%calculate1(279) ;
%calculate1(300) ;
%calculate1(306) ;
%calculate1(308) ;
%calculate1(311) ;
%calculate1(314) ;
%calculate1(316) ;
%calculate1(318) ;


%organizing0 ;
%mend ;%organizing1  ;

   
  
%macro organizing1 ;
 
 %let category= sugarsub ;

%calculate1(8) ;
%calculate1(34) ;
%calculate1(40) ;
%calculate1(15) ;
 
%calculate1(10) ;
%calculate1(29) ;


%organizing0 ;
%mend ;%organizing1  ;

   
  
%macro organizing1 ;
 
 %let category= toothpa ;

%calculate1(437) ;
%calculate1(118) ;
%calculate1(540) ;
%calculate1(174) ;
%calculate1(276) ;
%calculate1(164) ;
%calculate1(546) ;
%calculate1(440) ;
%calculate1(615) ;


%organizing0 ;
%mend ;%organizing1  ;

 
%mend ;



%macro dooall2 ;
	%do week=151 %to 162 ;
	 
		%let model=base ; %dooall ;
		%let model=own ; %dooall ;
		%let model=adl ; %dooall ;
		%let model=own_ew ; %dooall ;
		%let model=own_ic ; %dooall ;
		%let model=adl_ew ; %dooall ;
		%let model=adl_ic ; %dooall ;
		%let model=f ; %dooall ;
		%let model=f_ewc ; %dooall ;
		%let model=f_ic ; %dooall ;
	%end ;
%mend ;

%dooall2 ;



/* ae */
%macro d1 (model, measure) ;
	%do week = 151 %to 151 ;
		data temp_wk_&week (rename= (&measure = &model._&measure._&week )) ;
			set Temp_all_&week._&model ;
			keep &measure ;
		run ;
		data temp_all_&model._m&measure ;
			set temp_wk_&week ;
		run ;
		proc means data= temp_all_&model._m&measure mean noprint;
			var &model._&measure._&week ;
			output out=x_&week mean=mean ;
		run ;
		data x_&week ;
			set x_&week ;
			week = &week ;
		run ;
	 

	%end ;
	%do week = 152 %to 162 ;
		data temp_wk_&week (rename= (&measure = &model._&measure._&week )) ;
			set Temp_all_&week._&model ;
			keep &measure ;
		run ;
		data temp_all_&model._m&measure ;
			merge temp_all_&model._m&measure temp_wk_&week ;
		run ;
		proc means data= temp_all_&model._m&measure mean noprint ;
			var &model._&measure._&week ;
			output out=x_&week mean=mean ;
		run ;
		data x_&week ;
			set x_&week ;
			week = &week ;
		run ;

	%end ;
	%do week = 151 %to 151 ;
			data x_all_&model._m&measure (rename= (mean=m_&model._&measure)) ;
				set  x_&week ;
				 
				keep mean week ;
			run ;
	%end ;
	%do week = 152 %to 162 ;
			data x_all_&model._m&measure   ;
				set x_all_&model._m&measure x_&week (rename= (mean=m_&model._&measure))  ;
				 
				keep m_&model._&measure week ;
			run ;
	%end ;
	 

%mend ;


%macro doo3 (model) ;
	%d1 (&model, ape);
	%d1 (&model, sape);
	%d1 (&model, ase);
	%d1 (&model, ae);
%mend ;

%doo3 (base) ;
%doo3 (own) ;
%doo3 (adl) ;
%doo3 (own_ew) ;
%doo3 (own_ic) ;
%doo3 (adl_ew) ;
%doo3 (adl_ic) ;
%doo3 (f) ;
%doo3 (f_ewc) ;
%doo3 (f_ic) ;

%macro alalal (measure) ;
data _&measure  ;
	merge  X_all_base_&measure
			X_all_own_&measure
			X_all_adl_&measure
			X_all_own_ew_&measure
			X_all_own_ic_&measure
			X_all_adl_ew_&measure
			X_all_adl_ic_&measure
			X_all_f_&measure
			X_all_f_ewc_&measure
			X_all_f_ic_&measure ;
		by week ;
run ;
%mend ;

%alalal (mae) ;
%alalal (mape) ;
%alalal (mase) ;
%alalal (msape) ;
 
