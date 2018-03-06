function [ DataOut , WidthOut , LengthOut  ] = CNN_Conv2ConvL( DataIn , Layers , Width , Length ) 

ImSize = Width*Length ; 
NumKernels = size( Layers.Weights,4);
WidthOut = Width - size( Layers.Weights,1) + 1;
LengthOut = Length - size( Layers.Weights,2) + 1;
ImSizeNew = WidthOut*LengthOut ;
for m = 1:size(DataIn,1)
    for k = 1:NumKernels
        for j = 1:Width-size( Layers.Weights,1) +1
                for n = 1:Length-size( Layers.Weights,2)+1
                   
                    isum = 0;
                    for zi=1:size( Layers.Weights,3)
                        for yi=0:size( Layers.Weights,2)-1                            
                            for xi=1:size( Layers.Weights,1)
                                index = ( ( xi + (j-1) ) + ( (yi + n -1 )*Width) ) + ImSize*(zi-1);
                                isum = isum +  DataIn(m, index) * Layers.Weights(xi,yi+1,zi,k);
                            end
                        end
                    end
                    isum = isum + Layers.Bias(1,1,k);
                    DataOut( m, ImSizeNew*(k-1) + (n-1)*WidthOut+j ) = isum;
                end        
        end    
    end
end


end
