%% Joshua Harthan
% EELE477 Lab #8
% 2 Warmup
% 2.1 Synthesize a Test Image
%(a)
xpix = ones(256,1)*cos(2*pi*(0:255)/16);
show_img(xpix);

%(b)
%The ones matrix represents the white and cos represents the black

%(c)
xpix1 = ones(400,1)*cos(2*pi*(0:399)/80);
ypix = xpix1';
show_img(ypix);

%% 2.3 Sampling of Images

load lenna
whos
show_img(xx);

xx2 = xx(1:2:end,1:2:end);

show_img(xx2);

%% 3 Sampling, Aliasing and Reconstruction
% 3.2 Reconstruction of Imgaes
% (a)

load lenna
show_img(xx);

xx3 = xx(1:3:end,1:3:end);

show_img(xx3);

figure();
xr1 = (-2).^(0:6);
L = length(xr1);
nn = ceil((0.999:1:4*L)/4);
xr1hold = xr1(nn);

plot(xr1); hold on
plot(xr1hold);
title("Zero-Order Hold Interpolation");

show_img(xr1hold);
%% 3 Sampling, Aliasing and Reconstruction
% 3.2 Reconstruction of Images
% (b)
load lenna
show_img(xx); 
xx3 = xx(1:3:end,1:3:end);
show_img(xx3);

whos

L = length(xx3);
nn = ceil((0.999:1:3*L)/L);
xholdrows = xr1(nn);
yholdrows = yr1(nn);

show_img(xholdrows);
show_img(yholdrows);


%% 3 Sampling, Aliasing and Reconstruction
% 3.2 Reconstruction of Images
% (d)
n1 = 0:6;
xr1 = (-2).^n1;
tti = 0:0.1:6;
xr1linear = interp1(n1,xr1,tti);
stem(tti,xr1linear);
title("Linear Interpolation of the Signal");

%% 3 Sampling, Aliasing and Reconstruction
% 3.2 Reconstruction of Images
% (e)

load lenna
show_img(xx);

xx3 = xx(1:3:end,1:3:end);

show_img(xx3);

L = length(xx3);
tti = ceil((0.999:1:3*L)/3);

n = 0 : 85;

figure();
xrlinear = interp1(n,xx3,tti);
stem(tti,xrlinear);