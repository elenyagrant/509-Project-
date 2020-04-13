function w = randPicker(gamma, dim, K)
    % Sampling the gaussian kernel, e^(gamma*x^2)
    w = randn(K,dim)*2*gamma*dim;
end