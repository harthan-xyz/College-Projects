%% Joshua Harthan
% EELE477 Lab #9
% 2 Warmup
% 2.1 Sampling and Alias
%(a)

con2dis();

%% 2.2 Discrete-Time Convolution
%(a)

dconvdemo();
%% 2.3 Loading Data 

load lab6dat
whos


%% 2.4 Filtering a Signal

load lab6dat
bb = 1/5*ones(1,5);
y1 = firfilt(bb,x1);

nn = 1:30;
subplot(2,1,1);
stem(nn,x1(nn))
subplot(2,1,2);
stem(nn,y1(nn),'filled')
xlabel('Time Index (n)')


%% 2.5 Filtering Images : 2-D Convolution

load echart.mat
whos

bdiffh = [1,-1];
yy1 = conv2(echart,bdiffh);
show_img(echart);
show_img(yy1);

yy2 = conv2(echart,bdiffh');
show_img(yy2);

%% 3 Lab Exercises: FIR Filters
%3.1 Deconvolutin Experiment for 1-D Filters

xx = 256*(rem(0:100,50)<10);
bb = [1 .9];

ww = firfilt(bb,xx);

length(xx)
length(ww)

figure();
nn = 1:75;
subplot(2,1,1);
stem(nn,xx(nn));
title("Plot of x[n]");
subplot(2,1,2);
stem(nn,ww(nn),'filled');
title("Plot of w[n]");

figure();
subplot(2,1,1);
plot(xx);
title("Plot of x(t)");
subplot(2,1,2);
plot(ww);
title("Plot of w(t)");


%% 3 Lab Exercises: FIR Filters 
%3.1.1 Restoration Filter

%(a)
xx = 256*(rem(0:100,50)<10);
bb = [1 .9];

ww = firfilt(bb,xx);
delayed_signal = [zeros(1,22) xx];
syms k 
yy = symsum(.9 .^k .* delayed_signal, k , 0, 22);

figure();
nn = 1:50;
subplot(3,1,1);
stem(nn,xx(nn));
title("Plot of x[n]");
subplot(3,1,2);
stem(nn,ww(nn),'square');
title("Plot of w[n]");
subplot(3,1,3);
stem(nn,yy(nn),'filled');
title("Plot of y[n]");
xlabel('Time Index (n)');

%(b) 
figure();
subplot(3,1,1);
plot(xx);
title("Plot of x(t)");
subplot(3,1,2);
plot(ww);
title("Plot of w(t)");
subplot(3,1,3);
plot(yy);
title("Plot of y(t)");

%(c)
diff = xx(nn) - yy(nn);
figure();
plot(diff);
title("Difference plot from 1:50");

%3.1.2 Worst-Case Error
%(a)
max(diff)

%% 3 Lab Exercises
%3.1.3 An Echo Filter
fs = 8000;
r = .9;
p = .2;

load lab6dat
whos

soundsc(x2,fs);

pause(2.5);

bb = x2 + r.*(x2 - p);
xx = firfilt(x2,bb);

length(xx)
length(bb)

soundsc(xx,fs);

%% 3 Lab Exercises
%3.2 Cascading Two Systems
%3.2.1 OVerall Impulse Response

%(a)
r = .93;
q = .93;

%(c)
echartrow = size(1,256);

bb = [1 q]; 

delayed_signal = [zeros(1,22) echartrow];
syms k 
yy = symsum(r .^k .* delayed_signal, k , 0, 22);


m = 22;
xx = firfilt(echart(m,:), bb);
yy1 = firfilt(echart(m,:), yy(m));

figure()
subplot(2,1,1);
stem(xx)
title("H1[n]");
subplot(2,1,2);
stem(yy1,'filled')
title("H2[n]");

%3.2.2 Distorting and Restoring Images
%(a)
load echart.mat
show_img(echart);

%(b)
echartrow = size(1,256);

bb = [1 q]; 

m = 22;

delayed_signal = [zeros(1,22) echartrow];
syms k
yy = symsum(r .^(k) .* delayed_signal, k , 0, m);

rows = firfilt(echart(m,:), bb);
columns = firfilt(echart(m',:), bb);

ech90 = [rows ; columns]; 

show_img(ech90);

deconrows = firfilt(ech90(m,:), yy);
deconcolumns = firfilt(ech90(m',:), yy);

decon = [deconrows ; deconcolumns];

show_img(decon);

%3.2.3 A Second Restoration Experiment
% (a)

