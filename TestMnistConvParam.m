clc, clear all, close all

Wd=20;
w=7;
N=28;
clases=10;

postConv=N-w+1;
postPool=postConv/2;
nW5=postPool*postPool;
nMid=postPool*postPool*Wd;

Images=loadMNISTImages('MNIST/t10k-images.idx3-ubyte');
Images=reshape(Images,N,N,[]);

Labels=ladoMNISTLabels('MNIST/t10k-labels.idx1-ubyte');
Labels(Labels==0)=10;

rng(1);

W1=1e-2*randn([w w Wd]);
W5=(2*rand(nW5,nMid)-1)*sqrt(6)/sqrt(360+nMid);
Wo=(2*rand(clases,nW5)-1)*sqrt(6)/sqrt(clases+nW5);
% W5=(2*rand(100,2000)-1);
% Wo=(2*rand(10,100)-1);

X=Images(:,:,1:8000);
D=Labels(1:8000);

for epoch=1:10
    disp(['epoch: ' num2str(epoch)])
    [W1,W5,Wo]=MnistConvParam(W1,W5,Wo,X,D);
    
    Xtest=Images(:,:,8001:10000);
    Dtest=Labels(8001:10000);
    acc=0;
    N=length(Dtest);
    
    for k=1:N
        x=Xtest(:,:,k);
        y1=Conv(x,W1);
        y2=ReLU(y1);
        y3=Pool(y2);
        y4=reshape(y3,[],1);
        v5=W5*y4;
        y5=ReLU(v5);
        v=Wo*y5;
        y=Softmax(v);
        
        [~,i]=max(y);
        if i==Dtest(k)
            acc=acc+1;
        end
    end
    
    acc=acc/N;
    fprintf('Accuracy is %f\n',acc);
end

save('MnistConv.mat');

