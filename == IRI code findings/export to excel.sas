%macro exportdata (lib) ; 
data all1 ;
	set &lib..ranking_mape ;
	i=_n_ ;
data all2 ;
	set &lib..ranking_smape ;
	i=_n_ ;
data all3 ;
	set &lib..ranking_mase ;
	i=_n_ ;;
run ;

data all_&lib ;
	merge all1 all2 all3 ;
	by i ;
	drop i ;
run ;
%mend ;
%exportdata(r_g_1_1) ;
%exportdata(r_g_4_1) ;
%exportdata(r_g_12_1) ;

%exportdata(t_g_1_1) ;
%exportdata(t_g_4_1) ;
%exportdata(t_g_12_1) ;


/* non promo */

%exportdata(r_g_1_2) ;
%exportdata(r_g_4_2) ;
%exportdata(r_g_12_2) ;

%exportdata(t_g_1_2) ;
%exportdata(t_g_4_2) ;
%exportdata(t_g_12_2) ;

/*   promo */

%exportdata(r_g_1_3) ;
%exportdata(r_g_4_3) ;
%exportdata(r_g_12_3) ;

%exportdata(t_g_1_3) ;
%exportdata(t_g_4_3) ;
%exportdata(t_g_12_3) ;
