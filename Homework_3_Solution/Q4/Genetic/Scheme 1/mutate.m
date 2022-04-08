function output = mutate(x)

% ~REAL NUMBER CREEP~

[~,n] = size(x);

for i=1:n
    a=randi(2);
    x(a,i) = x(a,i) + 0.001;
end
output = x;
end