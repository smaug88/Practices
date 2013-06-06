function [error] = error_medio(medidas, medias)
    error = 0;
    for indice = 1:length(medias)
        error = abs(abs(medias(indice)) - abs(v(indice)));
    end
    error = error / max(v);
end