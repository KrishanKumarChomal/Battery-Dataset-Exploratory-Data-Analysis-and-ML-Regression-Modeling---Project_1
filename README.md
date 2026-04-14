# Battery-Dataset-Exploratory-Data-Analysis-and-ML-Regression-Modeling---Project_1

The main aim of this study was to predict the average battery temperature (Tavg) using the BC_35.csv dataset under different operating conditions. Statistical and correlation analysis 
showed that battery temperature mainly depends on electrical load and discharge behavior. 

A MATLAB-bases machine learning project to predict average battery temperature (Tavg) from electrical parameters like discharge current, voltage and ampere-hour capacity. Pearson and Spearman correlation analysis for feature selection.

## Methodology
- Performed data preprocessing and cleaning
- Conducted statistical and correlation analysis (Pearson & Spearman)
- Applied feature selection to identify key variables
- Developed two regression models:
  - Multiple Linear Regression (MLR)
  - Decision Tree Regression (DT)

## Key Features Selected
- Discharge Current
- Voltage (Vact)
- Ampere-hour Capacity (Ah)

## Results

### Linear Regression (MLR)
- Testing R²: 0.8117  
- RMSE: 0.7120  
- MAE: 0.5151  
- Observation: Underfitting due to inability to capture non-linear behavior

### Decision Tree Regression (DT)
- Testing R²: 0.9994  
- RMSE: 0.0398  
- MAE: 0.0204  
- Observation: Excellent performance with strong alignment between predicted and actual values

Finally, removing unnecessary and noisy variables such as constant cycle values and irregular charge current helped improve the modeling quality. Overall, the study concludes that Decision Tree Regression is more suitable than Linear Regression for accurate battery temperature prediction, because battery thermal behavior is highly non-linear. 

This project successfully demonstrated the use of Machine Learning techniques for predicting battery average temperature (Tavg) using the BC_35 dataset. Through statistical analysis, 
correlation analysis, and feature selection, it was identified that Discharge Current, Vact (Voltage), and Ah are the most significant parameters affecting battery temperature. 

## How to Run
1. Open MATLAB
2. Load the dataset (BC_35.csv)
3. Run the main script file

## Tools:

## Course Information
MATLAB | Course: Industry 4.0 (24EE206T) |PDEU
## Note
This project was developed with the assistance of AI tools and independently validated and analyzed.
