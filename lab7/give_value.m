function [value] = give_value(x)
u=10;
o=3;

n = exp(1).^-((x-u).^2/(2*o.^2));
d = o*sqrt(2*pi);
value = n/d;
end