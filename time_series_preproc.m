function [X, Y, wSpace] = time_series_preproc(x, y, window_size, nSpace_features, kernel_param, ridge_param)
% [X, Y, wSpace] = time_series_preproc(x, y, window_size, nSpace_features, kernel_param, ridge_param)
%   preprocesses space-time data to time series data in terms of the
%   coefficients of a spatial model. The spatial model is constructed using
%   RKS fourier features, which are computed by ridge regression.
%   --- parameters ---
%   x : spatial data information. The i^th row of x gives longitude and
%       latitude (and any other relevant features available) for the i^th
%       location.
%   y : time series data. The element y(i,j) is the number of infected
%       people at location i on day j.
%   window_size : the number of days to use for the time series model. More
%       days means fewer data points because the first window_size days
%       must be truncated.
%   nSpace_features : the number of random fourier features to use in the
%       spatial model.
%   kernel_param : the "width" of the kernel, i.e. gamma. Since we are
%       working with long. lat. data, gamma should be large enough to
%       accomodate distances on this scale.
%   ridge_param : lambda for ridge regression to be used for fitting the
%       spatial model. As lambda --> 0, the model fits better, but
%       potentially overfits. In contrast, as lambda --> inf, the model
%       "flattens out", i.e. underfits.
%   --- outputs ---
%   X : the features for linear time-series regression. The row X(i,:)
%       gives the coefficients for the previous window_size days in order.
%   y : the predicted variable for time-series regression. The row Y(i,:)
%       gives coefficients for the i^th day.
%   wSpace : the RKS parameters for the spatial model.

dim = size(x,2);
n_days = size(y,2);

%% fit a spatial model for each day.
A = zeros(n_days, 2*nSpace_features+1); % i^th row is the coefficients for the spatial model at i^th day.
wSpace = randPicker(kernel_param, dim, nSpace_features); % random RKS parameter for the spatial model
for i=1:n_days
    [a,b] = alphaFinder(x,y(:,i),wSpace,ridge_param);
    A(i,:) = [b, a'];
end

%% produce time series table.
[X,Y] = time_series_xy(A, window_size);

end