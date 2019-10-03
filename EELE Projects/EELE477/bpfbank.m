function hh = bpfbank(xx,L,w)
n = 0:1:(L-1);

a = max(xx);

B = 1/a;

hh = B.*(0.54 - 0.46.*cos((2.*pi.*n)./(L-1))).*cos(w.*(n-(L-1)./2));

HH = freqz(hh);
hold on
plot(abs(HH)); 
axis([0 500 0 30]);
ylabel("Magnitude");

end