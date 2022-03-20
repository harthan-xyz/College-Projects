function [xx] = bell(fc,fm, Io, tau, dur, fsamp)
tt = 0 : (1/fsamp) : dur;
amp = bellenv(tau,dur,fsamp);
xx = amp .* cos(2.*pi.*fc.*tt + Io .* cos(2.*pi.*fm.*tt + (-pi./2)) + (-pi/2));
end