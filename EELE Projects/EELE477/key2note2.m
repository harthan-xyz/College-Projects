function xx = key2note2(X, keynum, dur)
fs = 11025;
ts = 1/fs;
tt = 0: ts : dur;
A = linspace(0, .9, (X*0.2)); %rise 20% of signal
D = linspace(0.9, 0.8,(X*0.05)); %drop of 5% of signal
S = linspace(0.8, 0.8,(X*0.4)); %delay of 40% of signal
R = linspace(0.8, 0,(X*0.35)); %drop of 35% of signal
freq = 440 .* 2.^((keynum-49)./12);
E = [A D S R]; %concatenate the vectors to create an envelope
a = X.*cos(2.*pi.*freq.*tt+(-pi/3)); %create three sinusoids at different frequencies for harmony
b = X.*cos(2.*pi.*2.*freq.*tt+(-pi/3));
c = X.*cos(2.*pi.*-2.*freq.*tt+(-pi/3));
xx = a + b + c;
end