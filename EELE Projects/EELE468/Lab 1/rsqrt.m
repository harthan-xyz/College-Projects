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

% The input of the system
x1 = fi(4, 0 , W, F, Fm);
x2 = fi(16, 0 , W, F, Fm);
x3 = fi(1, 0 , W, F, Fm);
x  = fi(100*rand(4997,1), 0 , W, F, Fm);
y0 = fi(1./sqrt(x),0, W, F, Fm);
y1 = fi(1./sqrt(x1), 0, W, F, Fm);
y2 = fi(1./sqrt(x2), 0, W, F, Fm);
y3 = fi(1./sqrt(x3), 0, W, F, Fm);

% Write the random values to the input_vectors.txt file
fid_write_X = fopen('input_vectors.txt','w');
fprintf(fid_write_X,'%s\n', bin(x1));
fprintf(fid_write_X,'%s\n', bin(x2));
fprintf(fid_write_X,'%s\n', bin(x3));
for i = 1:4997
    fprintf(fid_write_X,'%s\n', bin(x(i)));
end
fclose(fid_write_X);

% Run the calculation for the iteration
y0_sq = y0.^2;
y0_sq = fi(y0_sq, 0, W, F, Fm);

xy0_sq = x .* y0_sq;
xy0_sq = fi(xy0_sq, 0, W, F, Fm);

three = fi(3, 0, W, F, Fm);
threeminus = three - xy0_sq;

y0_times = y0 .* threeminus;
y0_times = fi(y0_times, 0, W, F, Fm);

y = (y0_times./2);
y = fi(y, 0, W, F, Fm);
y_bits = y.bin

% Write the output of the script to the output_values_ML.txt file
fid_write_Y = fopen('output_results_ML.txt','w');
    fprintf(fid_write_X,'%s\n', bin(y1));
    fprintf(fid_write_X,'%s\n', bin(y2));
    fprintf(fid_write_X,'%s\n', bin(y3));
for i = 1:4997
    fprintf(fid_write_Y,'%s\n', bin(y(i)));
end
fclose(fid_write_Y);

% Compare the outputs of Modelsim and Matlab
fid_read_MS = fopen('output_results.txt','r');
fid_read_ML = fopen('output_results_ML.txt','r');
MLfi = fi(0,0,W,F,Fm);
MSfi = fi(0,0,W,F,Fm);
correct = 0;
incorrect = 0;
for i = 1:5000
    ML = fgetl(fid_read_MS);
    MS = fgetl(fid_read_ML);
    MLfi = ML;
    MSfi = MS;
    if MLfi == MSfi
        correct = correct + 1;
    else
        incorrect = incorrect + 1;
    end
end 
correct
incorrect
fclose('all');


