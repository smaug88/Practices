% Practica 1 de Instrumentacion - Introduccion a MATLAB
% David Moralez Saez
% Jonan Cruz Martin
% Rafael Casanova Morera

% Apartado 3: Manejo de vectores y matrices en MATLAB
% 3d: Obtener las coordenadas de los elementos maximo, minimo y mayores que
% la media del valor absoluto de la matriz resultante de restar a la matriz
% M al cuadrado el cuadrado de su traspuesta
mean(mean(abs((m')^2-m^2)))
[x,y] = find(m == max(max(m)))
[x,y] = find(m == min(min(m)))
[x,y] = find(m > mean(mean(abs((m')^2-m^2))))

% Apartado 4: Uso de scripts
% 4c: Transformacion del programa del punto anterior en una funcion e
% invocarla desde otro programa con la matriz identidad 3x3.
% Funcion
function [res] = menor(matriz, fila, col)
    dim = size(matriz);
    maxi = dim(1);
    maxj = dim(2);
    
    submatriz = rand(maxi - 1, maxj - 1);
    cuenta = 1;
    
    for ci = 1:maxi
        for cj = 1:maxj
            if ci ~= fila & cj ~= col
                submatriz(cuenta) = matriz(ci, cj);
                cuenta = cuenta + 1;
            end
        end
    end
    
    res = det(submatriz);
end
% Otro programa
matriz = eye([3 3]); % Crea la matriz identidad de 3x3
detmenor = menor(matriz, 1, 1) % Ejemplo: Calcula det del menor del elemento (1, 1)

% Apartado 5: Funciones graficas
x = -10:10
y = polyval([1 2 1], x);
plot(x,y)
% 5b: Definir una rejilla para la figura y cambiar los ejes (grid, axis)
grid on;
axis([-5 4 -1 5])
% 5c: Representar diferentes graficas en la misma figura (subplot)
subplot(2, 2, 1); ezplot('sin(x)')
subplot(2, 2, 2); ezplot('cos(x)')
subplot(2, 2, 3); ezplot('tan(x)')
subplot(2, 2, 4); ezplot('x^2')

% Apartado 6: Adquisicion de datos
% Funcion
function [tiempo, out] = adquirir(numiter)
    out = [];
    tiempo = 0:(numiter-1);
    tiempo = tiempo * 50;
    for i = 1:numiter
        [voltage overVoltage errorcode idnum] = eanalogin(-1, 0, 0, 0);
        out = [out [voltage]];
    end
end
% Codigo
[t v] = adquirir(500)
plot(t, v)
[t v] = adquirir(2500)
plot(t, v)