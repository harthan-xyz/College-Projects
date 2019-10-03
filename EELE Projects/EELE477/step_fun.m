function xx = step_fun(n)
xx = 0;   
    for r = 0:1:n
        if r >= 0 && r < 200
            xx = cos(0.5.*pi.*r);
        elseif r >= 200 && r < 400
            xx = 2;
        elseif r >= 400 && r < 600
            xx = 0.5.*cos(0.2.*pi.*r);
        end
    end

end