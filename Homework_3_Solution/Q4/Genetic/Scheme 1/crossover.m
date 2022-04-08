function output = crossover(x)

% ~AVERAGING METHOD~
[~,n] = size(x);
% add new candidates as much as the half of current candidates
if rem(n,2)==0
    for i=1:(n/2)
        x(:,n+i) = (x(:,randi(n)) + x(:,randi(n)))/2;
    end
else
    for i=1:((n+1)/2)
        x(:,n+i) = (x(:,randi(n)) + x(:,randi(n)))/2;
    end
end
output = x;
end