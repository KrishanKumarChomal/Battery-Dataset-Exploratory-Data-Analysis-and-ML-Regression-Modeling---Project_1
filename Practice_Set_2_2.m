%% Task 2 - Graphical Analysis (Final Strict Formatting)

clc;
clear;
close all;

% Step 1: Read dataset
data = readtable('BC_35.csv');

% Step 2: Keep only numeric variables
numericData = data(:, varfun(@isnumeric, data, 'OutputFormat', 'uniform'));

% Step 3: Loop through each numeric variable
for i = 1:width(numericData)
    
    variableName = numericData.Properties.VariableNames{i};
    x = numericData{:, i};
    
    % Remove NaN values
    x = x(~isnan(x));
    
    % Compute statistics
    MeanVal = mean(x);
    StdVal  = std(x);
    MinVal  = min(x);
    MaxVal  = max(x);
    
    if StdVal == 0
        SkewVal = 0;
        KurtVal = 0;
    else
        SkewVal = skewness(x);
        KurtVal = kurtosis(x);
    end
    
    % -------- Create Figure --------
    figure;
    
    % Set ONLY graph area white
    ax = gca;
    ax.Color = 'white';          % Graph background white
    
    % Make axis lines and tick values black
    ax.XColor = 'black';
    ax.YColor = 'black';
    
    % Make grid lines black
    ax.GridColor = 'black';
    ax.GridAlpha = 0.4;          % Visible but clean
    ax.MinorGridColor = 'black';
    
    % -------- Plot Histogram --------
    histogram(x, 'BinMethod','fd', ...
        'FaceColor',[0.4 0.7 0.9], ...
        'EdgeColor','black');
    
    grid on;
    box on;
    
    % -------- Axis Labels (Black) --------
    xlabel(variableName, ...
        'FontSize',11, ...
        'FontWeight','bold', ...
        'Color','black');
    
    ylabel('Frequency', ...
        'FontSize',11, ...
        'FontWeight','bold', ...
        'Color','black');
    
    % Ensure tick labels are black
    set(gca, 'XColor','black', 'YColor','black');
    
    % -------- Statistical Information Box --------
    statsText = {
        ['Mean: ', num2str(MeanVal,'%.4f')]
        ['Std Dev: ', num2str(StdVal,'%.4f')]
        ['Min: ', num2str(MinVal,'%.4f')]
        ['Max: ', num2str(MaxVal,'%.4f')]
        ['Skewness: ', num2str(SkewVal,'%.4f')]
        ['Kurtosis: ', num2str(KurtVal,'%.4f')]
        };
    
    annotation('textbox',[0.63 0.60 0.30 0.30], ...
        'String',statsText, ...
        'FitBoxToText','on', ...
        'BackgroundColor','white', ...
        'EdgeColor','black', ...
        'Color','black', ...
        'FontSize',10);
    
end
