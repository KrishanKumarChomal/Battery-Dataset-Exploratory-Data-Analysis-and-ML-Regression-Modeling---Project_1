# Battery-Dataset-Exploratory-Data-Analysis-and-ML-Regression-Modeling---Project_1

The main aim of this study was to predict the average battery temperature (Tavg) using the 
BC_35.csv dataset under different operating conditions. Statistical and correlation analysis 
showed that battery temperature mainly depends on electrical load and discharge behavior. 

The analysis confirmed that Discharge Current has high variability (Variance ≈ 441.96), 
making it a strong factor affecting temperature rise. This is practically valid because higher 
current produces more heat inside the battery due to internal resistance. Similarly, Vact 
(Voltage) and Ah were selected because voltage drop and discharge progression also 
influence heat generation, especially near the end of discharge. 

Two models were developed: Multiple Linear Regression (MLR) and Decision Tree 
Regression (DT). The linear regression model performed reasonably well with Testing R² ≈ 
0.8117, but it showed underfitting because it could not capture sharp temperature changes 
and non-linear heating behavior. Its testing error values were higher (RMSE ≈ 0.7120, MAE 
≈ 0.5151). 
In contrast, the decision tree model produced excellent results with Testing R² ≈ 0.9994, and 
very low error values (RMSE ≈ 0.0398, MAE ≈ 0.0204). The prediction plots also showed 
that the decision tree outputs almost overlapped with actual temperature values, proving that 
it successfully learned the non-linear relationship between the inputs and Tavg.

Finally, removing unnecessary and noisy variables such as constant cycle values and 
irregular charge current helped improve the modeling quality. Overall, the study concludes 
that Decision Tree Regression is more suitable than Linear Regression for accurate battery 
temperature prediction, because battery thermal behavior is highly non-linear. 

This project successfully demonstrated the use of Machine Learning techniques for predicting 
battery average temperature (Tavg) using the BC_35 dataset. Through statistical analysis, 
correlation analysis, and feature selection, it was identified that Discharge Current, Vact 
(Voltage), and Ah are the most significant parameters affecting battery temperature. 
