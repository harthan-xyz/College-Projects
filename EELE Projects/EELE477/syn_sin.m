function [xx,tt] = syn_sin(fk, Xk, fs, dur, tstart)
fk = fk(:)';
Xk = Xk(:)';
tt = tstart : 1/fs : dur;
w = fk' .* tt * j * 2 * pi;
s = exp(w);
y = Xk' .* s;
xx = real(sum(y));
plot(tt,xx);
end 