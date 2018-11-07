function y=PoolSpectral(x)

% Calculates the 1D pooling
%
% Crisostomo Barajas-Solano
% Noviembre 2018

[N,numFilters]=size(x);
y=zeros(N/2,numFilters);

% Pool Mean
filter=ones(1,2)/(2);
for k=1:numFilters
    signature=conv(x(:,k),filter,'valid');
    y(:,k)=signature(1:2:end);
end

end

