function [ salida ] = FiltroLaplaciano( img, mascara)
    [x, y] = size(img);
    for i=1:x
        for j=1:y
            if(1<i && i<x)
                if(1<j && j<y)
                    gradiente = img(i+1, j)*mascara(3,2) + img(i-1, j)*mascara(1,2) + img(i, j+1)*mascara(2,3) + img(i, j-1)*mascara(2,1) + img(i,j)*mascara(2,2);
                    gradiente = gradiente + img(i-1, j-1)*mascara(1,1) + img(i-1, j+1)*mascara(1,3) + img(i+1, j-1)*mascara(3,1) + img(i+1, j+1)*mascara(3,3);
                else
                    if(j == 1)
                        gradiente = img(i+1, j)*mascara(3,2) + img(i-1, j)*mascara(1,2) + img(i, j+1)*mascara(2,3) + img(i,j)*mascara(2,2);
                        gradiente = gradiente + img(i-1, j+1)*mascara(1,3) + img(i+1, j+1)*mascara(3,3);
                    else
                        gradiente = img(i+1, j)*mascara(3,2) + img(i-1, j)*mascara(1,2) + img(i, j-1)*mascara(2,1) + img(i,j)*mascara(2,2);
                        gradiente = gradiente + img(i-1, j-1)*mascara(1,1) + img(i+1, j-1)*mascara(3,1);
                    end
                end
            else
                if(i == 1)
                   if(1<j && j<y)
                        gradiente = img(i+1, j)*mascara(3,2) + img(i, j+1)*mascara(2,3) + img(i, j-1)*mascara(2,1) + img(i,j)*mascara(2,2);
                        gradiente = gradiente + img(i+1, j-1)*mascara(3,1) + img(i+1, j+1)*mascara(3,3);
                   else
                        if(j == 1)
                            gradiente = img(i+1, j)*mascara(3,2) + img(i, j+1)*mascara(2,3) + img(i,j)*mascara(2,2);
                            gradiente = gradiente + img(i+1, j+1)*mascara(3,3);
                        else
                            gradiente = img(i+1, j)*mascara(3,2) + img(i, j-1)*mascara(2,1) + img(i,j)*mascara(2,2);
                            gradiente = gradiente + img(i+1, j-1)*mascara(3,1);
                        end
                   end 
                else
                   if(1<j && j<y)
                        gradiente = img(i-1, j)*mascara(1,2) + img(i, j+1)*mascara(2,3) + img(i, j-1)*mascara(2,1) + img(i,j)*mascara(2,2);
                        gradiente = gradiente + img(i-1, j-1)*mascara(1,1) + img(i-1, j+1)*mascara(1,3);
                   else
                        if(j == 1)
                            gradiente = img(i-1, j)*mascara(1,2) + img(i, j+1)*mascara(2,3) + img(i,j)*mascara(2,2);
                            gradiente = gradiente + img(i-1, j+1)*mascara(1,3);
                        else
                            gradiente = img(i-1, j)*mascara(1,2) + img(i, j-1)*mascara(2,1) + img(i,j)*mascara(2,2);
                            gradiente = gradiente + img(i-1, j-1)*mascara(1,1);
                        end
                   end  
                end
            end
            if (mascara(2,2)<0)
                salida(i,j) = img(i,j) - gradiente;
            else
                salida(i,j) = img(i,j) + gradiente;
            end
        end
    end
end

