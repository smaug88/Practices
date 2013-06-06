function [ salida ] = FiltroMediaPonderada( img, pesos )
    [x, y] = size(img);
    for i=1:x
        for j=1:y
            if(i>1)
                if(j>1)
                    media = double(pesos(1)*img(i-1,j-1));
                else
                    media = 0;
                end
                media = media + double(pesos(2)*img(i-1,j)); 
                if(j<y)
                    media = media + double(pesos(3)*img(i-1,j+1));
                end
            else
                media = 0;
            end
            if(j>1)
                media = media + double(pesos(4)*img(i,j-1));
            end
            media = media + double(pesos(5)*img(i,j));
            if(j<y)
                media = media + double(pesos(6)*img(i,j+1));
            end
            if(i<x)
                if(j>1)
                    media = media + double(pesos(7)*img(i+1,j-1));
                end
                media = media + double(pesos(8)*img(i+1,j));
                if(j<y)
                    media = media + double(pesos(9)*img(i+1,j+1));
                end
            end
            aux(i,j) = media/9;
        end
    end
    salida = im2uint8(mat2gray(aux));
end

