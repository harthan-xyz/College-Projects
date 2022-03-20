%% Joshua Harthan
% EELE477 Lab #10
% 2 Warmup
% 2.1 Discrete-Time Convolution


load dconvdemo.m
dconvdemo();

%% 2.2 Filtering Images via Convolution

load echart.mat

m = 65;
bdiffh = [1,-1];
yy1 = conv(echart(m,:), bdiffh);

figure()
subplot(2,1,1);
stem(echart(m,:))
title("Stem Plot of echart");
subplot(2,1,2);
stem(yy1,'filled')
title("Stem Plot of yy1");

show_img(echart);

%% 3 FIR Filtering of Images
% 3.1.1 Edge Detection and Location via 1-D Filters
% (a)

xx = 255*(rem(1:159,30)>19);
bb = [1, -1];

yy = firfilt(xx,bb);

nn = 1:75;

figure();
subplot(2,1,1);
stem(nn,xx(nn));
title("Plot of x[n]");
subplot(2,1,2);
stem(nn,yy(nn));
title("Plot of y[n]");

%(c)
length(xx)
length(yy)

%(d)
if (abs(xx) >= 255)
    yy = 1;
elseif(abs(xx) < 255)
    yy = 0;
end

%(e)
aa = find(yy > 0);

figure();
stem(aa,yy(aa));

length(aa)

%% 3 FIR Filtering of Images
% 3.2 Bar Code Detection and Decoding
% 3.2.1 Decode the UPC from a Scanned Image
% (a)
A = imread('HP110v3.png');
size(A)

m = 60;

xn = conv(A(m,:), bb);

% (b)
bb = [1, -1];

yn = firfilt(xn,bb);

nn = 1:60;

figure();
subplot(2,1,1);
stem(nn,xn(nn));
title("Plot of x[n]");
subplot(2,1,2);
stem(nn,yn(nn));
title("Plot of y[n]");

% (c)
if (abs(yn) >= 254)
   yn(nn) = 1;
elseif (abs(yn) < 254)
   yn(nn) = 0;
end

ln = find(yn > 0);
length(ln)

% (d)
aa = 1:59;
deln = firfilt(ln,bb);
length(deln)

figure();
subplot(2,1,1);
stem(aa,ln(aa));
title("Plot of l[n]");
subplot(2,1,2);
stem(aa,deln(aa));
title("Plot of delta[n]");

% (h)
decodeUPC(deln);


