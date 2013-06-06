function [t samples] = generate_samples(signalfreq, amplitude, phase, nsamples, samplingfreq)
    samplingperiod = 1 / samplingfreq;
    t = 0 : samplingperiod : nsamples * samplingperiod;
    angularfreq = (2 * pi) / signalfreq;
    samples = amplitude * sin(angularfreq * t + phase);
end