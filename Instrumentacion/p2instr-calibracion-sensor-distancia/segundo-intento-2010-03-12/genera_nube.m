% genera_nube.m
%
% genera_nube(valoresX, valoresY)
%
% Genera una nube de puntos de 'valoresY' frente a 'valoresX' y guarda la
% gráfica en un fichero con un nombre autogenerado usando las variables
% globales.
%
% Necesita las siguientes variables globales:
%     * contador
%     * incremento
%     * figuras
% Todas estas variables se definen ejecutando el script 'inicializa.m'.
%

function [] = genera_nube (valoresx, valoresy)
    global contador incremento figuras
    
    f = figure('Visible',  'off');
    set(f, 'Name', sprintf('Nube de puntos para d=%icm', inicio + (contador-1) * incremento));
    set(f, 'FileName', sprintf('%02i_nube_puntos_%icm', contador, inicio + (contador-1) * incremento));
    plot(valoresx, valoresy, '.');
    figuras = [figuras f];
    saveas(f, get(f, 'FileName'), 'jpg');
    %saveas(f, get(f, 'FileName'), 'png');
    %saveas(f, get(f, 'FileName'), 'tif');
end