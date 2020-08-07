% === INPUT ===
pathData = 'D:\germanStudyData\Quantifications\postICA_Ep\CHANNEL_REAL_NAMES_28-May-2020_01-59-29_allTrials_Channel\BackupOriginals';
chanListScript = 'D:\Gits\SO_Spindle_Detection_Coupling\channel_list_128_Channel_HCGSN58.m';
% = END INPUT =

dataFiles = dir(pathData);
dataFiles = dataFiles(contains({dataFiles.name}, '01-59-29.mat'));

% This script will give us the channel label arrays (generic and real)
run(chanListScript)

clearvars -except dataFiles get_names get_names_generic pathData ...
    chanListScript

savePath = strcat(cd, filesep, 'CorrectedLabels', filesep);
if ~exist('savePath', 'dir')
    mkdir(savePath)
end

for i_file = 1 : numel(dataFiles)
    
    fprintf('<!> File %d of %d\n', i_file, numel(dataFiles))
   
    load(strcat(dataFiles(i_file).folder, filesep, ...
        dataFiles(i_file).name));
    
    % Find channel that has really been computed in this file (generic
    % names are correct)
    pos_generic_CORRECT = find(strcmp(...
        get_names_generic, Info.LabelSpindle));
    
    % Replace the real channel name based on the generic one
    Info.NameSpindle = char(get_names(pos_generic_CORRECT));
    
    Info.Channels = get_names;
    
    save(strcat(savePath, dataFiles(i_file).name), ...
        'Info', 'OverallSlowOsc', 'OverallSpindles', ...
        'PhaseLockedSpindleDensity', 'PhaseLockedSpindlePower')
    
end

