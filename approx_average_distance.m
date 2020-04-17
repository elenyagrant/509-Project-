function d = approx_average_distance(A)
% uses randomization to approximate the average distance between rows of A.
% The output 1/d, or sometimes 2/d, serves as a good approximation for kernel
% scaling parameters.
n = size(A,1);
p = randi([1,n], min([1000,n]), 1);
q = randi([1,n], min([1000,n]), 1);
d = A(p,:) - A(q,:);
d = vecnorm(d,2,2);
d = mean(d);
end