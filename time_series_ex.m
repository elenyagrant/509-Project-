%% Example of Time Series Analysis
% we generate temporal and spatially varying data. The underlying function
% f(x,t) is smooth and the variables are tightly coupled. We also
% incorporate random error into the data.
% we use RKS for spatial non-linear regression, then we perform joint
% auto-regression (VAR model) on the coefficients produced by RKS. The
% result is a fairly accurate time series model.
% we justify the performing VAR on the coefficients because the basis
% functions are are continuous, thus varying the coefficients smoothly also
% varies the function smoothly.

%% data
rng(1234) % for reproducibility

x = rand(100,1)*2*pi; % random numbers [0,2pi]
x = sort(x); % for plotting

nT = 200;
t = linspace(0,pi,nT);
f = @(x,t) sin(x*t).*exp(0.1*(x-t)) - t; % wiggle!
yTrue = f(x,t); % note the x is a col vector and t is a row vector, this allows use to take advantage of the outer product and sum which makes the variables tightly coupled.

e = 0.4*randn(100,nT); % small random error
y = yTrue + e;

plt_lims = [min(y,[],'all')-0.5, max(y,[],'all') + 0.5];

%% visualization: animate true signal
figure(1)
for i=1:nT
    plot(x,yTrue(:,i),'linewidth',2)
    hold on
    plot(x,y(:,i))
    hold off
    ylim(plt_lims)
    legend(["true function","data"])
    title('Time Series Data')
    pause(0.005)
end

%% time-series preprocess
K = 10; % use the past K observations
L = 10; % create L features for space model

vv = approx_average_distance(x); % good metric for kernel parameter

[X,Y,Wspace] = time_series_preproc(x, y, K, L, 2/vv, 0.5);


%% construct time series model
% this is a simple linear AR model.
H = [ones(size(X,1),1) X];
alpha = (H'*H + 0.5*eye(size(H,2))) \ (H'*Y);
b = alpha(1,:);
alpha = alpha(2:end,:);

%% visualize; animate approximate signal
ys = zeros(size(y,1), nT-K);
figure(2)
for i=1:nT-K
    c = X(i,:)*alpha + b;
    ys(:,i) = [ones(size(x,1),1) cos(x*Wspace) sin(x*Wspace)]*c';  % approximate the spatial model at time t
    plot(x, ys(:,i),'linewidth',2)
    hold on
    plot(x, y(:,i+K))    
    hold off
    ylim(plt_lims)
    legend(["predicted values","data"])
    title('Time Series Estimate')
    pause(0.005)
end

%% predict future values
ynext = zeros(100,100);
j=1;
for i=nT-K:nT+100-K
    X(i+1,:) = [X(i,2*L+1+1:end) Y(i,:)]; % 2L+1 because L cosine and L sine and intercept
    Y(i+1,:) = X(i+1,:)*alpha + b;
    ynext(:,j) = [ones(size(x,1),1) cos(x*Wspace) sin(x*Wspace)]*(Y(i+1,:)');
    j = j+1;
end

%% visualization: plot the time series and estimate at a specified location
figure(3)
J = 40;
title(['Time Series Estimate at location x=',num2str(x(J))])
xx = x(J);
c = X*alpha + b;
s = [1 cos(xx*Wspace) sin(xx*Wspace)]*(c');
plot(y(J,K+1:end))
hold on
plot(s, '-', 'linewidth',2)
plot([nT-K,nT-K],[-1e4,1e4],'k--','linewidth',2)
legend(["Data","Predicted"])
ylim(plt_lims)

%% visualization: plot one coefficient and predicted future estimate
figure(4)
J = 4;
title('Time Series for one of the spatial coefficients')
plot(c(:,J));


%% visualize total result
figure(5)
subplot(2,2,1)
imagesc(yTrue, plt_lims)
colorbar
xlabel('time')
ylabel('space')
title('true function')

subplot(2,2,3)
imagesc(y, plt_lims)
title('with error')

subplot(2,2,2)
imagesc(ys, 'xdata', K+1:nT, plt_lims)
title('predicted')
xlim([0, nT])

subplot(2,2,4)
imagesc(abs(ys-yTrue(:,K+1:end)), 'xdata', K+1:nT)
colorbar
title('prediction error')
xlim([0, nT])

sgtitle('comparison of time series result to true')

