function mp = sm_init_test_signals(mp)
[y,Fs] = audioread('acoustic.wav');
y_resampled = resample(y,mp.Fs,Fs); % resample to change the sample rate to mp.Fs
mp.test_signal.left = y_resampled;
mp.test_signal.right = y_resampled;
mp.test_signal.Nsamples = lenght(mp.test_signal.left);
mp.test_signal.duration = lenght(mp.test_signal.left) * mp.Ts;
