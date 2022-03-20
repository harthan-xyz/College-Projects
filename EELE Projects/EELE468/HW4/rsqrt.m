%% Newton's method block
%  Joshua Harthan
%  EELE 461
%
%   Newton's iteration block
%
%              y_n(3-x*(y_n)^2)
%  y_(n+1) = --------------------
%                    2
%

W = 32;              % Number of Word Bits
F = 16;              % Number of Fractional Bits
n_iterations = 10;   % Number of Newton Iterations

% Set the fixed point math properties
Fm = fimath('RoundingMethod' ,'Floor',...
'OverflowAction' ,'Wrap',...
'ProductMode' ,'SpecifyPrecision',...
'ProductWordLength' ,W,...
'ProductFractionLength' ,F,...
'SumMode' ,'SpecifyPrecision',...
'SumWordLength' ,W,...
'SumFractionLength' ,F);

% Values to be used to generate a random value of x
a = 0;
b = 10;

x_n = (b-a).*rand(1,1) + a;
    
% The input of the system
x = fi(x_n, 0 , W, F, Fm);
x_bits = x.bin;

% The initial guess for the Newton iteration
y0 = fi(1/sqrt(x), 0, W, F, Fm);
y0_bits = y0.bin;

% Write the random values to the input_vectors.txt file
fid_write = fopen('input_vectors.txt','w');
fprintf(fid_write,'%s ', x_bits);
fprintf(fid_write,'%s\n', y0_bits);
fclose(fid_write);

% Run the calculation for the iteration
y0_sq = y0^2;
y0_sq = fi(y0_sq, 0, W, F, Fm);

xy0_sq = x * y0_sq;
xy0_sq = fi(xy0_sq, 0, W, F, Fm);

three = fi(3, 0, W, F, Fm);
threeminus = three - xy0_sq;

y0_times = y0 * threeminus;
y0_times = fi(y0_times, 0, W, F, Fm);

y = (y0_times/2);
y = fi(y, 0, W, F, Fm);

% Print out the value of the output y
y
y.bin



