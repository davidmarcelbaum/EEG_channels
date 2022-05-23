%% =-=-=-=-=-=-=-=-=-=-=-=-=   U s e r l a n d   =-=-==-=-=-=-=-=-=-=-=-=-=

load('fieldtrip_chanlocs.mat')

nghb_method     = 'distance'; % {'triangulation', 'distance'}
% Both methods seem to find appropriate clusters. However, triangulation
% takes into account "neighbours" that are very distant to some channels
% especially on the side of the head where channel density is low or at the
% edge of the head (see E2 for example). Clusters found by triangulation
% also are more variable in shape whereas distance finds circular shaped 
% ones.

neighbourdist   = 3.5; % An integer number (what unit are these???)


%% =-=-=-=-=-=-=-=-=-=-=-=-=-=-=   C o r e   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


%% Find neighbours
cfg_neighb.method           = nghb_method;
cfg_neighb.neighbourdist    = neighbourdist;
cfg_neighb.channel          = 'all';
cfg_neighb.elec             = sensors;
neighbours                  = ft_prepare_neighbours(cfg_neighb);
allChans                    = {neighbours.label};


%% Prepare output
saveFolder = strcat(cd, filesep, nghb_method);
if ~exist(saveFolder, 'dir')
    mkdir(saveFolder)
end


for i_nb = 1:numel(allChans)

    
    close all
    figure('units','normalized','outerposition', [0 0 1 0.5]);
    
    
    %% Define center channel of interest and its neighbours
    currChan        = allChans(i_nb);
    currNghb        = neighbours(i_nb).neighblabel;
    
    % Locate channels of interest
    idxChan         = find(strcmp(sensors.label, currChan));
    idxNghb         = zeros(1, numel(currNghb));
    for i = 1:numel(currNghb)
        idxNghb(i)  = find(strcmp(sensors.label, currNghb(i)));
    end
    
    
    %% Extract positions of channels of interest
    posChan.X       = [sensors.chanpos(idxChan, 1)];
    posChan.Y       = [sensors.chanpos(idxChan, 2)];
    posChan.Z       = [sensors.chanpos(idxChan, 3)];
    
    posNghb.X       = [sensors.chanpos(idxNghb, 1)];
    posNghb.Y       = [sensors.chanpos(idxNghb, 2)];
    posNghb.Z       = [sensors.chanpos(idxNghb, 3)];
    
    
    %% Plot different views of center channel and its neighbours
    subplot(1, 3, 1);
    % Top down view
    plot(sensors.chanpos(:, 1), sensors.chanpos(:, 2),...
        '.', ...
        'MarkerFaceColor', [0.75 0.75 0.75], ...
        'MarkerEdgeColor', [0 0 0]);
    hold on
    plot([posChan.X], [posChan.Y],...
        'o', ...
        'MarkerFaceColor', [1 0 0], ...
        'MarkerEdgeColor', [1 0 0]);
    plot([posNghb.X], [posNghb.Y],...
        'o', ...
        'MarkerFaceColor', [0 0 1], ...
        'MarkerEdgeColor', [0 0 1]);
    text([posChan.X], [posChan.Y], ...
        currChan, ...
        'Color', [1 0 0])
    text([posNghb.X], [posNghb.Y], ...
        currNghb, ...
        'Color', [0 0 1])
    title('Top down (nose right)')
    xlabel('X (back-front)')
    ylabel('Y (right-left)')
    
    subplot(1, 3, 2);
    % Right side view
    plot(sensors.chanpos(:, 1), sensors.chanpos(:, 3),...
        '.', ...
        'MarkerFaceColor', [0.75 0.75 0.75], ...
        'MarkerEdgeColor', [0 0 0]);
    hold on
    plot([posChan.X], [posChan.Z],...
        'o', ...
        'MarkerFaceColor', [1 0 0], ...
        'MarkerEdgeColor', [1 0 0]);
    plot([posNghb.X], [posNghb.Z],...
        'o', ...
        'MarkerFaceColor', [0 0 1], ...
        'MarkerEdgeColor', [0 0 1]);
    text([posChan.X], [posChan.Z], ...
        currChan, ...
        'Color', [1 0 0])
    text([posNghb.X], [posNghb.Z], ...
        currNghb, ...
        'Color', [0 0 1])
    title('Right profile (nose right)')
    xlabel('X (back-front)')
    ylabel('Z (down-up)')
    
    subplot(1, 3, 3);
    % From behind view
    plot(sensors.chanpos(:, 2), sensors.chanpos(:, 3),...
        '.', ...
        'MarkerFaceColor', [0.75 0.75 0.75], ...
        'MarkerEdgeColor', [0 0 0]);
    hold on
    plot([posChan.Y], [posChan.Z],...
        'o', ...
        'MarkerFaceColor', [1 0 0], ...
        'MarkerEdgeColor', [1 0 0]);
    plot([posNghb.Y], [posNghb.Z],...
        'o', ...
        'MarkerFaceColor', [0 0 1], ...
        'MarkerEdgeColor', [0 0 1]);
    text([posChan.Y], [posChan.Z], ...
        currChan, ...
        'Color', [1 0 0])
    text([posNghb.Y], [posNghb.Z], ...
        currNghb, ...
        'Color', [0 0 1])
    title('From behind (nose behind)')
    xlabel('Y (left-right)')
    ylabel('Z (down-up)')
    
    
    %% Save the figure
    saveas(gcf,strcat(saveFolder, filesep, char(currChan),'.png'))
    
end
close all
