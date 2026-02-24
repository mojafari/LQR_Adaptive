function plotControlEffortTradeoffSingle(metricsAll, figID)
% Single-figure Control Effort vs Performance Trade-off
% Marker shape = reference type
% Color = controller type
% Filled vs hollow = hardware (Qube1/Qube2)

%% Global plotting setup
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaulttextInterpreter','latex');

if nargin < 2
    figID = 5;
end

figure(figID); 
clf;
set(gcf,'Color','w','Position',[300 300 900 400])
hold on; grid on;

% refs = {'Square','Sine','Saw'};
refs = fieldnames(metricsAll.QUBE1);
shapes = {'s','o','^'}; % circle, square, triangle
colors = struct('Fixed','b','Adaptive','r');

for r = 1:length(refs)
    ref = refs{r};
    shape = shapes{r};

    % --- Qube1 (filled) ---
    for ctrlType = {'Fixed','Adaptive'}
        m = metricsAll.QUBE1.(ref).(ctrlType{1});
        plot(m.RMS_U, m.RMSE, shape, ...
            'MarkerEdgeColor', colors.(ctrlType{1}), ...
            'MarkerFaceColor', 'w', ...
            'MarkerSize',8,'LineWidth',1.5)
    end

    % --- Qube2 (hollow) ---
    for ctrlType = {'Fixed','Adaptive'}
        m = metricsAll.QUBE2.(ref).(ctrlType{1});
        plot(m.RMS_U, m.RMSE, shape, ...
            'MarkerEdgeColor', colors.(ctrlType{1}), ...
            'MarkerFaceColor', colors.(ctrlType{1}), ...
            'MarkerSize',8,'LineWidth',1.5)
    end
end

xlabel('RMS Control Input $||u||_{RMS}$ [V]')
ylabel('RMS Tracking Error $||e||_{RMS}$ [deg]')
yticklabels(strrep(yticklabels,'-','$-$'))
title('Control Effort vs Tracking Performance Trade-off')

% Legend
lgd = legend({'Square Wave Fixed LQR QUBE1','Square Wave Adaptive LQR QUBE1', ...
        'Square Wave Fixed LQR QUBE2','Square Wave Adaptive LQR QUBE2', ...
        'Sine Wave Fixed LQR QUBE1','Sine Wave Adaptive LQR QUBE1', ...
        'Sine Wave Fixed LQR QUBE2','Sine Wave Adaptive LQR QUBE2', ...
        'Sawtooth Wave Fixed LQR QUBE1','Sawtooth Wave Adaptive LQR QUBE1', ...
        'Sawtooth Wave Fixed LQR QUBE2','Sawtooth Wave Adaptive LQR QUBE2'}, ...
        'Location','best','FontSize',10);
lgd.NumColumns = 1;
Layout;

hold off;
end
