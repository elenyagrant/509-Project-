%% Example of Time Series Analysis using RKS applied to generated random data.

%% data
x = rand(100,1)*2*pi; % random numbers [0,2pi]
x = sort(x); % for plotting
yTrue = sin(x) * besselj(0,linspace(0,10,1000)); % y(x,t) = sin(x) * besselj(0,t)
e = 0.15*randn(100,1000); % small random error
y = yTrue + e;

%% visualization
figure
for i=1:1000
    plot(x,yTrue(:,i),'linewidth',2)
    hold on
    plot(x,y(:,i))
    hold off
    ylim([-1.2,1.2])
    % legend(["data","true function"])
    % title('Time Series Data')
    pause(0.005)
end

%% time-series preprocess
% use the past K observations
% create 20 features for space model
K = 10;

vv = approx_average_distance(x);

[X,Y,Wspace] = time_series_preproc(x, y, K, 20, 1/vv, 0.1);

% plot the model at one time location for verification
a = Y(1,:)';
yhat = [cos(x*Wspace) sin(x*Wspace)] * a;

figure
title(['spatial estimate at time ',num2str(K+10)])
plot(x, yhat)
hold on
plot(x, y(:,K+10))


%% construct time series model
% use kernel width of vv ~ 2 times the average distance between coef
% vectors. this is a generally good heuristic.
% create 20 time features
vv = approx_average_distance(X);
Wtime = randPicker(1/vv, size(X,2), 500); % note that we need way more time series features than spatial features
alpha = alphaFinder(X, Y, Wtime, 0.5);

%% visualize results
figure
for i=1:1000-K
    c = [cos(X(i,:)*Wtime) sin(X(i,:)*Wtime)]*alpha; % approximate the coefficient at time i(+10)
    yhat = [cos(x*Wspace) sin(x*Wspace)]*c';
    plot(x, yhat,'linewidth',2) % approximate the spatial model at time t
    hold on
    plot(x, y(:,i+10))    
    hold off
    ylim([-1.2,1.2])
%     legend(["data","predicted values"])
%     title('Time Series Estimate')
    pause(0.005)
end

figure
J = 20;
title(['Time Series Estimate at location x=',num2str(x(J))])
xx = x(J);
c = [cos(X*Wtime) sin(X*Wtime)]*alpha;
s = [cos(xx*Wspace) sin(xx*Wspace)]*(c');
plot(y(J,:))
hold on
plot(s)
legend(["Data","Predicted"])
