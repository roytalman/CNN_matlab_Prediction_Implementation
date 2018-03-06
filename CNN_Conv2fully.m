function [ Layer_4_OutR ] = CNN_Conv2fully(Layer_Data,Layer)

Layer_4_OutR = (Layer.Weights * Layer_Data' + Layer.Bias )';

end