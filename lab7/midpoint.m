function [sum] = midpoint(x)
sum = 0;
start = 0;
ending = 5;
delta = (ending - start)/x;
inputs = [start:delta:ending];
for i=1:x-1
   sum = sum+ give_value((inputs(i)+inputs(i+1))/2)*delta; 
end
end