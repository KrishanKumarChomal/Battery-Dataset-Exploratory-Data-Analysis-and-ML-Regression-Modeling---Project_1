clc;
clear;
close all;

%% 1. Read Dataset
data = readtable('BC_35.csv');

% Keep only numeric variables
data = data(:, vartype('numeric'));

%% 2. Define Target Variable
Y = data.Tavg;          % Target variable

%% 3. Define Selected Input Features
X = data(:, {'DischargeCurrent','Vact','Ah'});

%% 4. Convert table to numeric matrix (for ML use)
X = table2array(X);

%% 5. Display summary information
disp('Selected Input Features:')
disp({'DischargeCurrent','Vact','Ah'})

disp('Target Variable:')
disp('Tavg')

disp('Size of Input Matrix (Rows x Features):')
disp(size(X))

disp('Size of Target Vector:')
disp(size(Y))

%% 6. Optional: Check correlation with target
corrWithTarget = corr(X, Y, 'Rows','pairwise');

disp('Correlation of Inputs with Target (Tavg):')
disp(corrWithTarget)
