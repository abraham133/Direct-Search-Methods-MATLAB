clc,clear

%% Random Initilization

x = zeros(2,20);
for i=1:20
    % the intervals of the randoms were chosen deliberately
    x(:,i) = vertcat(6*rand-3, 6*rand-3); 
end

%% Implement Genetic Algorithm
iter = 80;
best = zeros(1,iter);
worst = zeros(1,iter);
avg = zeros(1,iter);


% the number of chromosomes remaining constant
N=20;

for k=1:iter
    
    [m,n] = size(x);
     
    % calculate y values
    y = zeros(1,n);
    for ii=1:n
        y(1,ii) = Fun(x(:,ii));
    end

    % selection    
    [x,y_new,best(k),worst(k),avg(k)] = mating_pool(x,y);
    

    %crossover    
    x = crossoverbin(x,y_new,N);
    
    % plot the function values of chromosomes at this iteration
    for i=1:20
    scatter3(x(1,i),x(2,i),Fun(x(:,i)),'r*')
    hold on
    end
    
    %mutation
    temp = mutate(x);
    
    x = temp;   
end

%% Plot mesh surface plot

[q,z] = meshgrid(-6:0.08:6);

Z = 3*(1-q).^2.*exp(-q.^2-(z+1).^2)-10.*(0.2.*q-q.^3-z.^5).*...
    exp(-q.^2-z.^2)-exp(-(q+1).^2-z.^2)/3;

mesh(q,z,Z); xlabel 'x' ; ylabel 'y' ; zlabel 'z';
title('Movement of Generations')
hold on


%% Plot the bests,worsts and average 

figure
plot(1:iter,best,'k-o',1:iter,worst,'r-*',1:iter,avg,'p--')
grid
xlabel 'Generation'
ylabel 'Fun'
legend ('Best','Worst','Average')
