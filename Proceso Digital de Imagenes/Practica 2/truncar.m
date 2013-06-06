function [ salida ] = truncar( img, umbral1, umbral2, beta )
    L = max(max(img));
    [ x,y ] = size(img);
    vb = 0;
    for i=1:x
        for j=1:y
            if img(i,j)<=umbral1
                salida(i,j) = 0;
            else
                if img(i,j)<umbral2
                    salida(i,j) = beta*(img(i,j)-umbral1);
                else
                    if img(i,j)==umbral2
                        salida(i,j) = beta*(img(i,j)-umbral1);
                        vb = beta*(img(i,j)-umbral1);
                    else
                        salida(i,j) = vb;
                    end
                end
            end
        end
    end
end

