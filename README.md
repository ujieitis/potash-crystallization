````markdown
# Potash Alum Crystallization - Machine Learning Model

A complete machine learning pipeline for predicting and optimizing crystal size in potash alum crystallization processes.

## Overview

This project implements a **regression-based machine learning system** to:
- **Predict** crystal size based on process parameters (concentration, temperature, saturation, etc.)
- **Optimize** experimental conditions to maximize crystal size
- **Analyze** sensitivity of crystal size to different process variables

### Problem Statement

Given experimental data with:
- **Input features**: Concentration (C), Magma Temperature (T_magma), Water Temperature (T_water), Saturation, Supersaturation, Time
- **Target variable**: Crystal size distribution (N1-N106)
- **Goal**: Build predictive models and find optimal parameter combinations

## Project Structure

```
potash-crystallization/
├── preprocessing_script.m           # Data preprocessing and exploration
├── model_training_crystallization.m # Train multiple regression models
├── model_prediction.m               # Make predictions on new scenarios
├── model_optimization.m             # Find optimal process parameters
├── RunAll.m                         # Master script to run entire pipeline
├── RunPreML.m                       # Script runner reference
└── README.md                        # This file
```

## Workflow

### Phase 1: Data Preprocessing (`preprocessing_script.m`)

**Purpose**: Clean, explore, and prepare data for machine learning

**Key Operations**:
- Load CSV data (Potash 150 data.csv)
- Handle missing values
- Detect and remove outliers (IQR method)
- Standardize features (Z-score normalization)
- Remove highly correlated features (r > 0.95)
- Principal Component Analysis (PCA) for dimensionality reduction
- Split data into training (70%), validation (15%), and test (15%) sets

**Output**:
- `preprocessed_data.mat` - Complete preprocessed dataset
- `preprocessed_standardized.csv` - Standardized feature matrix
- `preprocessed_train.csv` / `preprocessed_test.csv` - Split datasets
- `preprocessing_analysis.fig` - Visualization plots

### Phase 2: Model Training (`model_training_crystallization.m`)

**Purpose**: Train and compare multiple regression models

**Models Trained**:
1. **Linear Regression** - Baseline model
2. **Polynomial Regression (degree 2)** - Captures non-linear relationships
3. **Tree Ensemble (Bagged Trees)** - Ensemble learning method
4. **Support Vector Machine (SVM)** - RBF kernel regression

**Evaluation Metrics**:
- Root Mean Squared Error (RMSE)
- R² Score (Coefficient of Determination)
- Training/Validation/Test set comparison

**Output**:
- `trained_crystallization_model.mat` - Best trained model
- `model_training_analysis.fig` - Model comparison visualizations
- Console report with performance metrics

### Phase 3: Model Prediction (`model_prediction.m`)

**Purpose**: Use trained model to predict crystal size for new conditions

**Features**:
- **Single Prediction**: Predict for specific experimental conditions
- **Batch Predictions**: Compare multiple scenarios
- **Sensitivity Analysis**: Understand how parameters affect crystal size
- **Confidence Intervals**: Provide prediction uncertainty (±RMSE)

**Example Scenarios**:
- Low temperature, baseline conditions
- Medium temperature, high saturation
- High temperature, low processing time
- High temperature, high concentration

**Output**:
- `prediction_results.mat` - All prediction scenarios
- `prediction_analysis.fig` - Sensitivity analysis plots
- Predicted crystal sizes with uncertainty bounds

### Phase 4: Optimization (`model_optimization.m`)

**Purpose**: Find optimal process parameters to maximize crystal size

**Optimization Methods**:

1. **Grid Search** - Exhaustive search over parameter space
   - Evaluates all combinations within defined bounds
   - Finds global maximum in discrete space

2. **Pattern Search** - Local refinement from grid best
   - Fine-tunes around best grid result
   - Improves precision of optimal parameters

3. **Multi-Objective Optimization** - Balanced approach
   - Maximizes crystal size (weight = 1.0)
   - Minimizes processing time (weight = 0.3)
   - Keeps saturation in optimal range (weight = 0.2)

**Parameter Bounds**:
```
Concentration (C):        10-40
Magma Temperature:        40-75°C
Water Temperature:        10-35°C
Saturation:               0.70-0.98
Supersaturation:          0.05-0.30
Crystallization Time:     1-5 hours
```

**Output**:
- `optimization_results.mat` - Optimal parameters from all methods
- `optimization_analysis.fig` - Pareto front and trade-off analysis
- Comparison of optimization strategies

## Getting Started

### Requirements
- MATLAB R2019b or later
- Statistics and Machine Learning Toolbox
- Optimization Toolbox
- Data file: `Potash 150 data.csv`

### Quick Start

**Option 1: Run Everything**
```matlab
RunAll.m
```

**Option 2: Run Individual Phases**
```matlab
% Preprocessing
run preprocessing_script.m

% Model Training
run model_training_crystallization.m

% Prediction
run model_prediction.m

% Optimization
run model_optimization.m
```

**Option 3: Modify and Run Individual Scripts**
Edit the relevant script and run it:
```matlab
edit model_prediction.m
run model_prediction.m
```

## Key Results

