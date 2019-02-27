%function []=zbiorMendelBrota()
    n=1000;
    [X,Y]=meshgrid(-2:0.003:1,-1.5:0.003:1.5);
    Y=Y.*(1i);
    C=X+Y;
    Z=zeros(size(C));
    K=zeros(size(C));
    for k=1:100
           Z=(Z.^2)+C;
           id=(abs(Z)>2) & (K==0);
           K((abs(Z)>2) & (K==0))=100-k;
    end
    
    imagesc(K);
%endfunction