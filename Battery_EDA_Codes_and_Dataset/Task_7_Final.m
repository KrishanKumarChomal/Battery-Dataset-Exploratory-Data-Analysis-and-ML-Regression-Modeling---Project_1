clc;
clear;
close all;

%% Load Dataset
data = readtable('BC_35.csv');

%% Define Inputs and Target
X = data{:, {'DischargeCurrent','Ah'}};
Y = data.Tavg;

%% Train-Test Split (70% Train, 30% Test)
cv = cvpartition(length(Y),'HoldOut',0.3);

X_train = X(training(cv),:);
Y_train = Y(training(cv));

X_test  = X(test(cv),:);
Y_test  = Y(test(cv));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MODEL 1 : MULTIPLE LINEAR REGRESSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mdl_linear = fitlm(X_train, Y_train);

Y_train_pred_lin = predict(mdl_linear, X_train);
Y_test_pred_lin  = predict(mdl_linear, X_test);

figure('Name','Model 1 - Linear Regression');

% 1. Regression Plot (Test Data)
subplot(2,2,1)
scatter(Y_test, Y_test_pred_lin,'b','filled')
hold on
plot(Y_test, Y_test,'k--','LineWidth',1.5)

% Best Fit Line (RED)
h1 = lsline;
set(h1,'Color','r','LineWidth',2);

xlabel('Actual Tavg')
ylabel('Predicted Tavg')
title('Regression Plot (Test Data)')
legend('Predicted','Ideal Line','Best Fit Line')
grid on

% 2. Predicted vs Actual (Training)
subplot(2,2,2)
plot(Y_train,'k','LineWidth',1.5)
hold on
plot(Y_train_pred_lin,'r--','LineWidth',1.5)
xlabel('Samples')
ylabel('Tavg')
title('Predicted vs Actual (Training)')
legend('Actual','Predicted')
grid on

% 3. Predicted vs Actual (Testing)
subplot(2,2,3)
plot(Y_test,'k','LineWidth',1.5)
hold on
plot(Y_test_pred_lin,'g--','LineWidth',1.5)
xlabel('Samples')
ylabel('Tavg')
title('Predicted vs Actual (Testing)')
legend('Actual','Predicted')
grid on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MODEL 2 : DECISION TREE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mdl_tree = fitrtree(X_train, Y_train);

Y_train_pred_tree = predict(mdl_tree, X_train);
Y_test_pred_tree  = predict(mdl_tree, X_test);

figure('Name','Model 2 - Decision Tree');

% 1. Regression Plot (Test Data)
subplot(2,2,1)
scatter(Y_test, Y_test_pred_tree,'b','filled')
hold on
plot(Y_test, Y_test,'k--','LineWidth',1.5)

% Best Fit Line (RED)
h2 = lsline;
set(h2,'Color','r','LineWidth',2);

xlabel('Actual Tavg')
ylabel('Predicted Tavg')
title('Regression Plot (Test Data)')
legend('Predicted','Ideal Line','Best Fit Line')
grid on

% 2. Predicted vs Actual (Training)
subplot(2,2,2)
plot(Y_train,'k','LineWidth',1.5)
hold on
plot(Y_train_pred_tree,'r--','LineWidth',1.5)
xlabel('Samples')
ylabel('Tavg')
title('Predicted vs Actual (Training)')
legend('Actual','Predicted')
grid on

% 3. Predicted vs Actual (Testing)
subplot(2,2,3)
plot(Y_test,'k','LineWidth',1.5)
hold on
plot(Y_test_pred_tree,'g--','LineWidth',1.5)
xlabel('Samples')
ylabel('Tavg')
title('Predicted vs Actual (Testing)')
legend('Actual','Predicted')
grid on
