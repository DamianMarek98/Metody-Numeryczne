function [sum] = monte_carlo(x)
sum = 0;
start = 0;
ending = 5;
min = give_value(start);
max = give_value(ending);
h = max - min;
width = ending - start;
N1 = 0;
S = width*h;
xvect = (width)*rand(1,x)+start;
yvect = (h)*rand(1,x)+min;

for i = 1:x
    if give_value(xvect(i))>yvect(i)
        N1 = N1 + 1;
    end
end

sum = S*N1/x;

end