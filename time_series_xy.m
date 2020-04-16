function [X,Y] = time_series_xy(A, window_size)
% [X,Y] = time_series_xy(A, window_size)
%   produces pairs (x,y) such that the i^th row of Y is the i+window_size
%   observation (offset due to lag), and the the i^th row of X are the
%   window_size many observations prior.
%   typically window_size is selected to be as small as possible for most
%   applications. The rows of A are each observations.
n_days = size(A,1);
n_features = size(A,2);

X = zeros(n_days - window_size, n_features*window_size); % we truncate the first window_size days because they don't have values for window_size days before 
Y = zeros(n_days - window_size, n_features);
for i=window_size+1:n_days
    a = A(i-window_size:i-1,:)';
    X(i-window_size,:) = a(:)';
    Y(i-window_size,:) = A(i,:);
end
end