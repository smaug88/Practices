function [ salida ] = GradientePrewitt( img )
    [x,y] = size(img);
    img2 = zeros(x+2,y+2);
    img2(2:x+1,2:y+1) = img; 
    H = ([-1,0,1;
          -1,0,1;
          -1,0,1]./ 3);
    for i=1:x
        for j=1:y
            salida(i,j) = sum(sum(img2(i:1:i+2,j:1:j+2).*H));
        end
    end
    salida = uint8(salida.*255./max(max(salida)));
end

