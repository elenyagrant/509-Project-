T = readtable('plagueDat2.csv','ReadVariableNames',1);

x = T{:,["Lat","Long_"]};
y = T{:,12:end};

yl = log1p(y);

n_days = 3;
n_feats = 1000;
% g = approx_average_distance(x);
g = 1;
ridge_param = 0;

% [X,Y,Wspace] = time_series_preproc(x, yl, n_days, n_feats, g, ridge_param);
% [X, Y] = time_series_xy(yl',n_days);
[X, Y] = kernel_time_series_preproc(x, yl, n_days, g, ridge_param);

ridge_param2 = 1e-3;
F = [ones(size(X,1)) X];
[U,S,V] = svd(F,'econ');

S = diag(S);
S = S ./ (S.^2 + ridge_param2);
alpha = V * (S .* (U' * Y));

ch = F*alpha;
% yh = [ones(size(x,1),1) cos(x*Wspace) sin(x*Wspace)]*(ch');
K = zeros(size(x,1));
for i=1:size(x,1)
    for j=1:size(x,1)
        K(i,j) = exp(-g*norm(x(i,:) - x(j,:))^2);
    end
end
K = [ones(size(x,1),1) K];
yh = K*(ch');

yh = expm1(yh);

subplot(2,1,1)
geobubble(x(:,1), x(:,2), y(:,end));

subplot(2,1,2)
geobubble(x(:,1), x(:,2), yh(:,end));