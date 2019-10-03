%% Joshua Harthan
% EELE477 Lab #11
% 4 Lab Exercises

amp = 1;
Fs = 11025;
Ts = 1/Fs;
duration = 0 : Ts : 3;
frequency = 50;

decibel = 20*log10(amp);

hear_sinus(amp,frequency,duration,Fs);
