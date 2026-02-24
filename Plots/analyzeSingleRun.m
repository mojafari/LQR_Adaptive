function metrics = analyzeSingleRun(fileNormal, fileAdaptive, titleStr, tEnd, figID)
    % Load data
    load(fileNormal); load(fileAdaptive);

    dataFixed.t   = Signals_norm_5115(1,:)';
    dataFixed.ref = Signals_norm_5115(2,:)';
    dataFixed.y   = Signals_norm_5115(3,:)';
    dataFixed.u   = Signals_norm_5115(4,:)';
    dataFixed.e   = Signals_norm_5115(6,:)';

    dataAdaptive.t   = Signals_adp_5115(1,:)';
    dataAdaptive.ref = Signals_adp_5115(2,:)';
    dataAdaptive.y   = Signals_adp_5115(3,:)';
    dataAdaptive.u   = Signals_adp_5115(4,:)';
    dataAdaptive.e   = Signals_adp_5115(6,:)';
    dataAdaptive.Q11 = Signals_adp_5115(10,:)';

    % Plot
    opts.titleStr = titleStr;
    opts.tEnd     = tEnd;
    opts.figID    = figID;
    plotAdaptiveLQRComparison(dataFixed, dataAdaptive, opts);

    % Compute metrics
    metrics = computeErrorMetrics(dataFixed, dataAdaptive);
end
