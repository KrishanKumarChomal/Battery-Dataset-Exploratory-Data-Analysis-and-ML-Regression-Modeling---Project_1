%% Task 1 - Statistical Analysis of Variables

% Step 1: Read the CSV file
data = readtable('BC_35.csv');

% Step 2: Keep only numeric variables
numericData = data(:, varfun(@isnumeric, data, 'OutputFormat', 'uniform'));

% Step 3: Convert table to array for calculations
A = table2array(numericData);

% Step 4: Compute statistical measures
Mean        = mean(A);
Median      = median(A);
StdDev      = std(A);
Variance    = var(A);
Minimum     = min(A);
Maximum     = max(A);
SkewnessVal = skewness(A);
KurtosisVal = kurtosis(A);

% Step 5: Combine results into a table
ResultsTable = table(Mean', Median', StdDev', Variance', ...
                     Minimum', Maximum', SkewnessVal', KurtosisVal', ...
    'VariableNames', {'Mean','Median','Std_Deviation','Variance', ...
                      'Minimum','Maximum','Skewness','Kurtosis'}, ...
    'RowNames', numericData.Properties.VariableNames);

% Step 6: Display formatted table
disp('Statistical Analysis of Dataset Variables:')
disp(ResultsTable)
