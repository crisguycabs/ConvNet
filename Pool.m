function y=Pool(x)

[xrow,xcol,numFilters]=size(x);
y=zeros(xrow/2,xcol/2,numFilters);

% Pool Mean
filter=ones(2,2)/(2*2);
for k=1:numFilters
    image=conv2(x(:,:,k),filter,'valid');
    y(:,:,k)=image(1:2:end,1:2:end);
end

end