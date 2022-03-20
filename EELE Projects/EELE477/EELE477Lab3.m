 %% Joshua Harthan
% EELE477 Lab #3
% 4.1 M-file to Generate a Sinusoid

A = 10.^4;
ff = 3 * pi * 10.^6;
phi = -pi/4;
dur = 10.^-6;

one_cos(A,phi,ff,dur);

%% 4.2.3 Testing

syn_sin([0,100,250],[10,14*exp(-pi/3),8*j],10000,0.1,0);

%% 5 Representation of Sinusoids with Complex Exponentials 

syn_sin([25,25,25],[-2,2*exp(-j),2 - 3 *j],10000,.2,0);

hold on
[x,y] = ginput(2);
plot(x,y,'black--');
hold off

hold on
[x,y] = ginput(2);
plot(x,y,'black--');
hold off

hold on
[x,y] = ginput(1);
h1 = text(x,y, 'A = 4.806', 'HorizontalAlignment','center','Color','black', 'FontSize' , 8);
hold off

hold on
[x,y] = ginput(1);
h1 = text(x,y, 'Phase = 0', 'HorizontalAlignment','center','Color','black', 'FontSize' , 8);
hold off

title("x(t)");
xlabel("Time (secs)");
ylabel("Amplitude");

%% 6 Dircetion Finding
% 6.1 Direction Finding with MicroPhones
% (c)
xv = 100;
yr = 100;
fo = 400;
a = 1000;
dur = 5;
tt = 0:1/10000:dur;

t1 = sqrt((-xv^(2)+ yr^(2))/333.333);

x3 = a .* sin(400.*2.*pi.*tt + t1);

syn_sin(fo, x3, 10000, .01, 0);
xlabel("Time (seconds)");
ylabel("Amplitude");
title("x1(t)");

%%
xv = 100;
yr = 100;
d = .4;
fo = 400;
a = 1000;
dur = 5;
tt = 0:1/10000:dur;

t2 = sqrt(((d - xv)^(2)-yr^(2))/333.333);

x4 = a .* sin(400.*2.*pi.*tt + abs(t2));

syn_sin(fo, x4, 10000, .01, 0);
xlabel("Time (seconds)");
ylabel("Amplitude");
title("x2(t)");


