function [alpha, intercept] = alphaFinder(x,y,w,lambda)
    feat = [cos(x*w) sin(x*w)];
    feat = [ones(size(x,1),1) feat];
    alpha = (feat'*feat+lambda*eye(size(feat,2)))\(feat'*y);
    intercept = alpha(1,:);
    alpha = alpha(2:end,:);
end