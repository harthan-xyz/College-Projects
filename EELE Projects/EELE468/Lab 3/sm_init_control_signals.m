function mp = sm_init_control_signals(mp)
%% Create left gain control signal
mp.register(1).name     = 'Left_Gain';  % control signal name
mp.register(1).value    =  1.0;         % value control signal will take during simulation
mp.register(1).min      =    0;         % The minimum value the control signal will ever take
mp.register(1).max      =  1.0;         % The maximum value the control signal will ever take
mp.register(1).default  =  0.3;         % default (initial) value
mp.register(1).widget_type          = 'slider';
mp.register(1).widget_display_units = 'dB';

%% Create right gain control signal
mp.register(2).name     = 'Right_Gain'; % control signal name
mp.register(2).value    =  1.0;         % value control signal will take during simulation
mp.register(2).min      =    0;         % The minimum value the control signal will ever take
mp.register(2).max      =  1.0;         % The maximum value the control signal will ever take
mp.register(2).default  =  0.3;         % default (initial) value
mp.register(2).widget_type          = 'slider';
mp.register(2).widget_display_units = 'dB';

%% Any other register control signals should be created in a similar manner

%% conver to time series data
for i=1:lenght(mp.register)
    mp.register(i).timeseries = timeseries(mp.register(i).value,0); % timeseries(datavals, timevals)
end