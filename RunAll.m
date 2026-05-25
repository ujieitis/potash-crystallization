%% Master Script - Complete Potash Crystallization Pipeline
% Run this script to execute the entire workflow:
% 1. Data Preprocessing
% 2. Model Training
% 3. Model Prediction
% 4. Parameter Optimization

clear all; close all; clc;

fprintf('\n╔══════════════════════════════════════════════════════════════════╗\n');
fprintf('║  POTASH ALUM CRYSTALLIZATION - COMPLETE ANALYSIS PIPELINE       ║\n');
fprintf('║                   Starting Workflow...                          ║\n');
fprintf('╚══════════════════════════════════════════════════════════════════╝\n\n');

%% PHASE 1: DATA PREPROCESSING
% =========================================================================
fprintf('PHASE 1: DATA PREPROCESSING\n');
fprintf('─────────────────────────────────────────────────────────────────\n');

try
    run preprocessing_script.m
    fprintf('\n✓ PHASE 1 COMPLETED\n\n');
catch ME
    fprintf('\n✗ PHASE 1 FAILED: %s\n', ME.message);
    fprintf('Please ensure preprocessing_script.m is in the current directory.\n');
    return;
end

pause(2);

%% PHASE 2: MODEL TRAINING
% =========================================================================
fprintf('\nPHASE 2: MODEL TRAINING\n');
fprintf('─────────────────────────────────────────────────────────────────\n');

try
    run model_training_crystallization.m
    fprintf('\n✓ PHASE 2 COMPLETED\n\n');
catch ME
    fprintf('\n✗ PHASE 2 FAILED: %s\n', ME.message);
    fprintf('Please ensure model_training_crystallization.m is in the current directory.\n');
    return;
end

pause(2);

%% PHASE 3: MODEL PREDICTION
% =========================================================================
fprintf('\nPHASE 3: MODEL PREDICTION\n');
fprintf('─────────────────────────────────────────────────────────────────\n');

try
    run model_prediction.m
    fprintf('\n✓ PHASE 3 COMPLETED\n\n');
catch ME
    fprintf('\n✗ PHASE 3 FAILED: %s\n', ME.message);
    fprintf('Please ensure model_prediction.m is in the current directory.\n');
    return;
end

pause(2);

%% PHASE 4: OPTIMIZATION
% =========================================================================
fprintf('\nPHASE 4: PARAMETER OPTIMIZATION\n');
fprintf('─────────────────────────────────────────────────────────────────\n');

try
    run model_optimization.m
    fprintf('\n✓ PHASE 4 COMPLETED\n\n');
catch ME
    fprintf('\n✗ PHASE 4 FAILED: %s\n', ME.message);
    fprintf('Please ensure model_optimization.m is in the current directory.\n');
    return;
end

%% FINAL SUMMARY
% =========================================================================
fprintf('\n╔══════════════════════════════════════════════════════════════════╗\n');
fprintf('║                   WORKFLOW COMPLETED SUCCESSFULLY!              ║\n');
fprintf('╚══════════════════════════════════════════════════════════════════╝\n\n');

fprintf('Generated Files:\n');
fprintf('─────────────────────────────────────────────────────────────────\n');
fprintf('Data Files:\n');
fprintf('  • preprocessed_data.mat              - Preprocessed dataset\n');
fprintf('  • preprocessed_standardized.csv      - Standardized features\n');
fprintf('  • preprocessed_train.csv             - Training set\n');
fprintf('  • preprocessed_test.csv              - Test set\n\n');

fprintf('Model Files:\n');
fprintf('  • trained_crystallization_model.mat  - Trained ML model\n');
fprintf('  • prediction_results.mat             - Prediction scenarios\n');
fprintf('  • optimization_results.mat           - Optimization solutions\n\n');

fprintf('Visualizations:\n');
fprintf('  • preprocessing_analysis.fig         - Data analysis plots\n');
fprintf('  • model_training_analysis.fig        - Model performance plots\n');
fprintf('  • prediction_analysis.fig            - Prediction sensitivity\n');
fprintf('  • optimization_analysis.fig          - Optimization results\n\n');

fprintf('Next Steps:\n');
fprintf('─────────────────────────────────────────────────────────────────\n');
fprintf('1. Review the generated visualizations (*.fig files)\n');
fprintf('2. Examine model performance metrics in the MATLAB console\n');
fprintf('3. Use trained_crystallization_model.mat for new predictions\n');
fprintf('4. Implement optimal parameters from optimization_results.mat\n');
fprintf('5. Validate predictions against experimental data\n\n');

disp('═══════════════════════════════════════════════════════════════════');
disp('Analysis Complete! All results saved.');
disp('═══════════════════════════════════════════════════════════════════');
