function [ salida ] = LoG( img )
    [x,y] = size(img);
    img2 = zeros(x+4,y+4);
    img2(3:x+2,3:y+2) = img;
    
    H =[0  0 -1  0  0;
         0 -1 -2 -1  0;
        -1 -2 16 -2 -1;
         0 -1 -2 -1  0;
         0  0 -1  0  0]; 
     
    for i=3:x
        for j=3:y
            salida(i-2,j-2) = sum(sum(img2(i-2:1:i+2,j-2:1:j+2).*H));
        end
    end
    salida = uint8(salida.*255./max(max(salida)));
end

