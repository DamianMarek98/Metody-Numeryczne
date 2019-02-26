vecaq=[-2,-4]
vec=[0,0,0,0,0,0,0,0,0,0]
vec(1)=[vecaq(1)*vecaq(2)^0]
disp(vec(1));
for i=2:10
   vec(i)=[vec(1)*vecaq(2)^(i-1)];
   disp(vec(i));
end
