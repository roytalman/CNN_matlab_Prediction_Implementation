function [ Layer_OutR ] = CNN_RELU(dataTest)
Layer_OutR = max(dataTest,0);
end