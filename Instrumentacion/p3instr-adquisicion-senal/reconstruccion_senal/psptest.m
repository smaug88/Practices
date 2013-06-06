function [f amplitude angularfreq phase] = psptest(nsamples, samplingfreq)
    [t samples] = generate_samples(2*pi, 1, 0, nsamples, samplingfreq);
    f = figure;
    plot(t, samples, 'r.-')
    
    [amplitude angularfreq phase] = guess_params(t, samples);
end