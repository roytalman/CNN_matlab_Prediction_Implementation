function [ matOut , matWidthN , matLengthN ] = CNN_ConvPadding1D(matIn, Layer, matWidth , matLength)
% implementation of zero pedding , for images represented as 1D vectors

paddingW =  Layer.PaddingSize(1) ;
paddingL =  Layer.PaddingSize(3) ;

matDepth = size(matIn,2)/(matWidth*matLength);
matWidthN  =  matWidth  + 2*paddingW;
matLengthN =  matLength + 2*paddingL;

matOut = zeros(size(matIn,1),matDepth*matWidthN*matLengthN);

for m = 1:size(matIn,1)
    for k = 1:matDepth
        for j = (1+paddingW) : (matWidthN-paddingW)
            for n = (1+paddingL): (matLengthN-paddingL)
                matOut(m, matWidthN*matLengthN*(k-1) + (n-1)*matWidthN + j ) = ...
                    matIn(m,matWidth*matLength*(k-1) + (n-1-paddingL)*matWidth +  (j-paddingW));
            end
        end
    end
end