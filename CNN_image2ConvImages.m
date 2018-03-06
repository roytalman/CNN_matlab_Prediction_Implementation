function [ Layer_Out , Width , Length ] = CNN_image2ConvImages(dataTest,Layer)
% implamentation of first convolution layer

% input:  dataTest  - image input with the size of m*n*i*j were m is the
%                     width, n is length , i is 1 or 3 (gray scale or RGB) and j is the number of images
%         Layer     - layer wightes from treaning
% output: Layer_Out - Next layer data
%         Width     - Width of image out
%         Length    - Length of image out

Width =  size(dataTest,1) - Layer.FilterSize(1) + 1 + 2*Layer.Padding(1) ;
Length =   size(dataTest,2) - Layer.FilterSize(2) + 1  + 2*Layer.Padding(2) ;

% Zero padd original image
dataTest_ZeroPadd = zeros( size(dataTest,1)+2*Layer.Padding(1) , size(dataTest,2)+2*Layer.Padding(2) , size(dataTest,3) , size(dataTest,4) );
for k = 1:size(dataTest,4)
    dataTest_ZeroPadd( Layer.Padding(1)+1:end-Layer.Padding(1) , Layer.Padding(2)+1:end-Layer.Padding(2),:,:) =  dataTest ; 
end
dataTest = dataTest_ZeroPadd; 
 
% calculated convolution
for j = 1:size(dataTest,4) % iterative loop for all images)
    for k = 1:size(Layer.Weights,4) % iterative loop for all convolutional keranals
        for m = 1:Width % iterative loop for all images)
            for n = 1:Length % iterative loop for all images)
                Data_mn = dataTest( (0 : Layer.FilterSize(1)-1) + m , (0 : Layer.FilterSize(2)-1 ) + n ,: , j ); % image data
                Weights = Layer.Weights(:,:,:,k) ; % wightes
                Layer_Out( j, Width*Length*(k-1) + (n-1)*Width + m ) = (sum( Data_mn(:) .* Weights(:) ) + Layer.Bias(:,:,k)) ; 
            end
        end
    end
end

end