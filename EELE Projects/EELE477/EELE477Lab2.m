%% Joshua Harthan
% EELE477 Lab #2
% 3.1 Complex Numbers
% (a)

z1 = 10*exp(-j*(2*pi)/3);
z2 = -5 + j*5;

hold on
zvect(z1);
zprint(z1);
hold off

hold on
zvect(z2);
zprint(z2);
hold off

hold on, zcoords,ucplot, hold off;

%% 3.1 Complex Numbers
% (b)
zcat([j, -1, -2j,1]);

%% 3.1 Complex Numbers
% (c)
z1 = 10*exp(-j*(2*pi)/3);
z2 = -5 + j*5;
z3 = z1 + z2;

zvect(z3);

hold on
zcat([z1, z2]);
hold off

zprint(z1);
zprint(z2);
zprint(z3);


%% 3.1 Complex Numbers
% (d)
z1 = 10*exp(-j*(2*pi)/3);
z2 = -5 + j*5;
z3 = z1 * z2;

zvect(z3);

hold on
zvect(z1);
zprint(z1);
hold off

hold on
zvect(z2);
zprint(z2);
hold off

zprint(z1);
zprint(z2);
zprint(z3);

%% 3.1 Complex Numbers
% (e)
z1 = 10*exp(-j*(2*pi)/3);
z2 = -5 + j*5;
z3 = z1 / z2;

zvect(z3);

hold on
zvect(z1);
zprint(z1);
hold off

hold on
zvect(z2);
zprint(z2);
hold off

zprint(z1);
zprint(z2);
zprint(z3);

%% 3.1 Complex Numbers
% (f)
z1 = 10*exp(-j*(2*pi)/3);
z2 = -5 + j*5;

zprint(z1);
zprint(z2);

zprint(conj(z1));
zprint(conj(z2));

%% 3.1 Complex Numbers
% (g)
z1 = 10*exp(-j*(2*pi)/3);
z2 = -5 + j*5;
z3 = 1/z1;
z4 = 1/z2;

hold on
zvect(z3);
zprint(z3);
hold off

hold on
zvect(z4);
zprint(z4);
hold off

zprint(z1);
zprint(z2);
zprint(z3);
zprint(z4);

%% 3.1 Complex Numbers
% (h)
z1 = 10*exp(-j*(2*pi)/3);
z2 = -5 + j*5;
z3 = conj(z1);
z4 = conj(z2);
z5 = 1/z1;
z6 = 1/z2;
z7 = z1 * z2;

hold on
zvect(z1);
zprint(z1);
hold off

hold on
zvect(z2);
zprint(z2);
hold off

hold on
zvect(z3);
zprint(z3);
hold off

hold on
zvect(z4);
zprint(z4);
hold off

hold on
zvect(z5);
zprint(z5);
hold off

hold on
zvect(z6);
zprint(z6);
hold off

hold on
zvect(z7);
zprint(z7);
hold off

hold on, zcoords,ucplot, hold off;

%% 3.3 Vectorization
% For loop

M = 200;
for k=1:M
    x(k) = k;
    y(k) = cos(0.001*pi*x(k)*x(k));
end
plot(x,y,'ro-');

%% 3.3 Vectorization
% For loop replacement

M = 200;
y = cos(0.001*pi*(1:M).*(1:M));
plot(1:M, y, 'ro-');

%%  3.3 Vectorization
% Weird signal
N = 200;
for k = 1:N
    xk(k) = k/50;
    rk(k) = sqrt(xk(k)*xk(k) + 2.25);
    sig(k) = exp(j*2*pi*rk(k));
end
plot(xk, real(sig), 'mo-');

%% 3.3 Vectorization
% Weird signal for loop replacement
N = 200;
rk = exp(j*2*pi*sqrt((1:N)/50.*(1:N)/50 + 2.25));
plot((1:N)/50 , real(rk), 'mo-');

%% 3.4 Functions
%
ff = 55*pi;
dur = .025;

goodcos(ff,dur);

%% 4 Warmup Complex Exponentials
% 4.1 M-file to Generate a Sinusoid

A = 95;
ff = 200*pi;
dur = .025;
phi = pi/5;

one_cos(A,phi,ff,dur);

%% 4.2.3 Testing

syn_sin([0,100,250],[10,14*exp(-j*pi/3),8*j],10000,0.1,0);


%% 5 Representation of Sinusoids with Complex Exponentials
% (a)

syn_sin([1/2,1/2,1/2],[2,2*exp(-j*1.25),1 - j],10000,6,0);

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
h1 = text(x,y, 'A = 4.645', 'HorizontalAlignment','center','Color','black', 'FontSize' , 8);
hold off

hold on
[x,y] = ginput(1);
h1 = text(x,y, 'Phase = 3.142', 'HorizontalAlignment','center','Color','black', 'FontSize' , 8);
hold off

title("x(t)");
xlabel("Time (secs)");
ylabel("Amplitude");




