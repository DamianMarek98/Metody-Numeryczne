%zad6
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

[ xa ] = aprox_tryg(N,n,x);  % aproksymacja wsp. 'x'
[ ya ] = aprox_tryg(N,n,y);
[ za ] = aprox_tryg(N,n,z);

plot3(xa,ya,za,'lineWidth',4);
title('Position of drone based on aproximation of localization');
xlabel('x position');
ylabel('y position');
zlabel('z position');
saveas(gcf,"171952_Marek_zad6.png")


%zad7


err = [];
for i = 1:71
   [ xa ] = aprox_tryg(i,n,x);  % aproksymacja wsp. 'x'
   [ ya ] = aprox_tryg(i,n,y);
   [ za ] = aprox_tryg(i,n,z);
   errx = sqrt((sum((x-xa').^2)))/length(x);
   erry = sqrt((sum((y-ya').^2)))/length(y);
   errz = sqrt((sum((z-za').^2)))/length(z);
   err(i) = errx +erry+ errz;
end
figure();
semilogy(err);
title('Blad aproksymacji dla N od1 do 71')
xlabel('Stopieñ funkcji wielomianowej')
ylabel('Wartosc bledu')
saveas(gcf,"171952_Marek_zad7.png")