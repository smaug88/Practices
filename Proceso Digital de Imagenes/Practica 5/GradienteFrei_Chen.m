function [ salida ] = GradienteFrei_Chen( img )
    [x,y] = size(img);
    img2 = zeros(x+2,y+2);
    img2(2:x+1,2:y+1) = img; 
    raiz2=sqrt(2);
    H = ([	  1,0,    -1;
          raiz2,0,-raiz2;
              1,0,    -1]./(2+raiz2));
    for i=1:x
        for j=1:y
            salida(i,j) = sum(sum(img2(i:1:i+2,j:1:j+2).*H));
        end
    end
    salida = uint8(salida.*255./max(max(salida)));
end

