function lab2zad2()
x=0;
y=0;
r=0;
area=0;
areaList=0;
drawCounter=0;
drawCounterList=0;
bool=0;

function plot_circ(X, Y, R)
theta = linspace(0,2*pi);
xc = R*cos(theta) + X;
yc = R*sin(theta) + Y;
plot(xc,yc);
hold on
end

function colision(x1,y1,r1,x2,y2,r2)
    bool=sqrt((x2-x1)^2 + (y2-y1)^2) < (r1+r2);
end
%limits        
a=100;
r_max=a/2;
n_max=50;
var=1;
while var<n_max+1
  randInt=randi([1,r_max],1);
  xa=randi([0,a],1);
  ya=randi([0,a],1);
  drawCounter=drawCounter+1;
  if(xa+randInt<a && ya+randInt<a && xa-randInt>0 && ya-randInt>0) %check if circle fit in range (0,0 to a,a)
      iterator=1;
      for k = x %check if not there is no collision with other circle 
          colision(xa,ya,randInt,k,y(iterator),r(iterator)); 
          if(bool==1)
              break
          end
          iterator=iterator+1;
      end
      if bool==0 %add circle data to vectors
      x(var)=xa;
      y(var)=ya;
      r(var)=randInt;
      area=area+(pi*(randInt).^2);
      areaList(var)=area;
      plot_circ(xa,ya,randInt);
      fprintf(1, ' %s%5d%s%.3g\r ', 'n =',  var, ' S = ', area)
      var=var+1;
      drawCounterList(var)=drawCounter;
      drawCounter=0;
      end
  end
end
figure('Name','Wykres','NumberTitle','off');
semilogx(areaList);
figure('Name','WykresLosowan','NumberTitle','off');
loglog(drawCounterList);
end