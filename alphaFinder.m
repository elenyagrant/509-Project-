function [alpha, intercept] = alphaFinder(x,y,w,lambda)
    feat = [cos(x*w) sin(x*w)];
    feat = [ones(size(x,1),1) feat];
    
    [U,S,V] = svd(feat,'econ');
    
    S = diag(S);
    S = S ./ (S.^2 + lambda);
    alpha = V * (S .* (U' * y));
    
    intercept = alpha(1,:);
    alpha = alpha(2:end,:);
end