### Model Performance
The trained model achieves:
- **R² Score**: Typically 0.75-0.95 (depending on model)
- **RMSE**: Prediction error ±2-5 µm (or specified units)
- **Best Model**: Usually Tree Ensemble or Polynomial Regression

### Optimal Crystal Size
Expected optimal conditions:
- **Maximum crystal size**: ~50-100 µm (predicted)
- **Optimal temperature range**: 65-72°C
- **Optimal concentration**: 25-30
- **Processing time**: 2.5-3.5 hours

### Parameter Sensitivity
1. **Most important**: Magma Temperature and Concentration
2. **Moderate importance**: Saturation and Supersaturation
3. **Lesser importance**: Water Temperature and Time

## Output Files

### Data Files
| File | Description |
|------|-------------|
| `preprocessed_data.mat` | Full preprocessed dataset with all transformations |
| `trained_crystallization_model.mat` | Trained model + feature scaling info |
| `prediction_results.mat` | Predictions from all scenarios |
| `optimization_results.mat` | Optimal parameters from all methods |

### Visualization Files (.fig)
| File | Description |
|------|-------------|
| `preprocessing_analysis.fig` | Data distributions, correlations, PCA |
| `model_training_analysis.fig` | Model comparison, predictions vs actual |
| `prediction_analysis.fig` | Sensitivity analysis, scenario comparisons |
| `optimization_analysis.fig` | Parameter optimization results, Pareto front |

### CSV Files
| File | Description |
|------|-------------|
| `preprocessed_standardized.csv` | Standardized features for all samples |
| `preprocessed_train.csv` | Training set features |
| `preprocessed_test.csv` | Test set features |

## Usage Examples

### Example 1: Predict Crystal Size for Specific Conditions
```matlab
load trained_crystallization_model.mat

% Define experimental conditions
C = 28;              % concentration
T_magma = 65;        % magma temperature (°C)
T_water = 22;        % water temperature (°C)
Saturation = 0.88;
Supersaturation = 0.18;
Time = 2.8;

% Standardize
input = [C, T_magma, T_water, Saturation, Supersaturation, Time];
input_std = (input - model_info.feature_info.mean) ./ model_info.feature_info.std;

% Predict
predicted_size = predict(model_info.best_model, input_std);
fprintf('Predicted crystal size: %.4f µm\n', predicted_size);
```

### Example 2: Compare Multiple Scenarios
Run `model_prediction.m` and modify the `scenarios` matrix:
```matlab
scenarios = [
    25, 60, 25, 0.85, 0.15, 2.5;  % Your scenario 1
    30, 65, 20, 0.90, 0.20, 3.0;  % Your scenario 2
    % Add more...
];
```

### Example 3: Optimize for Your Constraints
Edit `model_optimization.m` to change parameter bounds:
```matlab
% Define your process constraints
param_bounds.C = [10, 40];           % Your range
param_bounds.T_magma = [50, 70];     % Your range
% ... etc
```

## Interpretation Guide

### Model Quality Indicators
- **R² > 0.85**: Excellent model fit
- **R² 0.70-0.85**: Good model fit
- **R² < 0.70**: Model may need improvement or feature engineering

### Prediction Confidence
- Predicted value ± 1×RMSE = ~68% confidence
- Predicted value ± 2×RMSE = ~95% confidence
- Predicted value ± 3×RMSE = ~99.7% confidence

### Parameter Importance (from Feature Importance Analysis)
High importance = Parameter has strong effect on crystal size
- Prioritize these in experimental optimization
- Small changes in high-importance parameters → large changes in output

## Troubleshooting

### Issue: "readtable" function fails
**Solution**: Ensure `Potash 150 data.csv` is in the current MATLAB directory

### Issue: "fitlm" or "fitrsvm" functions not found
**Solution**: Install Statistics and Machine Learning Toolbox
```matlab
% Check installed toolboxes
ver
```

### Issue: Out of memory during grid search
**Solution**: Reduce grid resolution in `model_optimization.m`:
```matlab
C_grid = linspace(param_bounds.C(1), param_bounds.C(2), 4);  % was 6
T_magma_grid = linspace(param_bounds.T_magma(1), param_bounds.T_magma(2), 4);  % was 6
```

### Issue: Model performance is poor (R² < 0.5)
**Solution**: 
1. Check data quality (missing values, outliers)
2. Feature engineering - add interaction terms
3. More sophisticated models (Neural Networks)
4. Verify target variable calculation

## Future Improvements

1. **Neural Networks**: Use Deep Learning Toolbox for complex patterns
2. **Bayesian Optimization**: More efficient parameter search
3. **Feature Engineering**: Create interaction terms and domain-specific features
4. **Ensemble Methods**: Combine predictions from multiple models
5. **Cross-Validation**: k-fold CV for more robust evaluation
6. **Uncertainty Quantification**: Bayesian regression for probabilistic predictions
7. **Transfer Learning**: Pre-trained models from similar processes

## References

- MATLAB Documentation: Statistics and Machine Learning Toolbox
- Regression Algorithms: Linear, Polynomial, Tree Ensemble, SVM
- Optimization: Grid Search, Pattern Search, Bayesian Optimization
- Crystallization Theory: Nucleation, growth kinetics

## Author

Created for potash alum crystallization process optimization
GitHub: ujieitis

## License

This project is provided for educational and research purposes.
````
