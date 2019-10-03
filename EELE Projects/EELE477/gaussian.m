function xx = gaussian(fc,var,f)
xx = exp(-((log2(f)-log2(fc)).^(2))./(2.*var.^(2)));
end