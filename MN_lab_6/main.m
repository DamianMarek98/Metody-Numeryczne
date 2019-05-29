%zad3
% plot3(x,y,z,'o')
% grid on
% axis equal

%zad4
load trajektoria1

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
[wsp, xa] = aproksymacjaWiel(n,x,N) ;
[wsp, ya] = aproksymacjaWiel(n,y,N) ;
[wsp, za] = aproksymacjaWiel(n,z,N) ;
plot3(xa,ya,za,'lineWidth', 4)
grid on
axis equal
title('Position of drone based on aproximation of localization');
xlabel('x position');
ylabel('y position');
zlabel('z position');
saveas(gcf,"171952_Marek_zad4.png")




