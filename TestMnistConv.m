Images=loadMNISTImages('MNIST/t10k-images.idx3-ubyte');
Images=reshape(Images,28,28,[]);

Labels=ladoMNISTLabels('MNIST/t10k-labels.idx1-ubyte');
Labels(Labels==0)=10;

% rng(1);

W1=1e-2*randn([9 9 20]);
W5=(2*rand(100,2000)-1)*sqrt(6)/sqrt(360+2000);
Wo=(2*rand(10,100)-1)*sqrt(6)/sqrt(10+100);
% W5=(2*rand(100,2000)-1);
% Wo=(2*rand(10,100)-1);

X=Images(:,:,1:8000);
D=Labels(1:8000);

for epoch=1:3
    disp(['epoch: ' num2str(epoch)])
    [W1,W5,Wo]=MnistConv(W1,W5,Wo,X,D);
    
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


