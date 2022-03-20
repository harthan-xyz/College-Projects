%% Joshua Harthan
% EELE477 Lab #1
% 1.3 Getting Started
% (e)

pi*pi - 10
sin(pi/4)
ans ^ 2

%% 1.3 Getting Started
% (f)

x = sin( pi/5)
cos( pi/5 )
y = sqrt( 1 - x*x )
ans

%% 1.3 Getting Started
% (g)

z = 3 + 4i, w = -3 + 4j
real(z), imag(z)
abs([z,w])
conj(z+w)
angle(z)
exp( j*pi )
exp(j*[ pi/4, 0, -pi/4 ])

%% 2.1 MatLab Array Indexing
% (a)

jkl = 0 : 6
% Shows the integers bounded between 0 and 6, starting at 0 and ending at 6, showing each interval at a value of one.

jkl = 2 : 4 : 17
% Shows the integers bounded between 2 and 17, starting at 2 and showing each integer at at a value of 4 intervals; since 17 is not within the bounds, the final value shown is 14.

jkl = 99 : -1 : 88
% Shows the integers bounded between 88 and 99, starting at 99 and ending at 88 and showing each value with intervals of -1. 

ttt = 2 : (1/9) : 4
% Shows the numbers bounded between 2 and 4, starting at 2 and ending at 4, showing each value of 1/9 intervals.

tpi = pi * [ 0 : 0.1 : 2 ]; 
tpi
% Shows the numbers bounded between 0 and 2, starting with at 0 and ending at 2, showing each value at .1 intervals; these values are multplied by pi.

%% 2.1 MatLab Array Indexing
% (b)

xx = [ zeros(1,3), linspace(0,1,5), ones(1,4) ]
xx(4:6)
size(xx)
length(xx)
xx(2:2:length(xx))
% The line of code xx(4:6) points to the the positions of 4 to 6 in the matrix xx that was created in the first line of code. The line size(xx) describes the size of the matrix, while length(xx) describes the length of the matrix as a vector. The last line of code displays every other element in the matrix.  

%% 2.1 MatLab Array Indexing
% (c)

xx = [ zeros(1,3), linspace(0,1,5), ones(1,4) ]
yy = xx; yy(4:6) = pi*(1:3)

yy = xx; yy(2:2:length(yy)) = pi^pi

%% 2.2 MatLab Script Files
% (a)

xk = cos( pi*(0:11) / 4)

% The different values of cosine are stored for the incremetning values of the integer being multiplied by pi in the equation. Therefore xk(1) is equivalent to .7071 as it is just cos(pi/4), and xk(0) is defined to be a value of 1 as it is just the cos(0). 

%% 2.2 MatLab Script Files
% (b)

yy = [ ];
for k =-5:5
    yy(k+6) = cos( k*pi/3)
end
yy

yy = [ ]; yy(1:11) = cos((-5:5)*pi/3)

% It is necessary to write yy(k+6), as this is simply just referring to the spots within the array, since there is no such thing as negative indexes within an array, it is not possible to use negative numbers in this way. Therefore, if we were to use yy(k) instead, we would get an error in MatLab.

%% 2.2 MatLab Script Files
% (c)

x = [-3 -1 0 1 3];
y = x.*x - 3*x;
plot( x,y)
z = x + y*sqrt(-1)
plot(z)

%% 2.2 MatLab Script Files
% (d)

tt = -1 : 0.01 : 1;
xx = cos( 5*pi*tt );
zz = 1.4*exp(j*pi/2)*exp(j*5*pi*tt);
plot (tt, xx, 'b-', tt, real(zz), 'r--'), grid on
a sinusoid
title('TEST PLOT of a SINUSOID')
xlabel('TIME (sec)')

% When plotting real(zz), it is a sinusoid as the function is a sinusoid, it is just in a different form of expressing a sinusoid. The amplitude of the sinusoid is 1.4, while the phase of the sinusoid is pi/2. 

