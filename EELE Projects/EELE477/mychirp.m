function [xx,tt] = mychirp(f1,f2,dur,fsamp)
tt = 0 : 1/fsamp : dur;
dt = 1/fsamp;
z = (f2 - f1)./(2.*dur);
psi = 2.*pi.*(tt.*tt.*z + f1.*tt + 0);
xx = real ( 7.7*exp(j*psi));
soundsc(xx,fsamp);
end