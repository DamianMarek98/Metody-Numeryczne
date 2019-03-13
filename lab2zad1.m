disp("zadInstrukcja")
clear all
v = [1,1,2,2,2,3,3,3,4,4,5,5,6,6,7;
     4,6,3,4,5,5,6,7,5,6,4,6,4,7,6];
d=0.85;
N=7;
I=speye(N);
B = sparse(v(2,:),v(1,:),1);
A = sparse(diag(1./sum(B)));
M = I-d*B*A;
b(1:N,1)=(1-d)/N;

r=M\b;
bar(r);
