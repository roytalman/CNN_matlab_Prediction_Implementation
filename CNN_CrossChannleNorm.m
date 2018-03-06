function [ DataOut ] = CNN_CrossChannleNorm(Layer_3_Out , CrossChannleNormSize , Width , Length )

Alpha = 0.0001 ;
Beta = 0.75 ;
K = 2 ;

Imagesize = Width * Length ;
CrossChannle_Ind = (1:CrossChannleNormSize) - ceil(CrossChannleNormSize/2) ; 
for Pic = 1:size(Layer_3_Out,1)
    for k = 1:size(Layer_3_Out,2)   
            Indexes =  mod( k + Imagesize*CrossChannle_Ind ,size(Layer_3_Out,2) ) ; 
            Indexes(Indexes == 0) = size(Layer_3_Out,2) ;
            ss = sum( Layer_3_Out(Pic , Indexes ).^2 ) ; 
            DataOut(Pic,k) = Layer_3_Out(Pic,k)/(K + Alpha*ss/CrossChannleNormSize)^Beta ;
    end
end
