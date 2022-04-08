function [output,y_new,avg_best,avg_worst,avg] = mating_pool4(x,y)

% roulette-wheel scheme
% select the best values as a parents from mating pool

[~,n] = size(x);

% store that to obtain the average worst at the end of the day
y_sum = sum(y);

% get rid of positive y values if any and then i am going to convert... 
% all my probabilities to positive values
% thus, the greater probability value is, the lower y value
if max(y)>0
    y = y - max(y);
end

% calculate probabilities
s=0;
for i=1:n
    s = s + y(i);
end
p = y./s;


% sort probabilities with ascending order
[p_sorted,I] = sort(p);

% cumulative probabilities
p_cum = cumsum(p_sorted);

% rearrange x according to the new order
temp = x;
for i=1:n
    x(:,i) = temp(:,I(i));
end


% build mating pool

temp = zeros(2,15);% store the new parents
 
b=0; %counter of the bests
best = 0;

for ii=1:15

    r = rand;
    if r==1
        r = rand;
    end

    % the index is the index of x chromosome corresponding to the ...
    % r random probability.
    index = find((p_cum>=r),1);

    temp(:,ii) = x(:,index);
    f=Fun(temp(:,ii));
    best = best + f;
    y_new(ii) = f;
    b = b + 1;
end


avg_best = best/b;
avg_worst = (y_sum-best)/(n-b);
avg = y_sum/n;
output = temp;

end