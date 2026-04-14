clc;
clear;
close all;

%% 1. Read Dataset
data = readtable('BC_35.csv');
data = data(:, vartype('numeric'));

%% 2. Define Inputs and Target
X = data(:, {'DischargeCurrent','Vact','Ah'});
Y = data.Tavg;

X = table2array(X);

%% 3. Train-Test Split (70% Training, 30% Testing)
cv = cvpartition(length(Y),'HoldOut',0.30);

X_train = X(training(cv),:);
Y_train = Y(training(cv));

X_test = X(test(cv),:);
Y_test = Y(test(cv));

%% 4. Train Models

% Model 1 - Multiple Linear Regression
mlrModel = fitlm(X_train, Y_train);

% Model 2 - Decision Tree
treeModel = fitrtree(X_train, Y_train);

%% 5. Predictions

% Linear Regression
Y_pred_train_mlr = predict(mlrModel, X_train);
Y_pred_test_mlr  = predict(mlrModel, X_test);

% Decision Tree
Y_pred_train_tree = predict(treeModel, X_train);
Y_pred_test_tree  = predict(treeModel, X_test);

%% 6. Performance Metric Functions
R2   = @(y,yp) 1 - sum((y-yp).^2)/sum((y-mean(y)).^2);
RMSE = @(y,yp) sqrt(mean((y-yp).^2));
MAE  = @(y,yp) mean(abs(y-yp));

%% 7. Compute Metrics

% Linear Model
R2_train_mlr   = R2(Y_train, Y_pred_train_mlr);
RMSE_train_mlr = RMSE(Y_train, Y_pred_train_mlr);
MAE_train_mlr  = MAE(Y_train, Y_pred_train_mlr);

R2_test_mlr   = R2(Y_test, Y_pred_test_mlr);
RMSE_test_mlr = RMSE(Y_test, Y_pred_test_mlr);
MAE_test_mlr  = MAE(Y_test, Y_pred_test_mlr);

% Decision Tree
R2_train_tree   = R2(Y_train, Y_pred_train_tree);
RMSE_train_tree = RMSE(Y_train, Y_pred_train_tree);
MAE_train_tree  = MAE(Y_train, Y_pred_train_tree);

R2_test_tree   = R2(Y_test, Y_pred_test_tree);
RMSE_test_tree = RMSE(Y_test, Y_pred_test_tree);
MAE_test_tree  = MAE(Y_test, Y_pred_test_tree);

%% 8. Create Structured Output Table

Model = {
    'Model 1 (Linear)';
    'Model 1 (Linear)';
    'Model 2 (Tree)';
    'Model 2 (Tree)'};

Dataset = {
    'Training';
    'Testing';
    'Training';
    'Testing'};

R2_values = [
    R2_train_mlr;
    R2_test_mlr;
    R2_train_tree;
    R2_test_tree];

RMSE_values = [
    RMSE_train_mlr;
    RMSE_test_mlr;
    RMSE_train_tree;
    RMSE_test_tree];

MAE_values = [
    MAE_train_mlr;
    MAE_test_mlr;
    MAE_train_tree;
    MAE_test_tree];

Results_Table = table(Model, Dataset, R2_values, RMSE_values, MAE_values);

disp('Model Performance Comparison Table:')
disp(Results_Table)
