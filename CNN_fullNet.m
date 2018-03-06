function Activations_Out = CNN_fullNet(Net,dataTest ,LayerOut)
% impelment CNN net

% Input:  Net      - trained net
%         dataTest - image input with the size of m*n*i*j were m is the
%                    width, n is length , i is 1 or 3 (gray scale or RGB) and j is the number of images.
%         LayerOut - activetions layer out of not specified then calculate
%                    net output
% Output: Activations_Out - result of Net as cellarray, each layer output is
%                           predicted in one cell. 


if nargin < 3 
    LayerOut =  length(Net.Layers) ;
end
Layers = Net.Layers ;

for k = 2:LayerOut  % Run over all layers and calculate next wightes
    if k>2
       disp( ['Iteration ' Layers(k).Name])

    end
   
    if k == 2 % assume first layer is convolutional
        %[ Activations_Out{k} , Width , Length  ] = CNN_image2ConvImages( dataTest , Layers(k) ) ;
        size(dataTest)
        [ dataTest , Width , Length ] = CNN_ConvPadding(dataTest,Layers(k));


        dataTest= CNN_PrepareImage4Conv(dataTest);
        [ Activations_Out{k} , Width , Length  ] = CNN_Conv2ConvL( dataTest , Layers(k) , Width , Length );
        
        continue ; 
    end
    if strfind(Layers(k).Name,'relu')
        [ Activations_Out{k} ] = CNN_RELU( Activations_Out{k-1} );
         continue ; 
    end
    if strfind(Layers(k).Name,'conv')
        
        if Layers(k).Padding(1) > 0 || Layers(k).Padding(2) > 0
            [ Activations_Out{k} , Width , Length  ] = CNN_ConvPadding1D(Activations_Out{k-1} , Layers(k) , Width , Length);
        else
            Activations_Out{k} = Activations_Out{k-1};
        end
        
        [ Activations_Out{k} , Width , Length  ] = CNN_Conv2ConvL( Activations_Out{k} , Layers(k) , Width , Length ) ;
        continue ; 
    end
    if strfind(Layers(k).Name,'maxpool')
        [ Activations_Out{k} , Width , Length ] = CNN_MaxPoll2D( Activations_Out{k-1} , Width , Length , Layers(k) );
         continue ; 
    end
    if strfind(Layers(k).Name,'crossnorm')
        [  Activations_Out{k} ] = CNN_CrossChannleNorm( Activations_Out{k-1} , Layers(k).WindowChannelSize , Width , Length  ) ;
         continue ; 
    end
    if strfind(Layers(k).Name,'fc')
        [ Activations_Out{k} ] = CNN_Conv2fully( Activations_Out{k-1} , Layers(k)) ;
         continue ; 
    end
   if strfind(Layers(k).Name,'dropout')
        [ Activations_Out{k} ] = Activations_Out{k-1} ;
         continue ; 
   end
end


