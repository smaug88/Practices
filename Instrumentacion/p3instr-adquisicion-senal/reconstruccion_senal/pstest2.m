% Muestrea una se�al de ejemplo: x(t) = sin(t)

T = 2 * pi; % Periodo de la se�al
Nsamples = 30; % N�mero de muestras
Tm = T / Nsamples; % Periodo de muestreo de la se�al
t = 0 : Tm : 2*T;
samples = sin(t); % x(t) = sin(t)
f = figure;
plot(t, samples, '.')

% Reconstruye la se�al

[A1 w1 y1] = guess_params1(t, samples);
[A2 w2 y2] = guess_params2(t, samples);
% f = figure;
% plot(t, A1 * sin(w1 * t + y1), '.-')
hold on
plot(t, A1 * sin(w1 * t + y1), 'r.-')
plot(t, A2 * sin(w2 * t + y2), 'g.-')
hold off