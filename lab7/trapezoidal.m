function [sum] = trapezoidal(x)
sum = 0;
start = 0;
ending = 5;
delta = (ending - start)/x;
inputs = [start:delta:ending];
for i=1:x-1
   sum=sum+((give_value(inputs(i))+give_value(inputs(i+1)))); 
end
sum = sum*delta/2;
end