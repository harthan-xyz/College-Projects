 %% Joshua Harthan
% EELE477 Lab #5
% 3 Warm-up
% 3.1 Note Frequency Function

soundsc(key2note(7*exp(j*(-pi/2)), 40, 1) , 11025);

%% 3.2 Synthesize a Scale

scale.keys = [40 42 44 45 47 49 51 52];
%NOTES: C D E F G A B C

scale.durations = 0.25 .* ones(1,length(scale.keys));
fs = 11025;
xx = zeros (1, sum(scale.durations).*fs+length(scale.keys));
n1 = 1;
for kk = 1:length(scale.keys)
    keynum = scale.keys(kk);
    
    tone = key2note(7*exp(j*(-pi/2)), keynum, scale.durations(kk));
    
    n2 = n1 + length(tone) - 1;
    xx(n1:n2) = xx(n1:n2) + tone;
    n1 = n2 + 1;
end
soundsc ( xx, fs );

%% 3.3 Spectrogram : Two M-files

% (a)
scale.keys = [40 42 44 45 47 49 51 52];
%NOTES: C D E F G A B C

scale.durations = 0.25 .* ones(1,length(scale.keys));
fs = 11025;
xx = zeros (1, sum(scale.durations).*fs+length(scale.keys));
n1 = 1;
for kk = 1:length(scale.keys)
    keynum = scale.keys(kk);
    
    tone = key2note(7*exp(j*(-pi/2)), keynum, scale.durations(kk));
    
    n2 = n1 + length(tone) - 1;
    xx(n1:n2) = xx(n1:n2) + tone;
    n1 = n2 + 1;
end

% (b)
spectrogram(xx,512,[],512,fs,'yaxis');
zoom on;

%% 4 Synthesis of Musical Notes
% 4.3 Data Files for Notes
load bach_fugue.mat
whos
length(theVoices)
length(theVoices(1).startPulses)
length(theVoices(2).startPulses)
length(theVoices(3).startPulses)

% for n = [1:length(theVoices(1).startPulses)]
%     soundsc(key2note(theVoices(1).startPulses(n), theVoices(1).noteNumbers(n),theVoices(1).durations(n)),11025);
%     pause(length(theVoices(1).durations(n)));
% end
% for n = [1:length(theVoices(2).startPulses)]
%     soundsc(key2note(theVoices(2).startPulses(n), theVoices(2).noteNumbers(n),theVoices(2).durations(n)),11025);
%     pause(length(theVoices(2).durations(n)));
% end
% for n = [1:length(theVoices(3).startPulses)]
%     soundsc(key2note(theVoices(3).startPulses(n), theVoices(3).noteNumbers(n),theVoices(3).durations),11025);
%     pause(length(theVoices(3).durations(n)));
% end

%% 4 Synthesis of Musical Notes
% 4.4 Musical Tweaks
bpm = 120;
beats_per_second = bpm/60;
seconds_per_beat = 1/beats_per_second;
seconds_per_pulse = seconds_per_beat/4;

load bach_fugue.mat

% fs = 11025;
% theVoices(1).durations(1:123) = 0.25 .* ones(1,length(theVoices(1).noteNumbers(1:123)));
% xx = zeros (1, sum(length(theVoices(1).startPulses(1:123).*fs+length(theVoices(1).noteNumbers(1:123)))));
% n1 = 1;
%      for kk = 1:length(theVoices(1).noteNumbers(1:123))
%      keynum = theVoices(1).noteNumbers(kk);
%      
%      tone = key2note(1, keynum , theVoices(1).durations(kk));
%     
%      n2 = n1 + theVoices(1).startPulses(kk) - 1;
%      xx(n1:n2) = xx(n1:n2) + tone;
%      n1 = n2 + 1;
%      end
% soundsc ( xx, fs );

for n = [1:length(theVoices(1).startPulses)+length(theVoices(2).startPulses)+length(theVoices(3).startPulses)]
    for m = [1:length(theVoices)]
    soundsc(key2note2(theVoices(1).startPulses(n) * seconds_per_pulse, theVoices(1).noteNumbers(n),theVoices(1).durations * seconds_per_beat),11025);
    soundsc(key2note2(theVoices(2).startPulses(n) * seconds_per_pulse, theVoices(2).noteNumbers(n),theVoices(2).durations * seconds_per_beat),11025);
    soundsc(key2note2(theVoices(3).startPulses(n) * seconds_per_pulse, theVoices(3).noteNumbers(n),theVoices(3).durations * seconds_per_beat),11025);
    pause(.4);
    end
end
