/*--------------------------------------------------------------------------*
                                S A S   Program
                        Multivariate Subset Selection
                                      By:
                               Ali A. Al-Subaihi
                        		Research Center
                       Institute of Public Administration
                               subaihia@ipa.edu.sa

     The program designed to give the subset of predictors (x's)
 (independent variables) that "best" predict all dependent variables (y's)
 jointly according to the multivariate version of the following criteria:
 1) Automatic Search Procedures, which contains
        a) Forward Selection
        b) Backward Elimination
        c) Forward Stepwise Selection
 The procedures are based on Wilks' Lambda (for details, see Rancher, pp.
 383-385, 1995).
 2) All-Possible-Regression Procedures, which are
        a) Residual Mean Square Error (Rencher, 1995)
		b) Coefficient of Multiple Determination (Rsq)(Rencher, 1995)
		c) Adjusted Coefficient of Multiple Determination (AdjRsq)(Rencher, 1995)
        d) Akaike's Information Criterion (AIC)(Akaike, 1973)
        e) The Corrected Form of AIC (AICC) (McQuarrie & Tsai, 1998)
        f) Hannan and Quinn Criterion (HQ) (Hannan and Quinn, 1979)
        g) The Corrected Form of Hannan and Quinn (HQc) Information Criterion
           (McQuarrie & Tsai, 1998)
        h) Schwarz Criterion (BIC) (Schwarz, 1978)
        i) Mallow's Cp (Spark et al., 1983)

     The program works as follows:
 1) Go to the end of the program and delete the provided data. Paste your data
    in the same place and way the old data used to be.
 2) Adjust the matrices Y and X so that they read your and dependent
     independent variables, respectively.
 3) Save the changes and submit the program.

 Notes:
 1) The program designed to use the determent function to reduce all matrices
    into scalar.
 2) The program has no problem in case of 9 predictors were used, however the
    FW, in the RESET statement, needs to be increased by 2 digits for each
    extra predictor. For example, Fw=11 in case of 10 predictors were used,
    FW=13 if 11 predictors were used, and so on. If this adjustment was not
    made, variables' names will be changed.
 3) Because the nature of the multivariate version of the Cp is different from
    the univariate, the criteria could suggest more than one subset of
    predictors.
 4) To have complete output, print the output in landscape orientation. 

 References

 1) Akaike, H. (1973), "Information Theory and an Extension of The Maximum
        Likelihood Principle", In B.N. Petrov and F. Csaki ed., 2nd
        International Symposium on Information Theory, pp. 267-281, Akademia
        Kiado, Budapest.
 2) Hannan, E.J. and quinn, B.G. (1979), " The Determination of the Order of
        an Autoregression", Journal of the Royal Statistical Society, Series
        B, 41, 190-195.
 3) McQuarrie A. D., and Tsai, C. (1998), "Regression and Time Series Model
        Selection", World Scientific Publishing Co. Pte. Ltd., River Edge, NJ.
 4) Rencher, A. C. (1995), "Methods of Multivariate Analysis",
        John Wiley & Sons Inc., New York, New York.
 5) Schwarz, M.J. (1978), " Estimating the Dimension of a Model" Annals of
        Statistics, 6,461-464.
 6) Spark, R.S., Coutsourides, D. and Troskie, L. (1983), " The Multivariate
        Cp", Communications in Statistics-Theory and Methods, 12, 1775-1793.

 Copyright Note. The software can be freely used for
                 non-commercial purposes and can be
                 freely distributed.

*--------------------------------------------------------------------------*/
/*---------------------------- Tobacco Data -----------------------------------*
Anderson and Bancroft (1952, p. 205) presented data on chemical components of 
25 tobacco leaf samples. The dependent variables are
	Y1 : Rate of cigarette burn in inches per 1000 seconds
	Y2 : Percent sugar in the leaf
	Y3 : Percent nicotine
The independent variables are fixed and are
	X1 : Percentage of Nitrogen		X4 : Percentage of Phosphorus
	X2 : Percentage of Chlorine		X5 : Percentage of Calcium
	X3 : Percentage of Potassium	X6 : Percentage of Magnesium 

*----------------------------------------------------------------------------------*/

