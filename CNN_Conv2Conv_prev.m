function [ DataOut , WidthOut , LengthOut  ] = CNN_Conv2Conv( DataIn , Layers , Width , Length ) 

ImSize = Width*Length ; 
NumKernals = size(DataIn,2)/ ImSize ;
WidthOut = Width - Layers.FilterSize(1) + 1;
LengthOut = Length - Layers.FilterSize(2) + 1;
ImSizeNew = WidthOut*LengthOut ;
for m = 1:size(DataIn,1)
    for k = 1:NumKernals
        for j = 1:Width-Layers.FilterSize(1) +1
                for n = 1:Length-Layers.FilterSize(2)+1
                    Indexes = ( ( ( 1:Layers.FilterSize(1) ) + (j-1) ) + ( ((0:Layers.FilterSize(2)-1) + n -1 )*Width)')';
                    for i = 1:size( Layers.Weights,4)
                        Indexes2(:,:,i) = Indexes+ ImSize*(i-1);
                    end
                    [999 ImSize size(Indexes2)]
                    %sum( DataIn(m,Indexes2(:)))
                    %[k size(Layers.Weights)]
                    Weights = Layers.Weights(:,:,:,k) ;
                    DataOut( m, ImSizeNew*(k-1) + (n-1)*WidthOut+j ) = sum( DataIn(m,Indexes2(:)) .* Weights(:)' ) + Layers.Bias(:,:,k) ;
                end        
        end    
    end
end


end