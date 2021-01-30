

/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/

/*
* This macro is the 1 st out of 4 macroes which extracts data from a single store, and restructure the dataset for modelling purposes afterwards ;
* skulist will be the file containing the matching list between original sku number and new sku number ;
* Data_store_structured will be the final output ;

/* step 1: extract the data from a store, say, 222077, 

%let category= paptowl ;
%let store= 222077 ;

the store can be changed by changing the store number in macro 2.0 ;*/



/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/





 


 
/* first we pick up the data from the chosen store, e.g. as specified in macro 2.0 by the parameters ;*/
%macro pickup_category_store ;
data data_store ;
	set data.&category._&channel._all ;
	if iri_key = &store ;
run ;
%mend ;
%pickup_category_store ;
 
/* the data we now have are for one specific score only, but the SKU number is stored separately as system, generation, vend, and item numbers,
	we need to combine them into one single SKU number ;
* thus we firstly sort these numbers according to system, generation, vend, and item number ;*/
proc sort data= data_store out= data_store_sorted ;
	by sy ge vend item week ;
run ;
/*  then we combine them into one SKU number following the formula suggested by the IRI data guide ;*/
data data_store_sorted ;	
	set data_store_sorted ;
	colsku = sy*100000000000+ge*10000000000+vend*100000+item ; * as suggested by IRI guide ;
run ;

/*  meanwhile, we need to construct a list which contains all the SKU's (without duplication) ;*/
data skulist ;
	set data_store_sorted ;
	keep colsku ;
proc sort data= skulist out= skulist nodup ;
	by colsku ;
run ;

/*  We store the SKU numbers as global variables as we will quote them later ;*/
data skulist;
   set skulist;
   temp= _n_ ;
   call symput('s'||strip(temp),colsku);
run;
/*  the codes above allow us to have sku numbers stored in global variables s1, s2, ... s(n) 
	e.g. the value represented by global variable 's1' is the number of the first SKU in the SKU list (i.e. skulist) 
	 	 the value represented by global variable 's(n)' is the number of the last SKU in the SKU list (i.e. skulist) ;
** %put &s24 ; 

* once we can represent individual SKU by individual variables, we can create separate data for each individual SKU ;
* the following macro extracts the data based on the skunumber, and construct the new dataset for that SKU, 
 this macro requires the input of the SKU number ;*/
%macro splitsku (skunumber) ;
data data_sku_&skunumber ( rename = (
			  units= 	units_&skunumber   
			  dollars=  dollars_&skunumber
			  f=		f_&skunumber
			  d=		d_&skunumber
			  pr=		pr_&skunumber 
			)) ;

	set Data_store_sorted ;
	if colsku= &&s&skunumber ;
	keep week units dollars f d pr  ;
run ;

proc sort data= data_sku_&skunumber ;
	by week ;
run ;
%mend ;
 


/*  to run the macro above for each SKU, we need to know how many SKUs we have in total,
	we can do this by using the addon macros (in this directory of the file);*/
%obsnvars(skulist) ;
/* %put &dset has &nvars variable(s) and &nobs observation(s).;
* thus we have &nobs SKU's ;

* eventually we can execute the macro %splitsku for &nobs times, split the raw data into &nobs dataset, 
	based on the SKU number stored in the &nobs variables ;*/
%macro implement   ;
	%do i= 1 %to &nobs ;
		%splitsku (&i) ;
		%if &i=1 %then %do ; * these sentence creates the initial data set ;
			data data_store_structured ;
				set data_sku_&i ;
			run ;
		%end ;
		%else %do ;
			data data_store_structured ;
					merge data_store_structured 
						  data_sku_&i ; 
						by week ;
			run ;
			proc delete data= data_sku_&i  ;
			run ;
		%end ;
	%end ;
%mend ;
%implement   ;





