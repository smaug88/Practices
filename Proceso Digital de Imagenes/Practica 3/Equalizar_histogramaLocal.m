function [ salida ] = Equalizar_histogramaLocal( img , x0, x1, y0, y1)
% Pasos:
%   1: Obtener el histograma
    valores = zeros(256, 1);
    for i=x0:x1
        for j=y0:y1
            valores(img(i,j)+1) = valores(img(i,j)+1)+1;
        end
    end
%   2: Normalizar el histograma
    total = sum(valores);
    %salida = zeros(size(img));
%   3: Realizar el sumatorio
    salida = img;
    for i=x0:x1
        for j=y0:y1
            aux = 0;
            for k=1:img(i,j)
                aux = aux+valores(k);
            end
%   4: Asignar nuevos valores
            salida(i,j) = im2uint8(aux/total);
        end
    end
end