Data tobacco;
input y1 y2 y3 x1 x2 x3 x4 x5 x6;
cards;
1.55	20.05	1.38	2.02	2.90	2.17	0.51	3.47	0.91	
1.63	12.58	2.64	2.62	2.78	1.72	0.50	4.57	1.25	
1.66	18.56	1.56	2.08	2.68	2.40	0.43	3.52	0.82	
1.52	18.56	2.22	2.20	3.17	2.06	0.52	3.69	0.97	
1.70	14.02	2.85	2.38	2.52	2.18	0.42	4.01	1.12	
1.68	15.64	1.24	2.03	2.56	2.57	0.44	2.79	0.82	
1.78	14.52	2.86	2.87	2.67	2.64	0.50	3.92	1.06	
1.57	18.52	2.18	1.88	2.58	2.22	0.49	3.58	1.01	
1.60	17.84	1.65	1.93	2.26	2.15	0.56	3.57	0.92	
1.52	13.38	3.28	2.57	1.74	1.64	0.51	4.38	1.22	
1.68	17.55	1.56	1.95	2.15	2.48	0.48	3.28	0.81	
1.74	17.97	2.00	2.03	2.00	2.38	0.50	3.31	0.98	
1.93	14.66	2.88	2.50	2.07	2.32	0.48	3.72	1.04	
1.77	17.31	1.36	1.72	2.24	2.25	0.52	3.10	0.78	
1.94	14.32	2.66	2.53	1.74	2.64	0.50	3.48	0.93	
1.83	15.05	2.43	1.90	1.46	1.97	0.46	3.48	0.90	
2.09	15.47	2.42	2.18	0.74	2.46	0.48	3.16	0.86	
1.72	16.85	2.16	2.16	2.84	2.36	0.49	3.68	0.95	
1.49	17.42	2.12	2.14	3.30	2.04	0.48	3.28	1.06	
1.52	18.55	1.87	1.98	2.90	2.16	0.48	3.56	0.84	
1.64	18.74	2.10	1.89	2.82	2.04	0.53	3.56	1.02	
1.40	14.79	2.21	2.07	2.79	2.15	0.52	3.49	1.04	
1.78	18.86	2.00	2.08	3.14	2.60	0.50	3.30	0.80	
1.93	15.62	2.26	2.21	2.81	2.18	0.44	4.16	0.92	
1.53	18.56	2.14	2.00	3.16	2.22	0.51	3.73	1.07	
;
					/* Input statement*/
/*	Data tobacco;
	infile 'filename.dat';
	input y1 y2 y3 x1 x2 x3 x4 x5 x6; */

 PROC IML;
 Reset  FW= 9  noname linesize=120 pagesize=60;
 use tobacco;
 read all var{y1 y2 y3} into Y;				/* The dependent variables      */
 read all var {x1 x2 x3 x4 x5 x6} into X;	/* The independent variables    */

