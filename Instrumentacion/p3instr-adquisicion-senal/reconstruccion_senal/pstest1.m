% samplingfreq = 1000;
% samplingperiod = 1 / sampligfreq;
% nsamples = 10000;
% t = 0 : samplingperiod : nsamples * samplingperiod;
% 
% figs = [];
% figs(1) = figure;
% plot(t, sin(t))

[t samples] = generate_samples(2*pi, 1, 0, 2, 50);
f = figure;
plot(t, samples, 'r.-')

[amplitude angularfreq phase] = guess_params(t, samples)