%macro obsnvars(ds);
 %global dset nvars nobs;
 %let dset=&ds;

 /* Open data set passed as the macro parameter */
 %let dsid = %sysfunc(open(&dset));

 /* If the data set exists, then grab the number of observations and variables */
 /* then close the data set                                                    */
 %if &dsid %then
   %do;
      %let nobs =%sysfunc(attrn(&dsid,nobs));
      %let nvars=%sysfunc(attrn(&dsid,nvars));
      %let rc = %sysfunc(close(&dsid));
   %end;

 /* Otherwise, write a message that the data set could not be opened */
 %else %put open for data set &dset failed - %sysfunc(sysmsg());
%mend obsnvars;


/* Execute the macro -- pass TEST as the data set parameter 

%obsnvars(test)
* /
* %put &dset has &nvars variable(s) and &nobs observation(s).;
*/
