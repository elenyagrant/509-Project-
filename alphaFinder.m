function alpha = alphaFinder(x,y,w,lambda)
    feat = exp(1i*x*w);
    
    alpha = (feat'*feat+lambda*eye(size(feat,2)))\(feat'*y);
end