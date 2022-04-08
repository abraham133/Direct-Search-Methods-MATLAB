function [output , y_new,  avg_best , avg_worst , avg] = mating_pool3(x,y)

%% En iyi 15 taneyi seçerek ilerledim

% select the best values as a parents from mating pool

[~,n] = size(x);


% store that to obtain the average worst at the end of the day
y_sum = sum(y);

% store the initial y array
y_initial = y;

% get rid of positive y values if any and then i am going to convert... 
% all my probabilities to positive values
% thus, the greater probability value is, the lower y value
if max(y)>0
    y = y - max(y);
end

% calculate the probabilities
s=0;
for i=1:n
    s = s + y(i);
end
% we know that the p array consists of positive values smaller than 1
p = y./s;


% sort probabilities with descending order
[~,I] = sort(p,'descend');


% rearrange x and y according to the new order
temp = x;
for i=1:n
    x(:,i) = temp(:,I(i));
    y(i) = y_initial(I(i));
end

%% Build mating pool



% the first 15 parents that have the most fitness
b=15;

x_best = x(:,1:b);
best = sum(y(1:b));


avg_best = best/b;
avg_worst = (y_sum-best)/(n-b);
avg = y_sum/n;
y_new = y(1:b);
output = x_best;

end