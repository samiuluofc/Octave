clear
tic              %start time count

K0 = [0 0; 1 0]; %initial value

K1 = koch(K0);
K2 = koch(K1);
K3 = koch(K2);
K4 = koch(K3);
K5 = koch(K4);
K6 = koch(K5);
K7 = koch(K6);
K8 = koch(K7);
K9 = koch(K8);
K10 = koch(K9); 

toc             %Give Elapsed time

plot(K10(:,1),K10(:,2));
%print -dpng foo.png
