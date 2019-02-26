function []=zbiorMandelbrota()
    n=1000
    [X,Y]=meshgrid(-2:0.001:-1,-1.5:0.01:1.5)//-2do1 i -1.5do1.5 o co cho?
    C=X+Y;
    //disp(C);
    Z=zeros(1000,1000);
    K=zeros(1000,1000);
    for k=1:100
        for i=1:1000
            for j=1:1000
                Z(i,j)=(Z(i,j)^2+C(i,j))
                if (abs(Z(i,j))>2) && (K(i,j)==0)
                    K(i,j)=100-k
                end
            end
        end
    end
    
    imagesc(K);
endfunction
