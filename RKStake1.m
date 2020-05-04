%%
%The following shows the use of RKS to perform linear least squares
%analysis on a noisy signal. The actual RKS part of the analysis takes
%place primarily in the alphaFinder function.

x = rand(100,1);
y = tanh(4*x-2)+.2*randn(100,1);

w = randPicker(.69,1,10);

[a,b] = alphaFinder(x,y,w,0.01);

T = linspace(0,1,1000)';

fhat = [cos(T*w) sin(T*w)]*a + b;

figure()
plot(T,fhat);
hold on 
scatter(x,y);