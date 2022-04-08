function [output,avg_best,avg_worst,avg] = mating_pool2(x,y)

% select the values with the best fitness as a parents for the crossover


[~,n] = size(x);

% build mating pool

temp = x;

[~,I] = sort(y);
% rearrange x according to the new sorted y
for i=1:n
    temp(:,i) = x(:,I(i));
end


b=0;% counter the bests
w=0;% counter the worst
best = 0;
worst = 0;

% obtain the bests from temp and sum all bests and worsts
% exactly half of the points 
if rem(n,2)==0
    y_best = temp(:,(1:(n/2)));
    
    % sum bests
    for ii=1:(n/2)
        best = best + Fun(temp(:,ii));
        b = b + 1;
    end
    
    % sum worsts
    for ii=(n/2+1):n
        worst = worst + Fun(temp(:,ii));
        w = w + 1;
    end    
else
    y_best = temp(:,1:((n+1)/2));
    
    % sum bests
    for ii=1:((n-1)/2)
        best = best + Fun(temp(:,ii));
        b = b + 1;
    end   
    
    % sum worsts
    for ii=(((n-1)/2)+1):n
        worst = worst + Fun(temp(:,ii));
        w = w + 1;
    end    
end

avg_best = best/b;
avg_worst = worst/w;
avg = (best + worst)/n;
output = y_best;

end