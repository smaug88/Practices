% mide.m
%
% Script que realiza una medición y la añade a la matriz de mediciones.
%
% Necesita las siguientes variables globales:
%     * contador
%     * fin
%     * num_medidas
%     * incremento
%     * errores
%     * medias
% Todas estas variables se definen ejecutando el script 'inicializa.m'.
%

global contador fin num_mediciones incremento errores medias

if inicio + (contador-1) * incremento > fin
	disp('Ya se han tomado todas las medidas.')
else
	[medidas error media] = obtencion_datos(num_mediciones);
	mediciones(contador, :) = medidas;
    errores(contador) = error;
    medias(contador) = media;
    %genera_nube(contador * incremento, medidas);
	clear tiempo medidas error media
	contador = contador + 1;
    disp(inicio + (contador-1) * incremento)
end