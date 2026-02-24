clc; clear; close all

%% Define files and titles
signals = {'SQR','SINE','SAW'};
signals1 = {'Square','Sine','Sawtooth'};
qubes   = {'QUBE1','QUBE2'};
metricsAll = struct();

figCounter = 1;
for s = 1:length(signals)
    for q = 1:length(qubes)
        fileNormal   = sprintf('%s_LQR_Normal_5115_1225_%s.mat', signals{s}, qubes{q});
        fileAdaptive = sprintf('%s_LQR_Adaptive_5115_1225_%s.mat', signals{s}, qubes{q});
        titleStr = sprintf('%s Wave Reference -- %s', signals1{s}, qubes{q});

        metricsAll.(qubes{q}).(signals{s}) = analyzeSingleRun(fileNormal, fileAdaptive, titleStr, 400, figCounter);
        figCounter = figCounter + 1;
    end
end

%% ---- Trade-off figure ----
plotControlEffortTradeoffMulti(metricsAll, figCounter);
figCounter = figCounter + 1;
plotControlEffortTradeoffSingle(metricsAll, figCounter);

%% Prepare table data
signals = fieldnames(metricsAll.QUBE1); % 'Square', 'Sine', 'Saw'
qubes   = fieldnames(metricsAll);       % 'Qube1', 'Qube2'
metrics = {'MSE', 'RMSE', 'MAE', 'sMAPE'}; % all metrics

% Initialize tables
rows = {};
dataValues = [];
improvValues = [];

for s = 1:length(signals)
    sig = signals{s};
    for q = 1:length(qubes)
        qname = qubes{q};
        
        % Extract Fixed and Adaptive metrics
        fixedVal    = metricsAll.(qname).(sig).Fixed;
        adaptiveVal = metricsAll.(qname).(sig).Adaptive;
        
        % Store values for table 1
        rowName = sprintf('%s - %s', sig, qname);
        rows{end+1} = rowName;
        dataValues(end+1,:) = [fixedVal.MSE, adaptiveVal.MSE, ...
                               fixedVal.RMSE, adaptiveVal.RMSE, ...
                               fixedVal.MAE, adaptiveVal.MAE, ...
                               fixedVal.sMAPE, adaptiveVal.sMAPE];
                           
        % Store percentage improvement for table 2
        improvValues(end+1,:) = 100*(fixedVal.MSE - adaptiveVal.MSE)/fixedVal.MSE;
        improvValues(end,2) = 100*(fixedVal.RMSE - adaptiveVal.RMSE)/fixedVal.RMSE;
        improvValues(end,3) = 100*(fixedVal.MAE - adaptiveVal.MAE)/fixedVal.MAE;
        improvValues(end,4) = 100*(fixedVal.sMAPE - adaptiveVal.sMAPE)/fixedVal.sMAPE;
    end
end

%% Table 1: Absolute Metrics
T_metrics = array2table(dataValues, 'VariableNames', {...
    'Fixed_MSE','Adaptive_MSE',...
    'Fixed_RMSE','Adaptive_RMSE',...
    'Fixed_MAE','Adaptive_MAE',...
    'Fixed_sMAPE','Adaptive_sMAPE'},...
    'RowNames', rows);

disp('--- Table 1: Absolute Metrics ---')
disp(T_metrics)

%% Table 2: % Improvement of Adaptive over Fixed
T_improvement = array2table(improvValues, 'VariableNames', ...
    {'%Improvement_MSE','%Improvement_RMSE','%Improvement_MAE','%Improvement_sMAPE'},...
    'RowNames', rows);

disp('--- Table 2: Percentage Improvement ---')
disp(T_improvement)

%% Optional: Export to LaTeX
% latexMetrics = latex(T_metrics);
% latexImprovement = latex(T_improvement);

%% Prepare table data
signalsU = fieldnames(metricsAll.QUBE1); % 'Square', 'Sine', 'Saw'
qubesU   = fieldnames(metricsAll);       % 'Qube1', 'Qube2'
metricsU = {'RMS_U'}; % all metrics

% Initialize tables
rowsU = {};
dataValuesU = [];
improvValuesU = [];

for s = 1:length(signalsU)
    sig = signalsU{s};
    for q = 1:length(qubesU)
        qname = qubesU{q};
        
        % Extract Fixed and Adaptive metrics
        fixedVal    = metricsAll.(qname).(sig).Fixed;
        adaptiveVal = metricsAll.(qname).(sig).Adaptive;
        
        % Store values for table 1
        rowName = sprintf('%s - %s', sig, qname);
        rowsU{end+1} = rowName;
        dataValuesU(end+1,:) = [fixedVal.RMS_U, adaptiveVal.RMS_U];
                           
        % Store percentage improvement for table 2
        improvValuesU(end+1,:) = 100*(fixedVal.RMS_U - adaptiveVal.RMS_U)/fixedVal.RMS_U;
    end
end

%% Table 1: Absolute Metrics
T_metricsU = array2table(dataValuesU, 'VariableNames', {...
    'Fixed_RMS_U','Adaptive_RMS_U'},...
    'RowNames', rowsU);

disp('--- Table 3: Absolute Metrics ---')
disp(T_metricsU)

%% Table 4: % Improvement of Adaptive over Fixed
T_improvementU = array2table(improvValuesU, 'VariableNames', ...
    {'%Improvement_RMS_U'},...
    'RowNames', rowsU);

disp('--- Table 4: Percentage Improvement ---')
disp(T_improvementU)

%% Optional: Export to LaTeX
% latexMetricsU = latex(T_metricsU);
% latexImprovementU = latex(T_improvementU);