% Define los par�metros del muestreo

T = pi/2 : pi/2 : 8*pi; % Periodo de la se�al
freq = 1 ./ T;           % Frecuencia de la se�al
Nsamples = 30;          % N�mero de muestras
Tm = T / Nsamples;      % Periodo de muestreo de la se�al

t = cell(length(T), 1); % length = length(T)
for count = 1 : length(T)
    % [0, 2T] => muestrea 2 ciclos de la se�al
    t{count} = 0 : Tm(count) : 2*T(count);
end

% Muestrea las se�ales de prueba

samples = []; % length = length(0 : pi/6 : 11*pi/6) * length(T)
for phase = 0 : pi/6 : 11*pi/6
    for count = 1 : length(T)
        signal_struc = struct;
        
        signal_struc.sampled_signal = sin( T(count) * t{count} + phase);
        signal_struc.period         = T(count);
        signal_struc.phase          = phase;
        
        samples = [samples signal_struc];
    end
end
clear signal_struc
NUM_SIGNALS = length(samples);

signal_params1 = []; % length = NUM_SIGNALS
signal_params2 = []; % length = NUM_SIGNALS

for count1 = 1 : NUM_SIGNALS
    for count2 = 1 : length(T)
        % Representa la gr�fica de las se�ales de prueba
        f = figure('Visible', 'off');
        plot(t{count2}, samples(count1).sampled_signal, '.')
        filename = sprintf('graficas/%d_grafica_senal_T%f_p%f', count1, samples(count1).period, samples(count1).phase);
        saveas(f, strcat(filename, '.jpg'));
        close(f);
        
        signal_params1 = [signal_params1 struct('A', 0, 'w', 0, 'p', 0)];
        signal_params2 = [signal_params2 struct('A', 0, 'w', 0, 'p', 0)];
        
        % Reconstruye las se�ales
        [A1 w1 p1] = guess_params1(t{count2}, samples(count1).sampled_signal);
        [A2 w2 p2] = guess_params2(t{count2}, samples(count1).sampled_signal);
        signal_params1(count1).A = A1;
        signal_params1(count1).w = w1;
        signal_params1(count1).p = p1;
        signal_params2(count1).A = A2;
        signal_params2(count1).w = w2;
        signal_params2(count1).p = p2;
        
        % Representa las gr�ficas de las se�ales reconstruidas
        f = figure('Visible', 'off');
        hold on
        plot(t{count2}, A1 * sin (w1 * t{count2} + p1), 'r.-')
        plot(t{count2}, A2 * sin (w2 * t{count2} + p2), 'g.-')
        hold off
        filename = sprintf('graficas/%d_grafica_reconstruida_T%f_p%f', count1, samples(count1).period, samples(count1).phase);
        saveas(f, strcat(filename, '.jpg'));
        close(f);
        
        % Representa la gr�fica de la se�al y las gr�ficas de las se�ales
        % reconstruidas
        f = figure('Visible', 'off');
        hold on
        plot(t{count2}, A1 * sin (w1 * t{count2} + p1), 'r.-')
        plot(t{count2}, A2 * sin (w2 * t{count2} + p2), 'g.-')
        plot(t{count2}, samples(count1).sampled_signal, '.')
        hold off
        filename = sprintf('graficas/%d_grafica_todas_T%f_p%f', count1, samples(count1).period, samples(count1).phase);
        saveas(f, strcat(filename, '.jpg'));
        close(f);
    end
end
clear f A1 w1 p1 A2 w2 p2

save('signal_sampling_params.mat', 'T', 'freq', 'Nsamples', 'Tm')
save('samples.mat', 'samples')
save('guessed_signal_params.mat', 'signal_params1', 'signal_params2')