START INITIAL;                   /*----Initialization Module ---*/
  N=NROW(X);                     /* Number of Observations      */
  K=NCOL(X);                     /* Total No. of ind. var.      */
  Q=NCOL(Y);                     /* Total No. of dep. var.      */
  K1=K+1;                        /* No. of ind. + intercept     */
  IK=1:K;                        /* Ind. var. names (1 2 .. k)  */
  Test=1;                        /* Initial prob. to enter var. */
  R1=0:(q-1);                    /* Rank's values               */
                                 /* (Names of all ind. var.     */
  ALL_idv=num(rowcatc(char(ik)));/* ordered from 1-k )          */
  F_Enter=Int(finv(.95,1,(n-k)));/* Min acceptable F to Enter   */
  F_Rmv=F_Enter-.1;              /* Max acceptable F to Remove  */
  Lm_ENTER=(n-k)/(F_Enter+(n-k));/* Max acceptable Lm to enter  */
  Lm_RMV=(n-k)/(F_Rmv+(n-k));    /* Min acceptable Lm to remove */
  BNAMES={VAR MSE RSQUARE AdjRsq /*                             */
        AIC AICc HQ  HQIC BIC    /*                             */
         Cp UpLm Novar};         /*                             */
  /*---CORRECT BY MEAN, ADJUST OUT INTERCEPT PARAMETER----------*/
  Y=Y-REPEAT(Y[+,]/N,N,1);       /* CORRECT Y BY MEAN           */
  X=X-REPEAT(X[+,]/N,N,1);       /* CORRECT X BY MEAN           */
  H=X*INV(X`*X)*X`;              /* H matrix                    */
  YP=Y[+,]/N;                    /* MEANS OF COLUMNS OF Y       */
  XPY=X`*Y;                      /* CROSSPRODUCTS               */
  YPY=Y`*Y;                      /*                             */
  XPX=X`*X;                      /*                             */
  SSEk=y`*(I(n)-H)*y;            /* Sum sq. of err. for all x's */
  SSTO= YPY-(N*YP`*YP);          /* Total sum square of error   */
  CONST= det(SSTO);              /* Determinant of SSTO matrix  */
  CSAVE=(XPX || XPY) //          /*                             */
        (XPY`|| YPY);            /* SAVED COPY OF CROSSPRODUCTS */
 FOOTNOTE 'Independent variables that appear as 1, 2, 3, ..., 12 13 etc., they mean x1, X2, ..., x1 x2, x1 x3, etc.';
FINISH INITIAL;                  /*---- Ends Initialization ----*/


/*-------------- Automatic Search Procedures ------------------------------*/
START STEPWISE;

/*------------------- Start of Partial Lambda Module ----------------------*/
START Lm_PART;                             /*----- Wilk's Lambda Module ---*/
      FREE Lm_VAL;                         /*                              */
        Xs=Indx;                           /*                              */
        LmName={ Lm_Values Ind};           /* Columns' names               */
        DO I=1 TO NCOL(X_TEMP);            /*                              */
          X1=COL_IN||X_TEMP[,I];           /*                              */
          B=INV(X1`*X1)*X1`*Y;             /* COEFFICIENT MATRIX (B)       */
          LEM=DET(YPY-(B`*X1`*Y))/CONST;   /*                              */
          Lm_VAL=Lm_VAL//(LEM/Lm_d);       /* Val. of Partial Wilk's Lambda*/
          FREE X1;                         /*                              */
        END;                               /*                              */
     Xs=Lm_Val||Num(rowcatc(char(Xs)));    /* Lambda values with x's       */
     Xs_old=Xs;                            /*                              */
     Xs[(rank(Xs[,1]))`,]=Xs_Old;          /* Ordering Lambda values (A-Z) */
     Lm_IN=Xs[1,1];                        /* Min value Par. Wilks Lambda  */
                                           /*------------------------------*/
       If Nindx=0 then do;                 /*          Initial Step        */
          print ,'Max acceptable Lambda to enter' Lm_Enter;
          print ,"Lambda to enter given NO Ind. var. already in the model";
          print  xs[ColName=LmName];       /* Lambda to enter              */
           If lm_in<Lm_ENTER then do;      /*                              */
           Sug=Xs[1,];                     /*                              */
           print Sug "  To be entered";    /*                              */
     print '---------------------------------------------------------------';
           End;                            /*                              */
           If lm_in >= Lm_ENTER then do;   /*                              */
           print 'Nothing to be entered';  /*                              */
     print '---------------------------------------------------------------';
           Test=0; ind=0;                  /*                              */
           End;                            /*                              */
       End;                                /*       Ends intial step       */
                                           /*                              */
                                           /*------------------------------*/
     If Nindx>0 then do;                   /*        Next Steps            */
     Ind=Nindx`;                           /*                              */
     Ind_old=Ind;                          /*                              */
     Ind[(Rank(Ind[,1]))`,]=Ind_Old;       /*                              */
     Ind=num(rowcatc(char(ind`)));         /* Var. already in the model    */
     print ,'Max acceptable Lambda to enter' Lm_Enter;
     print "Lambda to enter given =" Ind;  /*                              */
     print xs[ColName=LmName];             /* Lambda to enter              */
           If lm_in<Lm_ENTER then do;      /*                              */
           Sug=Xs[1,];                     /*                              */
           print Sug "  To be entered";    /*                              */
     print '---------------------------------------------------------------';
           End;                            /*                              */
           If lm_in >= Lm_ENTER then do;   /*                              */
           print 'Nothing to be entered';  /*                              */
     print '---------------------------------------------------------------';
           Test=0;                         /*                              */
           End;                            /*                              */
     End;                                  /*         Ends next step       */
                                           /*                              */
      If Nrow(Xs)>1 then                   /*                              */
     Indx=Xs[2:Nrow(Xs),2];                /* COLUMNS TO  BE FITTED        */
      Else Indx=Xs[Nrow(Xs),2];            /*                              */
     Nindx2=Xs[1,2]||Nindx2;               /*                              */
     Nindx=Nindx2;                         /* Columns already in the model */
FINISH Lm_PART;                            /*------ End of the module -----*/
/*------------------- End of Partial Lambda Module ------------------------*/

/*-------------------- (a) Forward Selection ------------------------------*/
      print /, 'Automatic Search Procedures',, '(a) Forward Selection',
          '----------------------------------------------------------------';

   COL_IN=J(N,1);    /*----------------- Step 1 --------------------*/
   X_TEMP=X;         /* Where to fit each x individually            */
   Lm_d=1;           /* When no x selected                          */
   INDX=Ik`;         /* COLUMNS TO  BE FITTED ONE BY ONE (HERE ALL) */
   NINDX=0;          /* COLUMNS ALREADY IN THE MODEL (HERE NONE)    */
   RUN Lm_PART;      /*                                             */
   P=Ncol(nindx2);   /* No. of variables in the model               */
                     /*------------ End of step 1 ------------------*/

 DO Until (Test=0);                             /* ------------ Step 2 ----------*/
   COL_IN=X[,Nindx];                            /* Columns already in the model  */
   HcoL=col_in*inv(col_in`*col_in)*col_in`;     /*                               */
   SScol=y`*(I(n)-HcoL)*y;                      /* (Wilk's Lem. for var. already */
   Lm_d=det(SScol)/const;                       /*  in the model)                */
   X_TEMP=X[,Indx`];                            /* Columns did not enter yet     */
   P=NCOL(nindx2);                              /* NO. OF VAR. IN THE MODEL      */
   If Ncol(nindx)=k then do;                    /* Check if the last var. entered*/
    Ind=Nindx`;                                 /*                               */
    Ind_old=Ind;                                /*                               */
    Ind[(Rank(Ind[,1]))`,]=Ind_Old;             /*                               */
    Ind=num(rowcatc(char(ind`)));               /* Var. already in the model     */
     Goto Skip;                                 /* Stop if the last var. entered */
   End;                                         /* Ends of if condition          */
   If test=0 then goto skip1;                   /*                               */
   RUN Lm_PART;                                 /*                               */
 END;                                           /* Ends of Do loop               */
 Skip1: Forward=ind;                            /*                               */
 Free Xs;                                       /*                               */
 If ind=0 then                                  /*                               */
 print 'Forward Selection Procedure Failed to Find The Best Subset';
 Else                                           /*                               */
 print 'The Best Subset of Predictors is 'ind;  /*-------- End of step 2 --------*/
 Free ind nindx2;

