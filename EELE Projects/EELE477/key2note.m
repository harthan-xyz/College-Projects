function xx = key2note(X, keynum, dur)
fs = 22050;
tt = 0: (1/fs) : dur;
freq = 440 .* 2.^((keynum-49)./12);
xx = real(X.*exp(j.*2.*pi.*freq.*tt));
end