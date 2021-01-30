%Macro RunTime(BGN_END);
%GLOBAL runbegin runend rundiff;
%If &BGN_END EQ %Then %Do; /* use BEGIN by default if no parameter value is
specified */
 %let BGN_END= BEGIN;
%End;
%If %Upcase(&BGN_END) = BEGIN %Then %Do; /*report BEGIN time */
 %Let runbegin = %Sysfunc(Datetime());
 %Let runend =;
 %Let msg = NOTE: The specified block of code BEGAN AT %Sysfunc(Sum(&runbegin),
Datetime16.).;
%End; %Else
%If %Upcase(&BGN_END) = END %Then %Do; /*report END time and calculate elapsed
time*/
 %Let runend = %Sysfunc(Datetime());
 %Let rundiff = %Sysfunc(Sum(&&runend, -&&runbegin));
 %Let msg = NOTE: The specified block of code ENDED AT %Sysfunc(Sum(&&runend),
Datetime16.).;
 %Let msg = &msg....Elapsed time of (hh:mm:ss): %Sysfunc(Sum(&rundiff), Time8.);
%End;
%Else %Do; /*To print error message if other parameter value than BEGIN and END is
used*/
 Options Nosource;
 %Let runbegin =%Sysfunc(Datetime()); 
2
 %Let runend =%Sysfunc(Datetime());
 %Put;%Put;
 %Put ERROR- NOTE: Wrong parameter. Please use RunTime(BEGIN) or RunTime(END).;
 %Put; %Put;
 Options Source;
 %goto SKIP; /*Skip to end of the macro*/
%End;
Options Nosource;
 %Put;%Put;
 %Put %Superq(msg); /*Print the running time message*/
 %Put;%Put;
Options Source;
%SKIP: /*end of macro*/
%Mend RunTime; 
