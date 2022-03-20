function mp = sm_init_control_signals(mp)
%% Signal Energy Monitor Control Signals
% Max_Reset_Threshold control signal
max_counter_time        = 5; % time in seconds
mp.max_reset_Nbits      = ceil(log2(max_counter_time*mp.Fs)); % determine size of counter
max_reset_time          = 300; % msec
max_reset_threshold     = ceil(max_reset_time/1000 *mp.Fs);   % reset time in number of samples
mp.register(1).value    = max_reset_threshold;

% LED Persistence control signal
mp.LED_persistence_Nbits = 15;
LED_persistence_time = 100; % msec
LED_persistence = ceil(LED_persistence_time/1000 * mp.Fs);    % LED_persistence in number of samples
mp.register(2).value = LED_persistence;

%% convert to time series data
for i=1:length(mp.register)
    mp.register(i).timeseries = timeseries(mp.register(i).value,0); % timeseries(datavals, timevals)
end