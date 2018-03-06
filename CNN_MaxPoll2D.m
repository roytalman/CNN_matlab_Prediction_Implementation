function [ OutData , WidthOut , LengthOut ] = CNN_MaxPoll2D( DataIn  , Width , Length , Layers )

ImSize = Width*Length ; 
NumKernals = size(DataIn,2)/ ImSize ;
WidthOut = ceil(( Width - Layers.PoolSize(1) + 1 )./Layers.Stride(1)) ;
LengthOut = ceil(( Length - Layers.PoolSize(2) + 1 )./Layers.Stride(2)) ;
ImSizeNew = WidthOut*LengthOut ;

for m = 1:size(DataIn,1)
    for k = 1:NumKernals
        for j = 1:WidthOut
                for n = 1:LengthOut
                    Xind = Layers.Stride(1)*(j-1)+1 ; 
                    Yind = Layers.Stride(2)*(n-1)+1 ; 
                    Indexes = ImSize*(k-1) + ( ( ( 1:Layers.PoolSize(1) ) + (Xind-1) ) + ( ((0:Layers.PoolSize(2)-1) + Yind -1 )*Width)') ;
                    OutData( m, ImSizeNew*(k-1) + (n-1)*WidthOut+j ) = max( DataIn(m,Indexes(:)));
                end        
        end    
    end
end

end