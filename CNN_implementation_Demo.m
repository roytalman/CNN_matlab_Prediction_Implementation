% Demo of CNN coder implementation with regular for loops 
% Roy Talman
% roytalman@gmail.com
% Copyright (c) Roy Talman 2018

% design Net 
DimSize = 3 ; % RGB or grayscale  
NumConvKernals = 8 ; 
ImageSize = 12 ;
layers = [ ...
     imageInputLayer([ImageSize ImageSize DimSize], 'Normalization', 'none')
    convolution2dLayer([2 3],NumConvKernals,'Padding',[3 1])
    reluLayer
    maxPooling2dLayer([2 2],'Stride',[3 2])
     convolution2dLayer([2 2],12)
    crossChannelNormalizationLayer(3);
    dropoutLayer(0.4)
    fullyConnectedLayer(15)
    reluLayer
    fullyConnectedLayer(2)
    regressionLayer
    ];

% create random data and labels
iNum = 100;
data = zeros(ImageSize,ImageSize,DimSize,iNum);
dataResp = [ ([100:-1:1])'  ([1:100])'] ; % Labels for exmple
for i=1:iNum%
    data(4:6,4:6,:,i) = 0.3*i*ones(3,3,DimSize)+0.3*rand(3,3,DimSize); % data with non-linear connection to labels
end
 
% CNN training used regalar CNN matlab tool 
opts = trainingOptions('sgdm','MaxEpochs',1675,'MiniBatchSize', 35,'InitialLearnRate',0.00001);
net  = trainNetwork( data , dataResp , layers ,opts);
 
% take some sampels to test:
dataTest = data(:,:,:,[1 3 6]);

% matlab prediction
PreMatlab = net.predict(dataTest);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% My code prediction (all implementation code is inside this function):
 Activations_Out = CNN_fullNet(net,dataTest ) ; 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test fullyConnectedLayer(1), which is in this network 
% is exactly the output layer
Diff  = PreMatlab - Activations_Out{end}

% MSE error for inner layer of the data: 
sum(sum(( Activations_Out{3} -  activations( net, dataTest, 3)).^2))
