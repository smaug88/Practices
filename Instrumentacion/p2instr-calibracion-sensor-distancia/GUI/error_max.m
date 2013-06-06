function [error] = error_max(medidas, medias)
    error = [];
    for indice = 1 : length (medidas)
        maximo = max(medidas(indice, :));
        minimo = min(medidas(indice, :));
        distancia = 1:2;
        distancia(1) = abs(medias(indice) - maximo);
        distancia(2) = abs(medias(indice) - minimo);
        error(indice) = max(distancia);
    end
end