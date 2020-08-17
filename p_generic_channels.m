% |===USER INPUT===|
chan_Mastoids       = {'E57', 'E100'};
chan_EOG            = {'E8', 'E14', 'E21', 'E25', 'E126', 'E127'};
chan_EMG            = {'E43', 'E120'};
chan_VREF           = {'E129'};
chan_Face           = {'E49', 'E48', 'E17', 'E128', 'E32', 'E1', ...
                        'E125', 'E119', 'E113'};
% |=END USER INPUT=|

c_chans2skip = [chan_Mastoids, chan_EOG, chan_EMG, chan_VREF, chan_Face];


i = 0;
for i_chan = 1:129
    if ~ismember(strcat('E', num2str(i_chan)), c_chans2skip)
        i = i + 1;
        ROIs.str_chans(i, 1) = {strcat('E', num2str(i_chan))};
    end
end