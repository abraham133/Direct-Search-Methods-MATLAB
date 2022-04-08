clc,clear

%% Random Initilization

x = zeros(2,50);
for i=1:50
    % the intervals of the random values were chosen deliberately
    x(:,i) = vertcat(6*rand-3, 6*rand-3); 
end


%% Implement Genetic Algoritm
iter = 30;
best = zeros(1,iter);
worst = zeros(1,iter);
avg = zeros(1,iter);


for k=1:iter
    
    [~,m] = size(x);
    
    
    % calculate y values
    y = zeros(m,1);
    for ii=1:m
        y(ii,1) = Fun(x(:,ii));
    end
    
    % selection   
    [temp,best(k),worst(k),avg(k)] = mating_pool(x,y);
    
    %crossover    
    temp = crossover(temp);
    
    %mutation
    temp = mutate(temp);
    
    x = temp;
    
end
figure
plot(1:iter,best,'k-o',1:iter,worst,'r-*',1:iter,avg,'p--')
grid
xlabel 'Generation'
ylabel 'Fun'
legend ('Best','Worst','Average')



