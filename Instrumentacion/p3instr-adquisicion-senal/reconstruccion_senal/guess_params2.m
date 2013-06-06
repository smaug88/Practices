% guess_params v2
% Calcula el periodo de la señal como el doble de la diferencia de fase
% entre una cresta y una trough consecutivas de la onda

function [amplitude angularfreq phase] = guess_params2(t, samples)
    % Find  the first crest of the signal
    index = 1;
    csign = sign(samples(index) - samples(index + 1));
    nsign = sign(samples(index + 1) - samples(index + 2));
    while csign == nsign
        index = index + 1;
    end
    index = index + 1;
    amplitude = samples(index);
    
    % Search for the next minimun from the maximum amplitude (one
    % mid-wavelength)
    sizeoft = length(t);
    count = index;
    while (count < sizeoft) && (samples(count) - samples(count + 1) > 0)
    %while (samples(mod(count, sizeoft)) - samples(mod(count + 1, sizeoft))) > 0
        count = count + 1;
    end
    % It has run a mid-wavelength from last crest to current trough! The
    % period can be calculated now!
    period = 2 * (t(count) - t(index));
    angularfreq = (2 * pi) / period;
    
    % Can now calculate phase
    count = 1;
    while (count <= sizeoft) && (samples(count) >= 0)
    %while samples(mod(count, sizeoft)) >= 0
        count = count + 1;
    end
    tmparray = samples(1 : count);
    count = length(tmparray);
    while (count > 0) && (samples(count) <= 0)
    %while samples(mod(count, sizeoft)) <= 0
        count = count - 1;
    end
    if count > 1
       tmparray = tmparray(count : length(tmparray));
       switch length(tmparray)
           case 1
               phase = period - tmparray(1);
           case 2
               phase = period - min(abs(tmparray));
           case 3
               phase = period - tmparray(2);
       end
    else
        phase = 0;
    end
end

% PROBLEMAS
%
% 1) La fase inicial no se puede calcular obtener de la primera muestra, ya
% que esto presupone que la primera muestra corresponde al instante de
% tiempo t = 0, y esto no siempre será cierto.
%
% 2) Hay que modificar los bucles para el cálculo del periodo, para evitar
% que haya errores cuando el máximo (amplitud) está muy cerca del fin del
% vector de muestras, ya que esto provocaría que no se calculara
% correctamenente el periodo. Hay que introducir un módulo, para que, si se
% termina el vector de muestras antes de llegar a la siguiente cresta, se
% continúe la búsqueda de la cresta por el principio del vector (de forma
% cíclica).
%
% 3) Sería conveniente optimizar la forma de cálculo del periodo, ya que
% actualmente es computacionalmente muy costosa.
%
% LIMITACIONES
%
% 1) Si el muestreo no se realiza con la frecuencia adecuada, el muestreo
% no tiene resolución suficiente como para permitir calcular correctamente
% los parámetros de la señal (periodo, etc.).