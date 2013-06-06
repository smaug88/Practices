function [ salida ] = FiltroMediana( img )
    [x, y] = size(img);
    for i=1:x
        for j=1:y
            if(i>1)
                if(j>1)
                    valores(1) = double(img(i-1,j-1));
                    n = 2;
                else
                    n = 1;
                end
                valores(n) = double(img(i-1,j)); 
                n = n+1;
                if(j<y)
                    valores(n) = double(img(i-1,j+1));
                    n = n+1;
                end
            else
                n = 1;
            end
            if(j>1)
                valores(n) = double(img(i,j-1));
                n = n+1;
            end
            valores(n) = double(img(i,j));
            n = n+1;
            if(j<y)
                valores(n) = double(img(i,j+1));
                n = n+1;
            end
            if(i<x)
                if(j>1)
                    valores(n) = double(img(i+1,j-1));
                    n = n+1;
                end
                valores(n) = double(img(i+1,j));
                n = n+1;
                if(j<y)
                    valores(n) = double(img(i+1,j+1));
                    n = n+1;
                end
            end
            valores = sort(valores);
            aux(i,j) = valores(round(n/2));
            n = 0;
            clear valores;
        end
    end
    salida = im2uint8(mat2gray(aux));
end

