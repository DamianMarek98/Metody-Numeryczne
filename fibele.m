function []=fibele(b)
    vecb=[1,1;1,0]
    vecf=[1:1]
    wynik=[((vecb)^b)*vecf]
    disp(wynik(1,2),'n=')
    disp(wynik(1,1),'n+1=')
endfunction
//fibele(x);
