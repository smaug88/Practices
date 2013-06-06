% guess_params v4
% Calcula el periodo de la señal como el doble de la diferencia de fase
% entre una cresta y una trough consecutivas de la onda

function [amplitude angularfreq phase] = guess_params4(t, samples)
    % Find  the first crest or trough of the signal (whatever comes first)
    index = 1;
    csign = sign(samples(index) - samples(index + 1)); % current difference
    % psign = csign; % Store sign for the phase
    nsign = sign(samples(index + 1) - samples(index + 2)); % next difference
    while csign == nsign
        index = index + 1;
        csign = nsign; % current difference
        nsign = sign(samples(index + 1) - samples(index + 2)); % next difference
    end
    index = index + 1;
    amplitude = abs(samples(index)); % May be a crest or a trough, thus the abs
    
    % Search for the next crest or trough (run one mid-wavelength)
    count = index;
    csign = sign(samples(count) - samples(count + 1)); % current difference
    while csign == 0
        count = count + 1;
        csign = sign(samples(count) - samples(count + 1)); % current difference
    end
    csign = sign(samples(count) - samples(count + 1)); % current difference
    nsign = sign(samples(count + 1) - samples(count + 2)); % next difference
    while csign == nsign
        count = count + 1;
        csign = nsign; % current difference
        nsign = sign(samples(count + 1) - samples(count + 2)); % next difference
    end
    count = count + 1;
    
    csign = sign(samples(count) - samples(count + 1)); % current difference
    nsign = sign(samples(count + 1) - samples(count + 2)); % next difference
    while csign == nsign
        count = count + 1;
        csign = nsign; % current difference
        nsign = sign(samples(count + 1) - samples(count + 2)); % next difference
    end
    count = count + 1;
    
    % Can now calculate period and frequency
    period = t(count) - t(index);
    angularfreq = (2 * pi) / period;
    % Can now calculate phase
    phase = asin(samples(1)) / amplitude; % phase = period / 4 - t(index);
end