x = randn(100,1);
y = tanh(x)+.1*randn(100,1);

w = randPicker(.69,1,10);

a = alphaFinder(x,y,w,0.01);

T = linspace(-2,2,1000)';

fhat = exp(1i*T*w)*a;

figure()
plot(T,fhat);
hold on 
scatter(x,y);