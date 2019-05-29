function [ x_aprox ] = aprox_tryg( N, n,x  )

n = n*pi/max(n);
S = zeros(N,N);

% generacja macierzy S
%...
%...
for i = 1:N
    for j = 1:N
        for k = 1:length(x)
            S(i,j)=S(i,j)+cos(i*n(k))*cos(j*n(k));
        end
    end
end


t = zeros(N,1);
for k = 1 : N
        for i = 1:length(x)
            t(k,1) = t(k,1) + x(i) * cos((k-1) * n(i) );
        end   
end


% Rozwi�zanie uk�adu r�wna� Sc = t
%...
%...
c=S\t;

c1 = [];
for i = 1: N
    c1(i,:) = cos((i-1) * n) ;
end

x_aprox = c1' * c;

end

