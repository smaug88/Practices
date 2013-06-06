function [ salida ] = GradienteKirsh( img )
    N=8;
    k = zeros (3,3,N);
    k(:,:,1) = [-3,-3,5;
                -3, 0,5;
                -3,-3,5];
    k(:,:,2) = [-3, 5, 5;
                -3, 0, 5;
                -3,-3,-3];
    for i=3:1:N
        k(:,:,i)=rot90(k(:,:,i-2));
    end
    
    G = zeros(size(img,1),size(img,2),N);
    [x,y] = size(img);
    img2 = zeros(x+4,y+4);
    img2(3:x+2,3:y+2) = img;
    
    for i=1:1:N
        for j=3:x
            for l=3:y
                salida(j,l,i) = sum(sum(img2(j:1:j+2,l:1:l+2).*k(:,:,i)));
            end
        end
    end
    
    % Se selecciona el maximo de cada filtro
    salida = max (abs(salida),[],3);
    salida = uint8(salida.*255./max(max(salida)));
end

