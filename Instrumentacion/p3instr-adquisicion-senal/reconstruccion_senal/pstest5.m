% Define los parámetros del muestreo

T    = pi/2 : pi/2 : 8*pi; % Periodo de la señal
freq = 1 ./ T;             % Frecuencia de la señal
Tm   = (pi/2) / 30;        % Periodo de muestreo de la señal

t = cell(length(T), 1); % length = length(T)
for count = 1 : length(T)
    % [0, 2T] => muestrea 2 ciclos de la señal
    t{count} = 0 : Tm : 2*T(count);
end

% Muestrea las señales de prueba

samples = []; % length = length(0 : pi/6 : 11*pi/6) * length(T)
for phase = 0 : pi/6 : 11*pi/6
    for count = 1 : length(T)
        signal_struc = struct;
        
        signal_struc.period         = T(count);
        signal_struc.freq           = freq(count);
        signal_struc.angfreq        = 2 * pi * freq(count);
        signal_struc.phase          = phase;
        signal_struc.t              = t{count};
        signal_struc.sampled_signal = sin( signal_struc.angfreq * t{count} + phase);
        signal_struc.amplitude      = max(signal_struc.sampled_signal);
        
        samples = [samples signal_struc];
    end
end
clear signal_struc
NUM_SIGNALS = length(samples);

signal_params = []; % length = NUM_SIGNALS

for count = 1 : NUM_SIGNALS
    signal_params = [signal_params struct('A', 0, 'w', 0, 'p', 0)];
    
    % Reconstruye las señales
    [A1 w1 p1] = guess_params3(samples(count).t, samples(count).sampled_signal);
    signal_params(count).A = A1;
    signal_params(count).w = w1;
    signal_params(count).p = p1;
    
    % Representa la gráfica de la señal y las gráficas de las señales
    % reconstruidas
    f = figure('Visible', 'off');
    hold on
    plot(samples(count).t, samples(count).sampled_signal, '.-')
    plot(samples(count).t, A1 * sin (w1 * samples(count).t + p1), 'r.')
    hold off
    filename = sprintf('graficas/%03d_grafica_todas_T%f_p%f', count, samples(count).period, samples(count).phase);
    saveas(f, strcat(filename, '.jpg'));
    disp(strcat(filename, '.jpg'))
    close(f);
end
clear t f A1 w1 p1

save('signal_sampling_params.mat', 'T', 'freq', 'Tm')
save('samples.mat', 'samples')
save('guessed_signal_params.mat', 'signal_params')
clear T freq Tm samples signal_params NUM_SIGNALS count filename phase