clc
clear all


%------------------------------------------
load dane_jezioro   % dane XX, YY, FF sa potrzebne jedynie do wizualizacji problemu. 
surf(XX,YY,FF)
shading interp
axis equal

N=1e5;
N1=0;
V=100*100*50;
xvect = 100.*rand(1,N);
yvect = 100.*rand(1,N);
zvect = -50.*rand(1,N);

for i=1:N
    if glebokosc(xvect(i),yvect(i))<zvect(i)
        N1=N1+1;
    end
end
wyniki = fopen('wyniki_zad2.txt','w');
volume = V*N1/N;
fprintf(wyniki,'Glebokosc zbiornika wynosi: %d m^3', volume);
fclose(wyniki);