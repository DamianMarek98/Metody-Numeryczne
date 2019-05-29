%zad5
clc
clear all
close all
load trajektoria2.mat

grid on;
axis equal;
subplot(2,1,1);
plot3(x,y,z,'o');
title('Position of drone based only on localization');
xlabel('x position');
ylabel('y position');
zlabel('z position');

subplot(2,1,2);
N = 50;

[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  % aproksymacja wsp. 'x'
[ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N);
[ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);

plot3(xa,ya,za,'lineWidth', 4)
title('Position of drone based on aproximation of localization');
xlabel('x position');
ylabel('y position');
zlabel('z position');
saveas(gcf,"171952_Marek_zad5.png")

%zad5b


err = [];
for i = 1:71
   [wsp, xa] = aproksymacjaWiel(n,x,i) ;
   [wsp, ya] = aproksymacjaWiel(n,y,i) ;
   [wsp, za] = aproksymacjaWiel(n,z,i) ;
   errx = sqrt((sum((x-xa).^2)))/length(x);
   erry = sqrt((sum((y-ya).^2)))/length(y);
   errz = sqrt((sum((z-za).^2)))/length(z);
   err(i) = errx +erry+ errz;
end
figure();
semilogy(err);
title('Blad aproksymacji dla N od1 do 71')
xlabel('Stopieñ funkcji wielomianowej')
ylabel('Wartosc bledu')
saveas(gcf,"171952_Marek_zad5b.png")