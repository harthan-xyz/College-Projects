 %% Joshua Harthan
% EELE477 Lab #4
% 4 Chirps and Beats
% 4.1 Beat Notes
% (b)

beatcon;
beat(10,10,1000,10,11025,1);

%% 4.2 More on Specrtograms
% (a)

beat(10,10,2000,32,11025,.26);
xlabel("Time (seconds)");
ylabel("Amplitude");
title("x(t)");
%% 4.2 More on Spectrograms
% (b)

x = beat(10,10,2000,32,11025,.26);
spectrogram(x,2048,[],2048,11025); colormap(1-gray(256))
title("Spectrogram of x(t)");

%% 4.2 More on Spectrograms
% (c)

x = beat(10,10,2000,32,11025,.26);
spectrogram(x,16,[],16,11025); colormap(1-gray(256))
title("Spectrogram of x(t)");

%% 4.3 Spectrogram of a Chirp

x = mychirp(4186.01,440,2.5,11025);
spectrogram(x,2048,[],2048,11025); colormap(1-gray(256))
title("Spectrogram of chirp signal");

%% 4.4 A Chirp Puzzle

x = mychirp(3000,-2000,3,11025);
spectrogram(x,2048,[],2048,11025); colormap(1-gray(256))
title("Spectrogram of chirp signal");