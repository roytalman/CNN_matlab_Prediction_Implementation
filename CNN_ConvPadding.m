function [ dataTest , Width , Length ] = CNN_ConvPadding(dataTest,Layer)
% implamentation of zero pedding , only for original image

 % Sawitching between matlab versions bug fixing:
if isfield(Layer,'Padding')==0
    PadddingName = 'Padding' ;
    SecDim = 2 ;
else
    PadddingName = 'PaddingSize' ;
    SecDim = 3 ;
end

Width =  size(dataTest,1) + 2*Layer.(PadddingName)(1) ;
Length =   size(dataTest,2) + 2*Layer.(PadddingName)(SecDim) ;

% Zero padd original image
dataTest_ZeroPadd = zeros( Width , Length , size(dataTest,3) , size(dataTest,4) );
for k = 1:size(dataTest,4)
    dataTest_ZeroPadd( Layer.(PadddingName)(1)+1:end-Layer.(PadddingName)(1) , Layer.(PadddingName)(SecDim)+1:end-Layer.(PadddingName)(SecDim),:,:) =  dataTest ; 
end
dataTest = dataTest_ZeroPadd ;

end