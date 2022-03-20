function [y] = newton_iteration(x, y0, W_bits, F_bits, Fm, n_iterations)

% Check if x is embedded fixed-point
if (isa(x, 'embedded.fi') ~= 1 || isa(y0, 'embedded.fi') ~= 1) 
    x  = fi( x, 0, W_bits, F_bits, Fm);
    y0 = fi(y0, 0, W_bits, F_bits, Fm);
end

% Variable Init
const = [fi(1/2, 0, W_bits, F_bits, Fm) ... % 1/2
         fi(3, 0, W_bits, F_bits, Fm)];     % 3
caseFlag = 0;
if (n_iterations == 1)
    y     = fi(zeros(n_iterations, 1), 0, W_bits, F_bits, Fm);
    for n = 1:n_iterations
        y(n) = const(1) * y0(n) * (const(2) - x(n) * y0(n)^2);
    end
elseif (n_iterations > 1)
    y     = fi(zeros(n_iterations, length(y0)), 0, W_bits, F_bits, Fm);
    for m = 1:length(x)
        for n = 1:n_iterations
            if caseFlag == 0
                y(n, m) = const(1) * y0(n) * (const(2) - x(n) * y0(n)^2);
                caseFlag = 1;
            end % END IF
            y(n, m) = const(1) * y(n-1, m)*(const(2) - x * y(n-1, m)^2);
        end %END INNER FOR
        caseFlag = 0; %Reset flag for next number to iterate through
    end %END OUTER
end %END IF

end % END FCN