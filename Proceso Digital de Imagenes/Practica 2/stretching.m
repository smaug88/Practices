function [ salida ] = stretching( img, umbral1, umbral2, alpha, beta, gamma)
    L = max(max(img));
    [ x,y ] = size(img);
    va = 0;
    vb = 0;
    for i=1:x
        for j=1:y
            if img(i,j)<umbral1
                salida(i,j) = alpha*img(i,j);
            else
                if img(i,j)<umbral2
                    if img(i,j)==umbral1
                        salida(i,j) = alpha*img(i,j);
                        va = alpha*img(i,j);
                    else
                        salida(i,j) = beta*(img(i,j)-umbral1)+va;
                    end
                else
                    if img(i,j)==umbral2
                        salida(i,j) = beta*(img(i,j)-umbral1)+va;
                        vb = beta*(img(i,j)-umbral1)+va;
                    else
                        salida(i,j) = gamma*(img(i,j)-umbral2)+vb;
                    end
                end
            end
        end
    end
end

