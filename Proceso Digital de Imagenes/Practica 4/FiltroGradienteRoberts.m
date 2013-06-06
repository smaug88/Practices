function [ salida ] = FiltroGradienteRoberts( img )
    [x, y] = size(img);
    for i=1:x
        for j=1:y
            if(i<x)
                if(j<y)
                    salida(i,j) = abs(img(i,j)-img(i+1, j+1)) + abs(img(i+1, j)-img(i, j+1));
                else
                    salida(i,j) = abs(img(i,j)) + abs(img(i+1, j));
                end
            else
                if(j<y)
                    salida(i,j) = abs(img(i,j)) + abs(img(i, j+1));
                else
                    salida(i,j) = abs(img(i,j));
                end
            end
        end
    end
end

