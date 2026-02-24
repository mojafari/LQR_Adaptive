function metrics = computeErrorMetrics(dataFixed, dataAdaptive)
% Computes error metrics and control effort for Fixed and Adaptive LQR
%
% Inputs:
%   dataFixed    - struct with fields: t, ref, y, u, e
%   dataAdaptive - struct with fields: t, ref, y, u, e, Q11 (optional)
%
% Output:
%   metrics - struct with fields:
%       Fixed, Adaptive, Improvement
%       each containing MSE, RMSE, MAE, sMAPE, RMS_U (RMS control effort)

    % --- Fixed LQR metrics ---
    metrics.Fixed.MSE   = mse(dataFixed.y, dataFixed.ref);
    metrics.Fixed.RMSE  = rmse(dataFixed.y, dataFixed.ref);
    metrics.Fixed.MAE   = mae(dataFixed.y, dataFixed.ref);
    metrics.Fixed.sMAPE = sMAPE_custom(dataFixed.y, dataFixed.ref);
    metrics.Fixed.RMS_U = rms(dataFixed.u); % RMS of control effort

    % --- Adaptive LQR metrics ---
    metrics.Adaptive.MSE   = mse(dataAdaptive.y, dataAdaptive.ref);
    metrics.Adaptive.RMSE  = rmse(dataAdaptive.y, dataAdaptive.ref);
    metrics.Adaptive.MAE   = mae(dataAdaptive.y, dataAdaptive.ref);
    metrics.Adaptive.sMAPE = sMAPE_custom(dataAdaptive.y, dataAdaptive.ref);
    metrics.Adaptive.RMS_U = rms(dataAdaptive.u); % RMS of control effort

    % --- Percentage Improvements (Adaptive vs Fixed) ---
    metrics.Improvement.MSE   = (metrics.Fixed.MSE - metrics.Adaptive.MSE)/metrics.Fixed.MSE * 100;
    metrics.Improvement.RMSE  = (metrics.Fixed.RMSE - metrics.Adaptive.RMSE)/metrics.Fixed.RMSE * 100;
    metrics.Improvement.MAE   = (metrics.Fixed.MAE - metrics.Adaptive.MAE)/metrics.Fixed.MAE * 100;
    metrics.Improvement.sMAPE = (metrics.Fixed.sMAPE - metrics.Adaptive.sMAPE)/metrics.Fixed.sMAPE * 100;
    metrics.Improvement.RMS_U = (metrics.Fixed.RMS_U - metrics.Adaptive.RMS_U)/metrics.Fixed.RMS_U * 100;
end
