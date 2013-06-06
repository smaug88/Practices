samples(count)
[A w p] = guess_params3(samples(count).t, samples(count).sampled_signal)
plot(samples(count).t, A*sin(w*samples(count).t + p), 'r.')
hold on
plot(samples(count).t, samples(count).sampled_signal)
hold off