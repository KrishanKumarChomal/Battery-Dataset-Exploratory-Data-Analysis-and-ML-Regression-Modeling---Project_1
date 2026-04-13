close all; clear; clc; 
 
% 1. Load Data 
filename = 'BC_35.csv'; 
opts = detectImportOptions(filename); 
opts.VariableNamingRule = 'preserve'; 
data = readtable(filename, opts); 
 
% Define Target 
targetVar = 'Tavg'; 
 
% 2. Analyze Variance (Remove Constants) 
disp('------------------------------------------------'); 
 
disp('STEP 1: Checking Variance (Statistical Spread)'); 
disp('------------------------------------------------'); 
vars = data.Properties.VariableNames; 
numericVars = vars(varfun(@isnumeric, data, 'OutputFormat', 'uniform')); 
 
selectedVars = {}; 
for i = 1:length(numericVars) 
    colName = numericVars{i}; 
    if strcmp(colName, targetVar), continue; end % Skip target 
     
    colData = data.(colName); 
    sd = std(colData); 
     
    if sd < 0.01 
        fprintf('  [DROP] %-20s (StdDev = %.4f -> Constant/Low Variance)\n', colName, sd); 
    else 
        fprintf('  [KEEP] %-20s (StdDev = %.4f)\n', colName, sd); 
        selectedVars{end+1} = colName; %#ok<SAGROW> 
    end 
end 
 
% 3. Analyze Correlation (Relevance & Redundancy) 
disp(' '); 
disp('------------------------------------------------'); 
disp('STEP 2: Correlation & Redundancy Analysis'); 
disp('------------------------------------------------'); 
 
% Compute Correlation Matrix for surviving variables + Target 
checkVars = [selectedVars, {targetVar}]; 
subData = data(:, checkVars); 
corrMat = corr(table2array(subData)); 
 
% Display Correlation with Target 
targetIdx = length(checkVars); % Target is last 
fprintf('Correlation with Target (%s):\n', targetVar); 
for i = 1:length(selectedVars) 
    r = corrMat(i, targetIdx); 
    fprintf('  %-20s: %.4f\n', selectedVars{i}, r); 
end 
 
% Check Redundancy (Threshold > 0.95) 
disp(' '); 
disp('Checking for Multicollinearity (Redundancy)...'); 
finalFeatures = selectedVars; 
dropList = {}; 
 
for i = 1:length(selectedVars) 
    for j = i+1:length(selectedVars) 
        r_cross = corrMat(i, j); 
        if abs(r_cross) > 0.95 
            var1 = selectedVars{i}; 
            var2 = selectedVars{j}; 
             
            fprintf('  [ALERT] High Correlation between %s and %s (r=%.4f)\n', var1, var2, r_cross); 
             
            % Logic: Keep the one with higher correlation to target, OR physical relevance 
            % Hardcoded Domain Logic: Prefer 'Current' over 'Cycle' 
            if contains(var1, 'Cycle') && contains(var2, 'Current') 
                dropList{end+1} = var1; %#ok<SAGROW> 
                fprintf('  -> Removing %s (Redundant, less physical relevance)\n', var1); 
 
            elseif contains(var2, 'Cycle') && contains(var1, 'Current') 
                dropList{end+1} = var2; %#ok<SAGROW> 
                fprintf('  -> Removing %s (Redundant, less physical relevance)\n', var2); 
            end 
        end 
    end 
end 
 
% Remove redundant features 
finalFeatures = setdiff(finalFeatures, dropList, 'stable'); 
 
% 4. Final Output 
disp(' '); 
disp('------------------------------------------------'); 
disp('FINAL FEATURE SELECTION'); 
disp('------------------------------------------------'); 
disp('The ML Model will use the following inputs:'); 
for i = 1:length(finalFeatures) 
    fprintf('  %d. %s\n', i, finalFeatures{i}); 
end 
disp('------------------------------------------------'); 