%% 2.3 MatLab Sound
% (b)

tt = 0 : (1/11025) : 0.9;
xx = sin( 2000*pi*tt );

length(tt)
soundsc(xx, 11025)

% The number of samples within the tt vector is 9923 samples.

%% 3. Manipulating Sinusoids with MatLab

tt = -.5 : 0.0099 : .5; %define the time vector

%define the amplitudes of the sinusoids
a1 = 20;
a2 = 1.2 * a1;

%define the constants to be used within the sinusoid to be generated
m = 2;
d = 1;

tm1 = (37.2/m)*tt;
tm2 = -(41.3/d)*tt;

%define the sinusoids to be plotted
x1 = a1 * cos(2 * pi * (4000) * (tt - tm1)); 
x2 = a2 * cos(2 * pi * (4000) * (tt - tm2));
x3 = x1 + x2;

%plot the sinusoids with respect to the time vector tt
subplot(3,1,1), grid on
plot(tt,x1);
title('Joshua Harthan Plot of X1')

subplot(3,1,2), grid on
plot(tt,x2);
title('Plot of X2')

subplot(3,1,3), grid on
plot(tt,x3);
title('Plot of X3')
xlabel('TIME (sec)')

%% 3.1 Theoretical Calculations

tt = -.5 : 0.0099 : .5; %define the time vector

%define the amplitudes of the sinusoids
a1 = 20;
a2 = 1.2 * a1;

%define the constants to be used within the sinusoid to be generated
m = 2;
d = 1;

tm1 = (37.2/m)*tt;
tm2 = -(41.3/d)*tt;

%define the sinusoids to be plotted
x1 = a1 * cos(2 * pi * (4000) * (tt - tm1)); 
x2 = a2 * cos(2 * pi * (4000) * (tt - tm2));
x3 = x1 + x2;

%find the peaks of each sinusoid, to find the maximum of 
[PkAmp1, PkTime1] = findpeaks(x1,tt);
[PkAmp2, PkTime2] = findpeaks(x2,tt);
[PkAmp3, PkTime3] = findpeaks(x3,tt);

%plot the sinusoids in one plot, with measurements of the peaks
subplot(3,1,1);
plot(tt,x1);
hold on
plot(PkTime1,PkAmp1,'o', 'MarkerFaceColor', 'r');
hold off
grid on

subplot(3,1,2);
plot(tt,x2);
hold on
plot(PkTime2,PkAmp2,'o', 'MarkerFaceColor', 'r');
hold off
grid on

subplot(3,1,3);
plot(tt,x3);
hold on
plot(PkTime3,PkAmp3,'o', 'MarkerFaceColor', 'r');
hold off
grid on

%take the Fourier Transform of the sinusoid x1 and find the values of the signal at given intervals
x1dft = fft(x1);
abs(x1)
[~,index] = sort(abs(x1dft),'descend');
Fs = 4000;
(index(1)*Fs)/(length(x1))-(Fs/length(x1));

%take the Fourier Transform of the sinusoid x2 and find the values of the signal at given intervals
x2dft = fft(x2);
abs(x2)
[~,index] = sort(abs(x2dft),'descend');
Fs = 4000;
(index(1)*Fs)/length(x2)-(Fs/length(x2))

%take the Fourier Transform of the sinusoid x3 and find the values of the signal at given intervals
x3dft = fft(x3);
abs(x3)
[~,index] = sort(abs(x3dft),'descend');
Fs = 4000;
(index(1)*Fs)/length(x3)-(Fs/length(x3))

%% 3.2 Complex Amplitude
tt = -.5 : 0.00999 : .5; %define the time vector to be used to 
x1 = real(20*exp(j*2*pi*4000*tt)); %express the sinusoid in complex-amplitude form

plot(tt,x1); %plot the sinusoid with respect to the time vector
title('Plot of X1');
xlabel('TIME (sec)');