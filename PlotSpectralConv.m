clc, clear all, close all

load('spectralConv.mat')

k=100;

x=Xtrain(:,k);
y1=ConvSpectral(x,W1);
y2=ReLU(y1);
y3=PoolSpectral(y2);
y4=reshape(y3,[],1);
v5=W5*y4;
y5=ReLU(v5);
v=Wo*y5;
y=Softmax(v);

[w,Wd]=size(W1);
m=floor(sqrt(Wd+1));
n=ceil(sqrt(Wd-1));
if((m*n)<Wd)
    m=ceil(sqrt(Wd));
    n=m;
end

figure
plot(x)
grid on
xlim([1 length(x)])
title('Spectral Signature')

figure
for i=1:Wd
    subplot(m,n,i)
    plot(W1(:,i),'.-')
    xlim([1 w])
    grid on
end
suptitle('1D Convolutional Filters')

figure
for i=1:Wd
    subplot(m,n,i)
    plot(y1(:,i))
    xlim([1 size(y1,1)])
    grid on
end
suptitle('Features (Convolution)')

figure
for i=1:Wd
    subplot(m,n,i)
    plot(y2(:,i))
    xlim([1 size(y2,1)])
    grid on
end
suptitle('Features (Convolution + ReLU)')

figure
for i=1:Wd
    subplot(m,n,i)
    plot(y3(:,i))
    xlim([1 size(y3,1)])
    grid on
end
suptitle('Features (Convolution + ReLU + MeanPool)')