disp("zadInstrukcja")
Edges=[1,1,2,2,2,3,3,3,4,4,5,5,6,6,7
       4,6,3,4,5,5,6,7,5,6,4,6,4,7,6];
d=0.85;
N=7;
I=eye(N); %macierz jednostkowa N
B=full(sparse(Edges(2, :),Edges(1, :), 1)); %macierz s¹siedztwa B
A=diag(1./sum(B));
M=I-(d*B*A);
b=((1-d)/N)*ones(1,N);
r=(M/b);
r=r/norm(r);
bar(r);
