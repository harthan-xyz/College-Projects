%% Joshua Harthan
% EELE477 Lab #12
% 2 Warmup
% 2.2 Cascading Two Systems
% (a)

filter1 = [1 .8 .64 .512 .4096 .32768 .262144 .2097152 .16777216 .134217728]

filter2 = [1 -.8]

HH = freqz(filter2,1,filter1);

figure();
subplot(2,1,1);
plot(filter1, abs(filter1));
title("Magnitude of Filter 1");
subplot(2,1,2);
plot(filter1, angle(filter1));
title("Phase of Filter 1");

figure();
subplot(2,1,1);
plot(filter2, abs(filter2));
title("Magnitude of Filter 2");
subplot(2,1,2);
plot(filter2, angle(filter2));
title("Phase of Filter 2");

figure();
subplot(2,1,1);
plot(HH, abs(HH));
title("Magnitude of the System");
subplot(2,1,2);
plot(HH, angle(HH));
title("Normalized Radian Frequency of the System");


%% 3 Lab Exercises
% 3.1 Nuling Filters for Rejection
nn = 0:1:149;

xx = 5.*cos(0.38.*pi.*nn) + 22.*cos(0.44.*pi.*nn - (pi/3)) + 22.*cos(0.7.*pi.*nn - (pi/4));

ww = [0.44*pi 0.7*pi];
yy = [1 -2.*cos(ww) 1];

y1 = firfilt(ww,yy);

x1 = firfilt(xx,y1);

figure();
freqz(x1);
title("Frequency response of the system");

figure();
plot(x1);
grid on
axis([1 40 -200 200]);
title("Plot of the sum of sinusoids");

z1 = (5.*cos(0.38.*pi.*nn) + 22.*cos(0.44.*pi.*nn - (pi/3)) + 22.*cos(0.7.*pi.*nn - (pi/4)))-(2.*cos(.4.*pi).*(5.*cos(0.38.*pi.*nn - 1) + 22.*cos(0.44.*pi.*nn - 1 - (pi/3)) + 22.*cos(0.7.*pi.*nn - 1 - (pi/4)))) + (5.*cos(0.38.*pi.*nn - 2) + 22.*cos(0.44.*pi.*nn - 2 - (pi/3)) + 22.*cos(0.7.*pi.*nn - 2 - (pi/4)));
z2 = (5.*cos(0.38.*pi.*nn) + 22.*cos(0.44.*pi.*nn - (pi/3)) + 22.*cos(0.7.*pi.*nn - (pi/4)))-(2.*cos(.77.*pi).*(5.*cos(0.38.*pi.*nn - 1) + 22.*cos(0.44.*pi.*nn - 1 - (pi/3)) + 22.*cos(0.7.*pi.*nn - 1 - (pi/4)))) + (5.*cos(0.38.*pi.*nn - 2) + 22.*cos(0.44.*pi.*nn - 2 - (pi/3)) + 22.*cos(0.7.*pi.*nn - 2 - (pi/4)));

zz = z1 + z2;

figure();
plot(zz);
grid on 
axis([0 40 -200 200]);
title("Plot of the mathematical formula");
    
%% 3 Lab Exercises
% 3.2 Simple Bandpass Filter Design
ww = [0.3.*pi 0.44.*pi 0.7.*pi];

L1 = 10;

hh1 = (2./L1).*cos(ww*0:1:L1);

L2 = 20;

hh2 = (2./L2).*cos(ww*0:1:L2);

L3 = 40;

hh3 = (2./L3).*cos(ww*0:1:L3);

L4 = 500;
hh4 = (2./L4).*cos(ww*0:.44*pi:L4);

figure();
freqz(hh1);
title("Passband at a length of 10");

figure();
freqz(hh2);
title("Passband at a length of 20");

figure();
freqz(hh3);
title("Passband at a length of 40");

figure();
freqz(hh4);
title("Passband at a length of 500");

%------------------------------------------------------------------------
nn = 0:1:100;

xx = 5.*cos(0.38.*pi.*nn) + 22.*cos(0.44.*pi.*nn - (pi/3)) + 22.*cos(0.7.*pi.*nn - (pi/4));

ww = [0.44*pi 0.7*pi];
yy = [1 -2.*cos(ww) 1];

y1 = firfilt(ww,yy);

x1 = firfilt(xx,y1);

filteredsignal = firfilt(x1,hh4);

figure();
freqz(x1);
title("Signal Before Filter")
figure();
freqz(filteredsignal);
title("Signal After Filter");

[h,w] = freqz(hh4);

figure();
plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title("Magnitude of the passband filter")
