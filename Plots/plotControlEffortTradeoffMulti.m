function plotControlEffortTradeoffMulti(metricsAll, figID)
% plotControlEffortTradeoffMulti
% Control effort vs tracking performance trade-off
% Multi-reference, multi-hardware journal figure

%% Global plotting setup
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaulttextInterpreter','latex');

if nargin < 2
    figID = 5;
end

% refs = {'Sine','Square','Saw'};
refs = fieldnames(metricsAll.QUBE1);

refNames = {'Sine Wave Reference','Square Wave Reference','Sawtooth Wave Reference'};

figure(figID); clf;
set(gcf,'Color','w','Position',[200 200 900 350])

for k = 1:3
    subplot(1,3,k); hold on; grid on;

    % ---- Qube 1 ----
    m1F = metricsAll.QUBE1.(refs{k}).Fixed;
    m1A = metricsAll.QUBE1.(refs{k}).Adaptive;

    plot(m1F.RMS_U, m1F.RMSE,'bo','MarkerSize',8,'LineWidth',1.5)
    plot(m1A.RMS_U, m1A.RMSE,'b^','MarkerSize',8,'LineWidth',1.5)

    % ---- Qube 2 ----
    m2F = metricsAll.QUBE2.(refs{k}).Fixed;
    m2A = metricsAll.QUBE2.(refs{k}).Adaptive;

    plot(m2F.RMS_U, m2F.RMSE,'ro','MarkerSize',8,'LineWidth',1.5)
    plot(m2A.RMS_U, m2A.RMSE,'r^','MarkerSize',8,'LineWidth',1.5)

    xlabel('RMS Control Input $||u||_{RMS}$ [V]')
    ylabel('RMS Tracking Error $||e||_{RMS}$ [deg]')
    yticklabels(strrep(yticklabels,'-','$-$'))
    title(refNames{k})

    axis tight
    Layout;
end

ldg = legend({'Fixed LQR QUBE1','Adaptive LQR QUBE1', ...
        'Fixed LQR QUBE2','Adaptive LQR QUBE2'}, ...
        'Location','best');
ldg.NumColumns = 1;
Layout;

end
