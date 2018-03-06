function [ Layer_Out ] = CNN_PrepareImage4Conv(dataTest_4D)
% implamentation of first convolution layer

% input:  dataTest  - image input with the size of m*n*i*j were m is the
%                     width, n is length , i is 1 or 3 (gray scale or RGB) and j is the number of images
%         Layer     - layer wightes from treaning
% output: Layer_Out - Next layer data
%         Width     - Width of image out
%         Length    - Length of image out


Layer_Out = reshape(dataTest_4D,[],size(dataTest_4D,4) )';

% 
% % calculated convolution
% for j = 1:size(dataTest,4) % iterative loop for all images)
%     for k = 1:size(Layer.Weights,4) % iterative loop for all convolutional keranals
%         for m = 1:Width % iterative loop for all images)
%             for n = 1:Length % iterative loop for all images)
%                 Data_mn = dataTest( (0 : Layer.FilterSize(1)-1) + m , (0 : Layer.FilterSize(2)-1 ) + n ,: , j ); % image data
%                 Weights = Layer.Weights(:,:,:,k) ; % wightes
%                 Layer_Out( j, Width*Length*(k-1) + (n-1)*Width + m ) = (sum( Data_mn(:) .* Weights(:) ) + Layer.Bias(:,:,k)) ; 
%             end
%         end
%     end
% end

end