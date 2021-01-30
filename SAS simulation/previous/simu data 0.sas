/* simulation */


data x ;
	do i= 1 to 100 ;
		x=  abs(RAND('NORMAL',2,0.5)) ;
		output ;
	end ;
run ;

data y ;
	set x ;
	y= 10-1.5*x+ RAND('NORMAL',0,0.5) ;
run ;
