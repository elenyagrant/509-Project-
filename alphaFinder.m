function alpha = alphaFinder(x,y,w,lambda)
    feat = exp(1i*x*w);
    
    alpha = ridge(y,feat,lambda);
end