clc;
clear;
close all;

%% 1. Read dataset
data = readtable('BC_35.csv');
data = data(:, vartype('numeric'));

X = table2array(data);
varNames = data.Properties.VariableNames;

%% 2. Remove zero variance columns
stdVals = std(X,'omitnan');
validCols = stdVals > 0;

X = X(:, validCols);
varNames = varNames(validCols);

%% 3. Compute Correlations
pearsonCorr = corr(X,'Type','Pearson','Rows','pairwise');
spearmanCorr = corr(X,'Type','Spearman','Rows','pairwise');

colorLimits = [-1 1];

%% 4. Pearson Heatmap
f1 = figure;
h1 = heatmap(varNames,varNames,pearsonCorr);
h1.Title = '24BEE047 - Pearson Correlation Matrix (Linear)';
h1.ColorLimits = colorLimits;
h1.GridVisible = 'on';
colormap(f1, jet);

drawnow;

% Save as JPG (300 DPI)
exportgraphics(f1,'Pearson_Correlation.jpg','Resolution',300);

%% 5. Spearman Heatmap
f2 = figure;
h2 = heatmap(varNames,varNames,spearmanCorr);
h2.Title = '24BEE047 - Spearman Correlation Matrix (Non-Linear)';
h2.ColorLimits = colorLimits;
h2.GridVisible = 'on';
colormap(f2, jet);

drawnow;

% Save as JPG (300 DPI)
exportgraphics(f2,'Spearman_Correlation.jpg','Resolution',300);
