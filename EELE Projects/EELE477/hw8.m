%%Joshua Harthan
% HW 8 #6

close all; clear all; clc;
%%
%(a) x(t) = (6000t)/ (pi * t)
% X(jw) = 1 from |w| < 6000 and 0 from |w| > 6000

%% Problem

% Your task for this problem is to define the correct time vector and
% frequency vector that can be used to plot a piano note in the time and
% frequency domains. (Assume the note starts at time t=0.)

[y,fs] = audioread('PianoNote.wav');    % Read the piano note and the
                                        % sampling frequency used to
                                        % record it.
y = y(:,1);                 % Grab one channel of the stereo signal.

% Listen to the soothing sound produced by a single piano key.
sound(y,fs);

% Define the time vector
t = 0:1/fs:1.5404988;       % <-- Your code goes here!
               % Given the sampling frequency, how many seconds (or
               % microseconds) are between each sample?
               % If time starts at 0, when does it stop?
               % Make sure that t has the same length as y!

% Plot the signal in the time domain.
figure();
plot(t,y);
title('y(t)');
xlabel('time (sec)');

% Calculate the Fourier Transform of the signal
Y = fft(y);
Y = fftshift(Y);
Y = Y/fs;

% Define the frequency vector
w = linspace(-pi*fs,pi*fs,length(Y));     % <--- Your code goes here!
              % What is the most negative frequency?
              % What is the most positive frequency?
              % How many points do you need in between?

% Plot the signal in the frequency domain
figure();
plot(w,abs(Y));
title('|Y(j\omega)|');
xlabel('frequency (rad/sec)');

%%
%(d) The frequency of the tallest spike in radians/sec is around 2800 rad/sec or 445.63 Hz. This corresponds to the note A4.