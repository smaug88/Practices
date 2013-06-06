function [ salida ] = Equalizar_histograma( img )
% Pasos:
%   1: Obtener el histograma
    [ x, y] = size(img);
    valores = zeros(256, 1);
    for i=1:x
        for j=1:y
            valores(img(i,j)+1) = valores(img(i,j)+1)+1;
        end
    end
%   2: Normalizar el histograma
    total = sum(valores);
    %salida = zeros(size(img));
%   3: Realizar el sumatorio
    for i=1:x
        for j=1:y
            aux = 0;
            for k=1:img(i,j)
                aux = aux+valores(k);
            end
%   4: Asignar nuevos valores
            salida(i,j) = aux/total;
        end
    end
end

