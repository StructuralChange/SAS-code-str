




/* with trend (week) + half-MSE adjustment for log bias */
 /*
 we tried alternative IC with most 8 obs for IC adj but the performance is not as good as using 16 obs

 */




/* dataset */
libname data "F:\IRI raw data Data Exploration\SAS dataset" ;
libname data1 "e:\= IRI data research\SAS dataset modelling" ;
libname data2 "e:\= IRI data research\SAS dataset modelling imputed" ;
libname data3 "e:\= IRI data research\SAS dataset modelling imputed with seasonality" ;
libname data4 "e:\= IRI data research\SAS dataset modelling imputed with seasonality 2" ;
libname data4_0 "e:\= IRI data research\SAS dataset modelling imputed with seasonality 2 no lags" ; /* this is used for VSM*/
/* description and char of the dataset */
libname data1c "e:\= IRI data research\SAS dataset modelling Category Char" ;
libname s_info "e:\= IRI data research\== Store info and stats" ;



/* selection results by e.g., LASSO */
/* selection from all SKUs ONLY, no lags, no seasonalities */
*libname data_v1 "e:\= IRI data research\VSM data_v1" ;
libname data_v1n "e:\= IRI data research\VSM data_v1n" ;
libname data_v1 "e:\= IRI data research\VSM data_v1" ;



*libname data_v2  "e:\= IRI data research\VSM data_v2" ;
libname data_v2n "e:\= IRI data research\VSM data_v2n" ;

*libname data_v0 "e:\= IRI data research\VSM data_v0" ;
libname data_v0n "e:\= IRI data research\VSM data_v0n" ;
 
*libname data_v3 "e:\= IRI data research\VSM data_v3" ;
libname data_v3n "e:\= IRI data research\VSM data_v3n" ;

libname data_t1 "e:\= IRI data research\VSM data_t1" ;
libname data_t2 "e:\= IRI data research\VSM data_t2" ; 

* model results ;
/* \results group 1*/ 

/*libname r_ses 		"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_SES" ;
	SES model has very bad performance and not included. */

/* Base-lift 	*/
libname r_base 		"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_base_lift" ;
/* ADL-own 		*/
libname r_own2 		"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_r_own2" ;
/* ADL-intra 	*/
libname r_adl4 		"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_r_adl4" ;
/* ADL-own-EWC 	*/
libname r_ow2_ew 	"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_r_ow2_ew" ;
/* ADL-own-IC 	*/
libname r_ow2_ic	"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_r_ow2_ic" ;
/* ADL-intra-EWC 	*/
libname r_ad4_ew	"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_r_ad4_ew" ;
/* ADL-intra-IC 	*/
libname r_ad4_ic	"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_r_ad4_ic" ;
/* ADL-EWC-IC		*/
libname r_EWC_ic	"e:\= IRI data research\SAS model results\Rolling_xx_window\results group 1\SAS model results_r_EWC_IC" ;




 /* to concatenate all the results, for all forecast period, promoted and non-promoted period respectively 
	the results will be exported and analyzed in R */
libname expl_str "e:\= IRI data research\== IRI code 11 explore str_bk and non_str_bk\data" ;



/* the following code was used in results evaluation in SAS, no longer used for this purpose, 
but will be used to explore the determinants of the improved forecasting accuracy
and also boxplots
*/

 
libname rank_0	"e:\= IRI data research\SAS model RANKING\Measures 1\results group 1" ;
libname rank_1	"e:\= IRI data research\SAS model RANKING\Measures 2\results group 1" ;  




/* to explore the determinants of the improved forecasting accuracy, using variables of data characteristics of the product categoies [PCA involved] */
libname expl_cat "e:\= IRI data research\== IRI code 12 measures for category char" ;

 
