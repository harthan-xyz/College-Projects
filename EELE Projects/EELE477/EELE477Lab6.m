 %% Joshua Harthan
% EELE477 Lab #6
% 3 Warm-up
% 3.1 Gaussian Weighting
% (c)

f = 55:1:1760;
x1 = gaussian(440,.5,f); 
semilogx(x1);

%% 3.1 Gaussian Weighting 
%(d)

ff = 2.^(5:1/12:10); 
f = 55:1:1760;
x2 = gaussian(440,.5,f); 
figure();
plot(f,x2);
figure();
semilogx(f,x2);
 
%% 3.2 Synthesize Octaves with Gaussian Weighting 
% (a)
fc = 440;
dur = 2;
fs = 8000;
x1 = key2note(gaussian(fc,.5, 65.406),16, dur);
x2 = key2note(gaussian(fc,.5, 130.81),28, dur);
x3 = key2note(gaussian(fc,.5, 261.63),40, dur);
x4 = key2note(gaussian(fc,.5, 327.03),52, dur);
x5 = key2note(gaussian(fc,.5, 392.436),64, dur);
xx = x1+x2+x3+x4+x5;
soundsc(xx,fs);

spectrogram(xx,1024,[],1024,fs,'yaxis');

%% 4 A Musical Illusion
% (a)
fc = log2(260);
dur = .25;
fs = 22050;
var = 2;

f = [27.5 55 110 220 440 880 1760 3520 7040];
ff = 27.5 : 1 : 7040;

amplitude = gaussian(fc,var,ff);

figure();
semilogx(ff,amplitude);
title("Amplitude on a Log Scale");
xlabel("Frequency (Hz)");
ylabel("Amplitude");
for n = 1:35
    x1 = key2note(gaussian(fc,var,27.5),4, dur);
    x2 = key2note(gaussian(fc,var,55),16, dur);
    x3 = key2note(gaussian(fc,var,110),28, dur);
    x4 = key2note(gaussian(fc,var,220),40, dur);
    x5 = key2note(gaussian(fc,var,440),52, dur);
    x6 = key2note(gaussian(fc,var,880),64, dur);
    x7 = key2note(gaussian(fc,var,1760),76, dur);
    x8 = key2note(gaussian(fc,var,3520),88, dur);
    x9 = key2note(gaussian(fc,var,7040),100, dur);
    xx = x1+x2+x3+x4+x5+x6+x7+x8+x9;
    soundsc(xx,fs);
    pause(dur -.05);
    fc = fc + 7;   
end

figure();
spectrogram(xx,1024,[],1024,fs,'yaxis');

x = xx ./ max(abs(xx(:)));
audiowrite('scale.wav', x, 22050);