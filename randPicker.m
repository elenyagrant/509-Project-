function w = randPicker(gamma, dim, K)
    % Sampling the gaussian kernel, e^(gamma*x^2)
    w = randn(dim,K)*2*gamma*dim;
end