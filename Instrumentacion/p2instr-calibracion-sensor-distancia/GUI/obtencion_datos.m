function [v error media] = obtencion_datos(N)
    media = 0;
    for indice = 1:N
        [voltage overVoltage errorcode idnum] = eanalogin(-1, 0, 8, 0);
        media = media + voltage;
        v(indice) = voltage;
    end
    media = media/N;
    error = 0;
    for indice = 1:N
        error = abs(abs(media) - abs(v(indice)));
    end
    error = error / max(v);
end