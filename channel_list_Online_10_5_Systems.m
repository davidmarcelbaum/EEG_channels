% |===USER INPUT===|
chan_Mastoids       = {'E57', 'E100'};
chan_EOG            = {'E8', 'E14', 'E21', 'E25', 'E126', 'E127'};
chan_EMG            = {'E43', 'E120'};
chan_VREF           = {'E129'};
chan_Face           = {'E49', 'E48', 'E17', 'E128', 'E32', 'E1', ...
                        'E125', 'E119', 'E113'};
% |=END USER INPUT=| 


% [    1,    2,    3,    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,   20, 
A={ 'E1','NaN','NaN','NaN','NaN','NaN','NaN','NaN','Fp2','NaN', 'Fz','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN'};

%     21,   22,   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,   40, 
B={'NaN', 'Fp1','NaN','F3','NaN','NaN','NaN','NaN','NaN','NaN','E31','NaN', 'F7','NaN','NaN', 'C3','E37','NaN','NaN','NaN'};

%     41,   42,   43,   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,   56,   57,   58,   59,   60, 
C={'NaN','NaN','E43','NaN', 'T3','NaN','NaN','NaN','NaN','NaN','NaN', 'P3','E53','E54','E55','NaN', 'LM', 'T5','NaN','E60'};

%     61,   62,   63,   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,   76,   77,   78,   79,   80, 
D={'E61', 'Pz','NaN','NaN','NaN','NaN','E67','NaN','NaN', 'O1','NaN','E72','NaN','NaN', 'Oz','NaN','E77','E78','E79','E80'};

%     81,   82,   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
E={'NaN','NaN', 'O2','NaN','E85','E86','E87','NaN','NaN','NaN','NaN', 'P4','NaN','NaN','NaN', 'T6','NaN','NaN','NaN', 'RM'};

%    101,  102,  103,  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
F={'NaN','NaN','NaN', 'C4','NaN','NaN','NaN', 'T4','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN'};

%    121,  122,  123,  124,  125,  126,  127,  128]
G={'NaN', 'F8','NaN', 'F4','NaN','NaN','NaN','NaN'};

c_chans = [A, B, C, D, E, F, G];

clear A B C D E F G

c_chan_generic = cell(numel(c_chans), 1);
for s_chan = 1 : numel(c_chans)
    c_chan_generic(s_chan) = {strcat('E', num2str(s_chan))};
end

chans2Rej   = [chan_Mastoids, chan_EOG, chan_EMG, chan_Face, chan_VREF];

for i = 1 : numel(chans2Rej)
    s_found = find(strcmp( ...
        c_chan_generic, char(chans2Rej(i))));
    
    if ~isempty(s_found)
        idx_rej(i) = s_found;
    end
end

get_chans = find(~strcmp(c_chans,'NaN'));
get_chans(ismember(get_chans,idx_rej)) = [];

get_names = c_chans(get_chans);