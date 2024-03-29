function mp = sm_init_test_signals(mp)
[y,Fs] = audioread('acoustic.wav');
y_resampled = resample(y,mp.Fs,Fs); % resample to change the sample rate to mp.Fs
if (mp.fastsim_flag == 2) || (mp.fastsim_flag == 3)
    mp.test_signal.left  = y_resampled(1:mp.Naudio_samples);
    mp.test_signal.right = y_resampled(1:mp.Naudio_samples);
else
    mp.test_signal.left = y_resampled;
    mp.test_signal.right = y_resampled;
end
mp.test_signal.Nsamples = length(mp.test_signal.left);
mp.test_signal.duration = length(mp.test_signal.left) * mp.Ts;
