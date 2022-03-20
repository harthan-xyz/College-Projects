function[xx,tt] = beat(A,B,fc,delf,fsamp,dur)
dt = 1/fsamp;
tt = 0 : dt : dur;
xx = A.*cos(2.*pi.*(fc - delf).*tt) + B.*cos(2.*pi.*(fc + delf).*tt);
plot(tt,xx);
end
