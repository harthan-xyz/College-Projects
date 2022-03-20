function yesno = hear_sinus(amplitude,frequency,duration,samplingRate)
%
%yesno = true or false. True when the sound is heard
%
tt = 0:1/samplingRate:duration;
xx = amplitude*cos(2*pi*frequency*tt + rand(1)*2*pi);
sound(xx,samplingRate)
pause(duration) %-- wait for the sound to end
aa = input('Can you hear me now? (n = no, y = yes) ' , 's')
yesno = length(aa)>0;
if yesno
    yesno = upper(aa(1))=='Y';
end