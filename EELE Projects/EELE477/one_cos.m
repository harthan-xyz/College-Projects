function [xx,tt] = one_cos(A, phi, ff , dur)
tt = 0 : 1/(20*ff) : dur;
xx = A * cos(ff*tt + phi);
plot(tt,xx);
end