/*-------------------- (b) Forward Stepwise Selection ---------------------*/
   print /,'Automatic Search Procedures',,'(b) Forward Stepwise Selection',
          '----------------------------------------------------------------';
   Test=1;
   COL_IN=J(N,1);    /*----------------- Step 1 --------------------*/
   X_TEMP=X;         /* Where to fit each x individually            */
   Lm_d=1;           /* When no x selected                          */
   INDX=Ik`;         /* COLUMNS TO  BE FITTED ONE BY ONE (HERE ALL) */
   NINDX=0;          /* COLUMNS ALREADY IN THE MODEL (HERE NONE)    */
   RUN Lm_PART;      /*                                             */
   If test=0 then goto skip; /* Stop if no var. entered in this step*/
   P=Ncol(nindx2);   /* No. of variables in the model               */
                     /*------------ End of step 1 ------------------*/


   COL_IN=X[,Nindx];                            /*------------- Step 2 ----------*/
   HcoL=col_in*inv(col_in`*col_in)*col_in`;     /*                               */
   SScol=y`*(I(n)-HcoL)*y;                      /* (Wilk's Lem. for var. already */
   Lm_d=det(SScol)/const;                       /*  in the model)                */
   X_TEMP=X[,Indx`];                            /* Where to fit each x given one */
   RUN Lm_PART;                                 /* of x's already in the model   */
   If test=0 then goto skip;                    /* Stop if no var. entered here  */
   P=NCOL(nindx2);                              /* NO. OF VAR. IN THE MODEL      */
                                                /*-------- End of step 2 --------*/

 DO WHILE(P<k);                                 /* ------------ Step 3 ----------*/
   RUN BACKSTEP;                                /* BACKSTEP MODULE               */
   COL_IN=J(N,1)||X[,Nindx];                    /* Columns already in the model  */
   HcoL=col_in*inv(col_in`*col_in)*col_in`;
   SScol=y`*(I(n)-HcoL)*y;                      /* (Wilk's Lem. for var. already */
   Lm_d=det(SScol)/const;                       /*  in the model)                */
   X_TEMP=X[,Indx`];                            /* Columns did not enter yet     */
   P=NCOL(nindx2);                              /* NO. OF VAR. IN THE MODEL      */
   If Ncol(nindx)=k then do;                    /* Check if the last var. entered*/
    Ind=Nindx`;                                 /*                               */
    Ind_old=Ind;                                /*                               */
    Ind[(Rank(Ind[,1]))`,]=Ind_Old;             /*                               */
    Ind=num(rowcatc(char(ind`)));               /* Var. already in the model     */
     Goto Skip;                                 /* Stop if the last var. entered */
   End;                                         /*                               */
   If test=0 then goto skip;                    /*                               */
   RUN Lm_PART;                                 /*                               */
   If test=0 then goto skip;                    /*                               */
 END;                                           /*                               */
 Skip: Step=ind;                                /*                               */
 Free Xs;                                       /*                               */
 If ind=0 then                                  /*                               */
 print 'The Forward Stepwise Selection Failed to Find The Best Subset of Predictors';
 Else                                           /*                               */
 print 'The Best Subset of Predictors is 'ind;  /*-------- End of step 3 --------*/

 /*-------------------- (c) Backward Elimination -----------------------------*/
      print /, 'Automatic Search Procedures',, '(c) Backward Elimination',
          '----------------------------------------------------------------';
   Nindx=Ik;
   Free Lm_Val;
   Test=1;
   X_TEMP=X[,NINDX];                      /* Data matrix containing all col*/
   LmName={Given Lm_Val Ind};             /*                               */
        Do until (Test=0);                /*                               */
   DO J=NCOL(NINDX) to 1 by -1;           /*                               */
                                          /*                               */
        If ncol(nindx)=1 then do;         /*                               */
         indx_b=nindx;                    /*                               */
         CO_IN=J(N,1)||X_TEMP[,Indx_b];   /*                               */
         XX1=CO_IN;                       /*                               */
         BB1=INV(XX1`*XX1)*XX1`*Y;        /*                               */
         LEM_XX=DET(YPY-(BB1`*XX1`*Y));   /* Wilks' Lam. for X's already in*/
                                          /*                               */
         X1=X;                            /*                               */
         B=INV(X1`*X1)*X1`*Y;             /*                               */
         LEM_TOT=DET(YPY-(B`*X1`*Y));     /* Wilk's Lambda for all X's     */
                                          /*                               */
         Lm_VAL=Lm_VAL//((LEM_TOT/LEM_XX));/* Values of Partial-Lambda     */
         FREE X1;                         /*                               */
         Cin1=indx_b;                     /* Columns already in the model  */
         Notin=0;                         /* Columns not in the model yet  */
         Test=0;                          /*                               */
         Xs=Lm_Val||Cin1;                 /*                               */
         Lm_Out=Xs[,1];                   /* Max values of Wilks' lambda   */
         print ,'Min acceptable Lambda to remove' Lm_rmv;
         print ,"Lambda to remove";       /*                               */
         print  Xs[Colname=LmName];       /*                               */
         Goto skip5;                      /*                               */
        end;                              /* Ends of if condition          */
                                          /*                               */
        If ncol(nindx)>1 then do;         /*                               */
         IM=Repeat(0,Ncol(NINDX),1);      /*                               */
         Im[j,]=^Im[j,];                  /*                               */
         Indx_b=Loc(^im);                 /* COLUMNS ALREADY IN THE MODEL  */
         Nindx_b=loc(im);                 /* COLUMNS NOT IN THE MODEL      */
                                          /*                               */
         CO_IN=J(N,1)||X_TEMP[,Indx_b];   /*                               */
                                          /*                               */
         XX1=CO_IN;                       /*                               */
         BB1=INV(XX1`*XX1)*XX1`*Y;        /*                               */
         LEM_XX=DET(YPY-(BB1`*XX1`*Y));   /* Wilks' Lam. for X's already in*/
                                          /*                               */
         X1=CO_IN||X_TEMP[,NIndx_b];      /*                               */
         B=INV(X1`*X1)*X1`*Y;             /*                               */
         LEM_TOT=DET(YPY-(B`*X1`*Y));     /* Wilk's Lambda for all X's     */
                                          /*                               */
         Lm_VAL=Lm_VAL//((LEM_TOT/LEM_XX));/* Values of Partial-Lambda     */
         FREE X1;                         /*                               */
         Cin1=Cin1//Nindx[,indx_b];       /* Columns already in the model  */
         Notin=notin//Nindx[,nindx_b];    /* Columns not in the model yet  */
        end;                              /* Ends if condition             */
     End;                                 /*                               */
    Cin=Num(rowcatc(char(Cin1)));         /*                               */
    Xs=Cin||Lm_Val||notin;                /*                               */
    Xs_old=Xs;                            /*                               */
    Xs[(rank(Xs[,1]))`,]=Xs_Old;          /* Ordering Lambda values (A-Z)  */
    Lm_Out=Xs[<>,2];                      /* Max values of Wilks' lambda   */
    print ,'Min acceptable Lambda to remove' Lm_rmv;
    print ,"Lambda to remove";            /*                               */
    print  Xs[Colname=LmName];            /*                               */
          aa=Xs[<:>,2];                   /*                               */
          aa=Char(Xs[aa,1]);              /*                               */
          ab=length(aa);                  /*                               */
          Do i7=nrow(Cin1)-2 to 0 by -1;  /*                               */
          ac=ac||Substr(aa,(ab-i7),1);    /*                               */
          End;                            /*                               */
          Nindx=Num(ac);                  /* THE MIN. ACCEPTABLE Lm TO RMV.*/
          free ac;                        /*                               */
    Skip5:                                /*                               */
    IF Lm_Out>Lm_RMV THEN do;             /*                               */
         if test=0 then do;               /*                               */
         sug=Xs[,2:3];                    /*                               */
         print sug '       To be removed',/*                               */
               '-----------------------------------------------------------',
         'The Backward Procedure Failed to Find the Best Subset of Predictors',
               '-----------------------------------------------------------';
         Backward=0;                      /*                               */
         end;                             /*                               */
         if test=1 then do;               /*                               */
         sug=Xs[<:>,2];                   /*                               */
         sug=Xs[Sug,];                    /*                               */
         print sug '    To be removed';   /*                               */
         print '-----------------------------------------------------------';
         end;                             /*                               */
    End;                                  /*                               */
    IF Lm_Out<= Lm_RMV then do;           /*                               */
        print 'Nothing to be removed';    /*                               */
        print '------------------------------------------------------------';
        Not_old=Notin;                    /*                               */
        Notin[(rank(Notin[,1]))`,]=Not_Old;
        Notin=Num(rowcatc(char(Notin)`)); /*                               */
        if test=0 then Backward=Cin1;     /*                               */
        if test=1 then Backward=Notin;    /*                               */
        Test=0;                           /*                               */
        print 'The Best Subset of Predictors is ' Backward;
    End;                                  /*                               */
    Free Lm_Val Cin Cin1 Notin;           /*                               */
   End;                                   /*                               */

FINISH STEPWISE;
/*-------------------- End of Automatic Search Module ---------------------------*/

  /*------------- ROUTINE TO BACKWARDS-ELIMINATE FOR STEPWISE -------------*/
START BACKSTEP;
   FREE Lm_VAL;
   X_TEMP=X[,NINDX];      /* DATA MATRIX W. COL. ENTERED FROM FORWARD STEP */
   LmName={Given Lm_Val Ind};             /*                               */
   DO J=2 TO NCOL(NINDX);                 /*                               */
        IM=Repeat(0,Ncol(NINDX),1);       /*                               */
        Im[j,]=^Im[j,];                   /*                               */
        Indx_b=Loc(^im);                  /* COLUMNS ALREADY IN THE MODEL  */
        Nindx_b=loc(im);                  /* COLUMNS NOT IN THE MODEL      */
                                          /*                               */
        CO_IN=J(N,1)||X_TEMP[,Indx_b];    /*                               */
                                          /*                               */
        XX1=CO_IN;                        /*                               */
        BB1=INV(XX1`*XX1)*XX1`*Y;         /*                               */
        LEM_XX=DET(YPY-(BB1`*XX1`*Y));    /* Wilks' Lam. for X's already in*/
                                          /*                               */
        X1=CO_IN||X_TEMP[,NIndx_b];       /*                               */
        B=INV(X1`*X1)*X1`*Y;              /*                               */
        LEM_TOT=DET(YPY-(B`*X1`*Y));      /* Wilk's Lambda for all X's     */
                                          /*                               */
        Lm_VAL=Lm_VAL//((LEM_TOT/LEM_XX));/* Values of Partial-Lambda      */
        FREE X1;                          /*                               */
     Cin=Cin//Nindx[,indx_b];             /* Columns already in the model  */
     Notin=notin//Nindx[,nindx_b];        /* Columns not in the model yet  */
   END;                                   /*                               */
    Cin=Num(rowcatc(char(Cin)));          /*                               */
    Xs=Cin||Lm_Val||notin;                /*                               */
    Xs_old=Xs;                            /*                               */
    Xs[(rank(Xs[,2]))`,]=Xs_Old;          /* Ordering Lambda values (A-Z)  */
    Lm_Out=Xs[Nrow(indx_b),2];            /* Max values of Wilks' lambda   */
    print ,'Min acceptable Lambda to remove' Lm_rmv;
    print ,"Lambda to remove";            /*                               */
    print  Xs[Colname=LmName];            /*                               */
    IF Lm_Out>Lm_RMV THEN do;             /*                               */
       If Nrow(indx_b)=1 then do;         /*                               */
          aa=char(Xs[1,1]);               /*                               */
          ab=length(aa);                  /*                               */
          Do i7=nrow(Notin)-1 to 0 by -1; /*                               */
          ac=ac||Substr(aa,(ab-i7),1);    /*                               */
          End;                            /*                               */
          Nindx=Num(ac);                  /* THE MIN. ACCEPTABLE Lm TO RMV.*/
       End;                               /*                               */
                                          /*                               */
       If Nrow(indx_b)=k-1 then test=0;   /*                               */
                                          /*                               */
       If Nrow(indx_b)>1 then do;         /*                               */
         Nindx=Xs[1:(Nrow(indx_b)-1),3];  /* THE MIN. ACCEPTABLE Lm TO RMV.*/
         sug=Xs[Nrow(indx_b),];           /*                               */
         print sug '    To be removed';   /*                               */
       End;                               /*                               */
    End;                                  /*                               */
    Else print 'Nothing to be removed';   /*                               */
    print '----------------------------------------------------------------';
    Free Cin Notin;                       /*                               */
FINISH BACKSTEP;                          /*-------------------------------*/
/*-------------------- End of Backstep Module -----------------------------*/
/*---------------------SEARCH ALL POSSIBLE MODELS--------------------------*/
START ALL;
   print /'All Possible Selection Methods',
   '--------------------------------------------------------------------';
  /*------USE METHOD OF SCHATZOFF ET AL. FOR SEARCH TECHNIQUE--------------*/
                                        /*----- Start of the module ---- */
  LIMIT=2##K-1;                         /* NUMBER OF MODELS TO EXAMINE   */
                                        /*                               */
 C=CSAVE; IN=REPEAT(0,K,1);             /* START WITH NO VAR. IN MODEL   */
                                        /*                               */
      DO kk=1 TO LIMIT;                 /*                               */
        RUN ZTRAIL;                     /* FIND WHICH ONE TO SWEEP       */
        RUN SWP;                        /* SWEEP IT IN                   */
   BB=BB//(VAR_IN||MSE||RSQ||AdjRsq||AIC/*                               */
        ||AICp||HQp||HBICp||BICp        /*                               */
        ||Cp||UpLm||L);                 /*                               */
        END;                            /*                               */
        ALL_P=BB;                       /* Sorting the output matrix     */
        BB[(RANK(BB[,1]))`,]=ALL_P;     /* to the variable names         */
                                        /*                               */
                                        /*                               */
                                        /*-------------- end ------------*/
        Counter=0;                      /*                               */
        Do jj=1 to nrow(bb);            /*                               */
         If (bb[jj,2]<=bb[nrow(bb),2]) then do;
         Counter=Counter+1;             /*                               */
         b_mse=b_mse//bb[jj,1:2];       /*                               */
         end;                           /*(finding the |MSEp|<|MSEk|     */
        End;                            /* & indv < total ind. variables)*/
        If Counter=0 then b_mse=All_idv;/*                               */
        Else do;                        /*                               */
          ind=b_mse[>:<,2];             /* Index's location of MSEp' min */
          b_mse=b_mse[ind,1];           /* Best subset according to MSEp */
        End;                            /*                               */
        Counter=0;                      /*                               */
                                        /*                               */
        Do jj=1 to nrow(bb);            /*                               */
         If (bb[jj,10]<=bb[jj,11]) & (bb[jj,1]<all_idv) then do;
         Counter=Counter+1;             /*                               */
         cp2=cp2//(Counter||bb[jj,1]);  /*                               */
         end;                           /*(finding the |Cp|<= UpperLimit */
        End;                            /* & indv < total ind. variables)*/
        If Counter=0 then b_Cp=All_idv; /* Set all ind. var. when Cp>UpLm*/
        Else b_Cp=cp2;                  /* Best subset according to Cp   */
        ind=bb[>:<,6];                  /* AICcp corrected form of AICp  */
        b_AICC=bb[ind,1];               /* Best subset according to AICcp*/
        ind=bb[>:<,7];                  /* Locate the index of min of HQp*/
        b_HQ=bb[ind,1];                 /* Best subset according to HQp  */
        ind=bb[>:<,5];                  /* Locate the index of min of AIC*/
        b_AIC=bb[ind,1];                /* Best subset according to AIC  */
        ind=bb[>:<,9];                  /* Index's location of BICp' min */
        b_BIC=bb[ind,1];                /* Best subset according to BICp */
        ind=bb[>:<,8];                  /* Index's location of HBICp' min*/
        b_HQIC=bb[ind,1];               /* Best subset according to HBICp*/
		ind=bb[<:>,4];                  /* Index's location of AjdRsq max*/
        b_AdjR=bb[ind,1];               /* Best subset according to AjdRsq*/
        BB=ROUND(BB,.001);              /*                               */
        print BB[colname=bnames ];      /*                               */
        F_out=Forward//Backward//Step//b_mse//b_AdjR//b_aic//b_aicc//b_hq
              //b_hQic//b_bic;
        F2_out={Forward, Backward, Stepwise,MSE, AdjRsq,AIC, AICc,HQ, HQIC,BIC};
        F3_out=b_cp;
        F4_out={Ser_No, Ind_Var};

  print /'-----------------------------------------------------------------',
        'Summary',
        '------------------------------------------------------------------',
        F_out[RowName=F2_out],
        F3_out[ColName=F4_out],
        '------------------------------------------------------------------';
FINISH ALL;
/*-------------------------- End of All Module ----------------------------*/

 /*-------------------------------------------------------------*
  : SUBROUTINE TO FIND NUMBER OF TRAILING ZEROS IN BINARY NUMBER:
  : ON ENTRY: kk IS THE NUMBER TO EXAMINE                       :
  : ON EXIT:  II HAS THE RESULT                                 :
  *-------------------------------------------------------------*/
START ZTRAIL;
    II=1; ZZ=kk;
    DO WHILE(MOD(ZZ,2)=0); II=II+1; ZZ=ZZ/2; END;
FINISH ZTRAIL;
 /*-------------------------------------------------------------*
  :              SUBROUTINE TO SWEEP IN A PIVOT                 :
  : ON ENTRY: II HAS THE POSITION(S) TO PIVOT                   :
  : ON EXIT:  IN, L, DFE, MSE, RSQ RECALCULATED                 :
  *-------------------------------------------------------------*/
START SWP;
     IF ABS(C[II,II])<1E-9 THEN DO; print , "FAILURE", C;STOP;END;
     C=SWEEP(C,II);
     IN[II,]=^IN[II,];
     L=SUM(IN); DFE=N-L;
     Xp=X[,loc(in)];                                    /* Xp matrix         */
     Hp=Xp*inv(Xp`*Xp)*Xp`;                             /* Hp matrix         */
     SSE=C[(K1:nrow(csave)),(K1:ncol(csave))];          /* Sum Sq. error     */
     SSR=Y`*(Hp-(J(n)/n))*Y;                            /* Sum Sq. reg.      */
     MSE=det(SSE/DFE);                                  /* Mean SS error     */
     RSQ=det(Inv(SSTO)*SSR);                            /* R squared         */
	 AdjRsq=det(i(q)-((n-1)/(DFE-1))*(Inv(SSTO)*SSE));	/* Adjusted R squared*/
	 Cp=(N-K)*INV(SSEk)*SSE+(2*L-N)*I(q);               /* Cp Criterion      */
     Cp=det((Cp+(n-2*L)*I(q))/(n-k));                   /* Det. of Cp        */
     UpLm=((n-L)/(n-k1))**q;                            /* Upper limit of Cp */
     Aic=n*log(det(SSE))+2*L*q+q*(q+1); 	            /* AICp Method       */
     AICp=log(det(SSE))+(n+L)*q/(n-L-q-1);              /* AICp Corrected    */
     BICp=n*log(det(SSE))+L*LOG(n);		                /* BICp Criterion    */
     HBICp=n*log(det(SSE))+2*q*L*LOG(LOG(n));	        /* HQICp Criterion   */
     HQp=log(det(SSE**2))+((2*LOG(LOG(N))*Q*L)/(N-L-Q-1));
     VAR_IN=Num(ROWCATC(CHAR(LOC(IN))));                /* Ind. Var. names   */
FINISH SWP;
/*-------------------------- End of SWP Module ----------------------------*/

START SEQ;
  RUN INITIAL;                                          /* INITIALIZATION          */
  RUN STEPWISE;                                         /* STEPWISE METHOD         */
  RUN ALL;                                              /* ALL POSSIBLE Regression */
FINISH SEQ;
 Run seq;

create data from BB[colname=bnames ];
append  from bb;
      /*--------------------------------*/
QUIT; /* THIS IS THE END OF THE PROGRAM */
      /*--------------------------------*/
