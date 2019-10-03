%% Joshua Harthan
% EELE477 Lab #14
% 3 Warmup
% 3.1 Create a BAndpass Filter (BPF)
% (a)

l = 25;
wc = 0.2 * pi;
n = 0:1:30;
ww = -pi : (pi/100): pi;


hh = (2./25) * cos(wc*n);

ha = ones(1,l)/l;

HH = freqz(ha,1,ww);

figure();
stem(hh);

figure();
subplot(2,1,1);
plot(ww,(abs(HH))); hold on
hold on, stem(pi*[-0.5,-0.2,0,0.2,-.5],0.9*ones(1,5),'r'), hold off;
axis([-pi pi 0 1.5]);
xlabel("Normalized Frequency");
ylabel("Magnitude");

subplot(2,1,2);
plot(ww,angle(HH)*180/pi); 
axis([-pi pi -200 200]);
xlabel("Normalized Frequency");
ylabel("Phase (Degrees)");

%% 3 Warmup 
% 3.4 Filtering a Signal
l = 25;
wc = 0.2 * pi;
n = 0:1:600;
ww = -pi : (pi/100) : pi;

figure();
for r = n
    if r >= 0 && r < 200
        h1 = (2/l) * cos(wc*r);
        x1 = cos(0.5.*pi.*r);
        H1 = freqz(h1,1,ww);
        subplot(2,1,1);
        stem(r,x1,"blue"); hold on
        y1 = firfilt(x1,h1);
        Y1 = freqz(y1,1,ww);
        subplot(2,1,2);
        stem(r,y1,"r."); hold on
    elseif r >= 200 && r < 400
        h2 = (2/l) * cos(wc*r);
        x2 = 2;
        H2 = freqz(h2,1,ww);
        subplot(2,1,1);
        stem(r,x2,"blue"); hold on
        y2 = firfilt(x2,h2);
        Y2 = freqz(y2,1,ww);
        subplot(2,1,2);
        stem(r,y2,"r."); hold on
    elseif r >= 400 && r < 600
        h3 = (2/l) * cos(wc*r); 
        x3 = 0.5.*cos(0.2.*pi.*r);
        H3 = freqz(h3,1,ww);
        subplot(2,1,1);
        stem(r,x3,"blue"); hold on
        y3 = firfilt(x3,h3);
        Y3 = freqz(y3,1,ww);
        Y3(101) = Y3(100);
        subplot(2,1,2);
        stem(r,y3,"r."); hold on
    end
end
hold off
title("Plot of x[n]");
xlabel("Plot of y[n]");


%% 4 Lab Exercises - Bandpass Filter Design
% 4.2 A Better Bandpass Filter
ww = [0 0.1*pi .25*pi .4*pi .5*pi .75*pi];
w = .25*pi;
L = 41;
n = 0:1:(L-1);
hh = (0.54 - 0.46.*cos((2.*pi.*n)./(L-1))).*cos(w.*(n-(L-1)./2));

HH = freqz(hh);

xx = 2+2*cos(0.1*pi*n + pi/3)+cos(0.25*pi*n-pi/3);

yy = firfilt(hh,xx);

figure();
plot(yy);
title("Plot of Output Signal");

figure();
subplot(2,1,1);
plot(abs(HH)/(2*pi));
axis([0 250 0 4]);
ylabel("Magnitude");
title("Magnitude Plot of the Hamming BPF");

subplot(2,1,2);
plot(angle(HH)*180/pi); 
axis([0 250 -200 200]);
ylabel("Phase (Degrees)");
title("Phase Plot of the Hamming BPF");

%% 5 Lab Exercises - Piano Note Decoding
% 5.2 Bandpass Filter Bank Design
w = .25*pi;
L = 41;
n = 0:1:(L-1);
hh = (0.54 - 0.46.*cos((2.*pi.*n)./(L-1))).*cos(w.*(n-(L-1)./2));

figure();

bpfbank(hh,21,0.1*pi);
bpfbank(hh,L,w);
bpfbank(hh,61,.4*pi);
bpfbank(hh,81,.5*pi);
bpfbank(hh,101,.75*pi);
hold off
title("Plot of BPF Bank");


%% 5 Lab Exercises - Piano Note Decoding
% 5.3 Piano Octave Decoding
fs = 8000;

nn = 0:1/fs:.85;

figure();
for r = nn
    if r >= 0 && r < .25
        x1 = cos(2.*pi.*(220).*r);
    elseif r >= .3 && r < .55
        x2 = cos(2.*pi.*(880).*r);
    elseif r >= .6 && r < .85
        x3 = cos(2.*pi.*(440).*r) + cos(2.*pi.*(1760).*r);
    end
end

xx = x1+x2+x3;

w = .25*pi;
L = 41;
n = 0:1:(L-1);
hh = (0.54 - 0.46.*cos((2.*pi.*n)./(L-1))).*cos(w.*(n-(L-1)./2));

b1 = bpfbank(hh,21,0.1*pi);
b2 = bpfbank(hh,L,w);
b3 = bpfbank(hh,61,.4*pi);
b4 = bpfbank(hh,81,.5*pi);
b5 = bpfbank(hh,101,.75*pi);

aa = firfilt(xx,b1);
ab = firfilt(xx,b2);
ac = firfilt(xx,b3);
ad = firfilt(xx,b4);
ae = firfilt(xx,b5);
hold off

figure();
plot(aa);
title("Filtered Signal Through First BPF Filter");
figure();
plot(ab);
title("Filtered Signal Through Second BPF Filter");
figure();
plot(ac);
title("Filtered Signal Through Third BPF Filter");
figure();
plot(ad);
title("Filtered Signal Through Fourth BPF Filter");
figure();
plot(ae);
title("Filtered Signal Through Fifth BPF Filter");