
close all
clear all
x=0;
y=0;
r=0;
area=0;
areaList=0;
drawCounter=0;
drawCounterList=0;
bool=0;

%limits        
a=100;
r_max=a/2;
n_max=100;
var=1;
while var<n_max+1
  randI=rand(1)*r_max;
  xa=rand(1)*(a);
  ya=rand(1)*(a);
  drawCounter=drawCounter+1;
  if(xa+randI<a && ya+randI<a && xa-randI>0 && ya-randI>0) %check if circle fit in range (0,0 to a,a)
      iterator=1;
      for k = x %check if not there is no collision with other circle 
         
          bool=sqrt((k-xa)^2 + (y(iterator)-ya)^2) < (randI+r(iterator));
          if(bool==1)
              break
          end
          iterator=iterator+1;
      end
      if bool==0 %add circle data to vectors
      x(var)=xa;
      y(var)=ya;
      r(var)=randI;
      area=area+(pi*(randI).^2);
      areaList(var)=area;
      plot_circ(xa,ya,randI);
      fprintf(1, ' %s%5d%s%.3g\r ', 'n =',  var, ' S = ', area)
      drawCounterList(var)=drawCounter;
      drawCounter=0;
      var=var+1;
      end
  end
end


figure('Name','WykresPola','NumberTitle','off');
semilogx(1:n_max,areaList);
figure('Name','WykresLosowan','NumberTitle','off');
drawCounterListCumSum= cumsum(drawCounterList);
numbers=1:n_max;
avrage=cumsum(drawCounterList);

loglog(1:n_max,avrage./numbers);

function plot_circ(X, Y, R)
theta = linspace(0,2*pi);
xc = R*cos(theta) + X;
yc = R*sin(theta) + Y;
plot(xc,yc);
hold on
end

