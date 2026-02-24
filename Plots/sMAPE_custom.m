function val= sMAPE_custom(Y, T)
% sMAPE_custom Computes the Symmetric Mean Absolute Percentage Error (sMAPE)
% Y: Forecasted/Predicted values (array)
% T: Actual/Observed values (array)

    % Calculate the absolute difference between predictions and targets
    absoluteDifference = abs(Y - T);
    
    % Calculate the average of the absolute values of targets and predictions
    absoluteAvg = (abs(Y) + abs(T)) ./ 2;
    
    % Calculate the proportion (handle potential division by zero if both are zero, 
    % generally, those terms are ignored in summation in practice, but here we 
    % rely on standard array operations)
    % A robust implementation might check for cases where both T_i and Y_i are zero
    % to avoid Inf values, if that specific handling is required.
    proportion = absoluteDifference ./ (absoluteAvg);
    proportion(isnan(proportion)) = 0;
    
    % Compute the mean of the proportions and multiply by 100 for percentage
    val = 100 * mean(proportion, "all"); 
end
