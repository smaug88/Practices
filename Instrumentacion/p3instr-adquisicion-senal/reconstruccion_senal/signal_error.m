function [abs_error max_error mean_error rel_error] = signal_error(A1, w1, p1, A2, w2, p2, t)

    signal         = A1 * sin(w1*t + p1);
    sampled_signal = A2 * sin(w2*t + p2);
    
    abs_error      = signal - sampled_signal;
    max_error      = max(abs_error);
    mean_error     = sum(abs_error) / length(t);
    mean_amplitude = (A1 + A2) / 2;
    rel_error      = mean_error / mean_amplitude;
    
    % hold on
    % plot(t, signal)
    % plot(t, sampled_signal, 'r.')
    % hold off

end