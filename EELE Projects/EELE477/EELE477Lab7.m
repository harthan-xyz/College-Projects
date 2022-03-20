 %% Joshua Harthan
% EELE477 Lab #7
% 3 Warm-up
% 3.1 Chirps and Aliasing
% (c)

x = mychirp(13000,200,2.5,8000);
figure
spectrogram(x,256,[],256,8000,'yaxis');

%% 3.2 Wideband FM
% (a)

fs = 8000;
tt = 0 : 1/fs : 1.35;

xt = cos(2*pi*900*tt + 200*sin(2*pi*3*tt));

soundsc(xt,fs);

spectrogram(xt,256,[],256,8000,'yaxis');


%% 3.2 Wideband FM
% (c)

fs = 8000;
tt = 0 : 1/fs : 1.35;

xt = cos(2*pi*900*tt + 20*sin(2*pi*30*tt));

soundsc(xt,fs);

spectrogram(xt,64,[],64,8000,'yaxis');

%% 3.2 Wideband FM
% (e)

fs = 8000;
tt = 0 : 1/fs : 1.35;

xt = cos(2*pi*900*tt + 2*sin(2*pi*300*tt));

soundsc(xt,fs);

spectrogram(xt,1024,[],1024,8000,'yaxis');

%% 4 FM Synthesis of Instrument Sounds
% 4.3 Generating the Bell Envelopes

% Case 1
fc = 110;
fm = 220;
Io = 10;
tau = 2;
dur = 6;
fs = 11025;

tt = 0 : 1/fs : dur;

xx = bell(fc,fm,Io,tau,dur,fs);
xxenv = bellenv(tau,dur,fs);

soundsc(xx,fs);

figure();
plot(tt,xxenv);
title("Envelope of Case 1");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
plot(tt,xx);
title("Signal of Case 1");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
spectrogram(xx,1024,[],1024,8000,'yaxis');

%% Case 2
fc = 220;
fm = 440;
Io = 5;
tau = 2;
dur = 6;
fs = 11025;

tt = 0 : 1/fs : dur;

xx = bell(fc,fm,Io,tau,dur,fs);
xxenv = bellenv(tau,dur,fs);

soundsc(xx,fs);

figure();
plot(tt,xxenv);
title("Envelope of Case 2");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
plot(tt,xx);
title("Signal of Case 2");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
spectrogram(xx,1024,[],1024,8000,'yaxis');

%% Case 3
fc = 110;
fm = 220;
Io = 10;
tau = 12;
dur = 3;
fs = 11025;

tt = 0 : 1/fs : dur;

xx = bell(fc,fm,Io,tau,dur,fs);
xxenv = bellenv(tau,dur,fs);

soundsc(xx,fs);

figure();
plot(tt,xxenv);
title("Envelope of Case 3");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
plot(tt,xx);
title("Signal of Case 3");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
spectrogram(xx,1024,[],1024,8000,'yaxis');
%% Case 4
fc = 110;
fm = 220;
Io = 10;
tau = .3;
dur = 3;
fs = 11025;

tt = 0 : 1/fs : dur;

xx = bell(fc,fm,Io,tau,dur,fs);
xxenv = bellenv(tau,dur,fs);

soundsc(xx,fs);

figure();
plot(tt,xxenv);
title("Envelope of Case 4");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
plot(tt,xx);
title("Signal of Case 4");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
spectrogram(xx,1024,[],1024,8000,'yaxis');
%% Case 5
fc = 250;
fm = 350;
Io = 5;
tau = 2;
dur = 5;
fs = 11025;

tt = 0 : 1/fs : dur;

xx = bell(fc,fm,Io,tau,dur,fs);
xxenv = bellenv(tau,dur,fs);

soundsc(xx,fs);

figure();
plot(tt,xxenv);
title("Envelope of Case 5");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
plot(tt,xx);
title("Signal of Case 5");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
spectrogram(xx,1024,[],1024,8000,'yaxis');

%% Case 6
fc = 250;
fm = 350;
Io = 3;
tau = 1;
dur = 5;
fs = 11025;

tt = 0 : 1/fs : dur;

xx = bell(fc,fm,Io,tau,dur,fs);
xxenv = bellenv(tau,dur,fs);

soundsc(xx,fs);

figure();
plot(tt,xxenv);
title("Envelope of Case 6");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
plot(tt,xx);
title("Signal of Case 6");
xlabel("Time (s)");
ylabel("Amplitude");

figure();
spectrogram(xx,1024,[],1024,8000,'yaxis');

%% 5 C-Major Scale

soundsc(bell(130.815,261.63,1,1,5,11025),11025);
pause(2);
soundsc(bell(146.83,293.66,1.1,1,5,11025),11025);
pause(2);
soundsc(bell(164.815,329.63,1.15,1,5,11025),11025);
pause(2);
soundsc(bell(174.615,349.23,1.3,1,5,11025),11025);
pause(2);
soundsc(bell(196,392,1.5,1,5,11025),11025);
pause(2);
soundsc(bell(220,440,2,1,5,11025),11025);
pause(2);
soundsc(bell(246.94,493.88,2.1,1,5,11025),11025);
pause(2);
soundsc(bell(261.625,523.25,2.1,1,5,11025),11025);
