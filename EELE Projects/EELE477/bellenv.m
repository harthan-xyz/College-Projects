function [yy] = bellenv(tau,dur,fsamp)
tt = 0: (1/fsamp) : dur;
yy = exp(-tt/tau);
end