% inicializa.m
%
% Script que define todas las variables globales utilizadas por las funciones.
%

global inicio fin incremento contador num_mediciones figuras mediciones
global errores medias

inicio         = 8;  % Inicio del intervalo de medición (8 cm)
fin            = 50; % Fin del intervalo de medición (50 cm)
incremento     = 2;  % Cantidad en que se incrementa la distancia para cada medida
contador       = 1;  % Contador del número de mediciones realizadas
num_mediciones = 20; % Número de mediciones para cada valor de la distancia (para la fiabilidad)
figuras        = [];

% Matriz donde se almacenan las mediciones
% Cada vector fila es de dimensión 'num_mediciones' y almacena las mediciones
mediciones = rand(length(inicio:incremento:fin), num_mediciones);
errores = rand(length(inicio:incremento:fin), 1);
medias = rand(length(inicio:incremento:fin), 1);