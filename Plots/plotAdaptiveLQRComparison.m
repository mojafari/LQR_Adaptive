function metrics = plotAdaptiveLQRComparison(dataFixed, dataAdaptive, opts)
% plotAdaptiveLQRComparison
% Journal-quality plotting and analysis for Adaptive vs Fixed LQR
%
% Inputs:
%   dataFixed    - struct:
%                  .t   time [s]
%                  .ref reference [rad]
%                  .y   output [rad]
%                  .u   control [V]
%                  .e   tracking error [rad]
%
%   dataAdaptive - same fields +:
%                  .Q11 adaptive Q(1,1)
%
%   opts         - struct with fields:
%                  .titleStr
%                  .tEnd
%                  .figID
%
% Output:
%   metrics      - struct with RMSE, MAE, RMS(u)

%% Global plotting setup
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaulttextInterpreter','latex');


%% ---------------- Defaults ----------------
if nargin < 3
    opts = struct;
end
if ~isfield(opts,'titleStr'), opts.titleStr = ''; end
if ~isfield(opts,'tEnd'),     opts.tEnd = inf; end
if ~isfield(opts,'figID'),    opts.figID = 1; end

%% ---------------- Truncate Time ----------------
idxF = dataFixed.t <= opts.tEnd;
idxA = dataAdaptive.t <= opts.tEnd;

tF = dataFixed.t(idxF);
tA = dataAdaptive.t(idxA);

%% ---------------- Normalized Error ----------------
refAmp = max(abs(dataFixed.ref(idxF)));
eF_norm = dataFixed.e(idxF) / refAmp;
eA_norm = dataAdaptive.e(idxA) / refAmp;

%% ---------------- Metrics ----------------
metrics.Fixed.RMSE = rms(dataFixed.e(idxF));
metrics.Fixed.MAE  = mean(abs(dataFixed.e(idxF)));
metrics.Fixed.uRMS = rms(dataFixed.u(idxF));

metrics.Adaptive.RMSE = rms(dataAdaptive.e(idxA));
metrics.Adaptive.MAE  = mean(abs(dataAdaptive.e(idxA)));
metrics.Adaptive.uRMS = rms(dataAdaptive.u(idxA));

metrics.Improvement.RMSE = ...
    100*(metrics.Fixed.RMSE - metrics.Adaptive.RMSE)/metrics.Fixed.RMSE;
metrics.Improvement.MAE = ...
    100*(metrics.Fixed.MAE - metrics.Adaptive.MAE)/metrics.Fixed.MAE;

%% ---------------- Figure ----------------
figure(opts.figID); clf;
set(gcf,'Color','w','Position',[200 100 800 900])

% (a) Tracking
subplot(4,1,1)
plot(tF, dataFixed.ref(idxF),'k--','LineWidth',1.2); hold on
plot(tF, dataFixed.y(idxF),'b','LineWidth',1.5)
plot(tA, dataAdaptive.y(idxA),'r','LineWidth',1.5)
ylim([-100 100])
ylabel('$\theta$ [deg]')
yticklabels(strrep(yticklabels,'-','$-$'))
title(opts.titleStr)
ldg0 = legend('Reference','Fixed LQR','Adaptive LQR','Location','best');
ldg0.NumColumns = 3;
grid on
Layout;

% (b) Control
subplot(4,1,2)
plot(tF, dataFixed.u(idxF),'b','LineWidth',1.2); hold on
plot(tA, dataAdaptive.u(idxA),'r','LineWidth',1.2)
ylim([-10 10])
ylabel('u [V]')
yticklabels(strrep(yticklabels,'-','$-$'))
ldg1 = legend('Fixed LQR','Adaptive LQR','Location','best');
ldg1.NumColumns = 2;
grid on
Layout;

% (c) Normalized error
subplot(4,1,3)
plot(tF, eF_norm,'b','LineWidth',1.2); hold on
plot(tA, eA_norm,'r','LineWidth',1.2)
ylim([-0.05 0.05])
ylabel('$\frac{e}{max(|r|)}$')
% ylabel('$\frac{e}{max(|r|)}$',"Rotation",0)
yticklabels(strrep(yticklabels,'-','$-$'))
ldg2 = legend('Fixed LQR','Adaptive LQR','Location','best');
ldg2.NumColumns = 2;
grid on
Layout;

% (d) Adaptive Q
subplot(4,1,4)
plot(tA, dataAdaptive.Q11(idxA),'LineWidth',1.5)
ylim([0 110])
ylabel('$q_{11}$')
yticklabels(strrep(yticklabels,'-','$-$'))
xlabel('Time [s]')
grid on
Layout;

end
