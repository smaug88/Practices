% mide.m
%
% Script que realiza una medición y la añade a la matriz de mediciones.
%
% Necesita las siguientes variables globales:
%     * contador
%     * fin
%     * num_medidas
%     * incremento
% Todas estas variables se definen ejecutando el script 'inicializa.m'.
%

global contador fin num_mediciones incremento

if contador * incremento > fin
	disp('Ya se han tomado todas las medidas.')
else
	[tiempo medidas] = adquiere(num_mediciones);
	mediciones(contador, :) = medidas;
    genera_nube(contador * incremento, medidas);
	clear tiempo medidas
	contador = contador + 1;
end