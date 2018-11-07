function y = ConvSpectral(x,W)

% Calculates the 1D convolution
%
% Crisostomo Barajas-Solano
% Noviembre 2018

[w,numFilters]=size(W);
[N,~]=size(x);

ylargo=N-w+1;
y=zeros(ylargo,numFilters);

for k=1:numFilters
    filter=W(:,k);
    filter=rot90(squeeze(filter),2);
    y(:,k)=conv(x,filter,'valid');
end

end

