clc, clear all
% close all

load('MnistConv.mat')

k=1;

[w,~,Wd]=size(W1);
[N,~,~]=size(X);
postConv=N-w+1;
postPool=postConv/2;

x=X(:,:,k);
y1=Conv(x,W1);
y2=ReLU(y1);
y3=Pool(y2);
y4=reshape(y3,[],1);
v5=W5*y4;
y5=ReLU(v5);
v=Wo*y5;
y=Softmax(v);

figure;
display_network(x(:));
title('Input Image');

convFilters=zeros(w*w,Wd);
for i=1:Wd
    filter=W1(:,:,i);
    convFilters(:,i)=filter(:);
end

figure
display_network(convFilters);
title('Convolution Filters');

fList = zeros(postConv*postConv,Wd);
for i=1:Wd
    feature=y1(:,:,i);
    fList(:,i)=feature(:);
end

figure
display_network(fList);
title('Features [Convolution]')

fList=zeros(postConv*postConv,Wd);
for i=1:Wd
    feature=y2(:,:,i);
    fList(:,i)=feature(:);
end

figure
display_network(fList);
title('Features [Convolution + ReLU]')

fList=zeros(postPool*postPool,Wd);
for i=1:Wd
    feature=y3(:,:,i);
    fList(:,i)=feature(:);
end

figure
display_network(fList);
title('Features [Convolution + ReLU + MeanPool]')