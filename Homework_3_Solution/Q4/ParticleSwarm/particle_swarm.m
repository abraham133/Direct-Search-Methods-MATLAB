clc,clear


% dimension of the function
n = 2;

% assign particle number
particle = 20:100;

% record the global minimum point at each iteration
global_points = zeros(2,81);

% record the time it takes for each particle number
time = zeros(1,81);

for part = 20:100
    
    tic;
    
    % random initial values
    %x(n,i,part)~n dimension, ith iteration, part is the number of the particle
    x = zeros(n,1,part);
    v = zeros(n,1,part);
    for i=1:part
        for m=1:n
            x(m,1,i) = 4*randn + 3;
            v(m,1,i) = randn;
        end
    end
    
    
    % Implement Particle Swarm Optimization
    
    % initial parameters
    w = 1;
    c1 = 1.9;
    c2 = 2;
    
    % the number of iteration
    iter = 30;
    
    
    % random parameters
    r = zeros(n,1,part);
    s = zeros(n,1,part);
    
    % velocities
    v = zeros(n,1,part);
    
    % personal bests
    p = zeros(n,1,part);
    
    % global bests
    g = zeros(n,iter);
    
    
    for k=1:iter
        
        for ii=1:part
            for j=1:n
                r(j,k,ii) = rand;
                s(j,k,ii) = rand;
            end
        end
        
        % assign personal bests
        if ~(k==1)
            for ii=1:part
                p(:,k,ii) = personal_best(x(:,k,ii),p(:,k-1,ii));
            end
        else
            p(:,k,:) = x(:,k,:);
        end
        
        % assign global best
        g(:,k) = global_best(p(:,k,:));
        
        
        for ii=1:part
            v(:,k+1,ii) = w.*v(:,k,ii) + c1.*r(:,k,ii).*(p(:,k,ii) - x(:,k,ii)) ...
                + c2.*s(:,k,ii).*(g(:,k) - x(:,k,ii));
            x(:,k+1,ii) = x(:,k,ii) + v(:,k+1,ii);
        end
        
    end
        
 global_points(:,part) = g(:,iter);
 time(part-19)=toc;
end

% check global points
global_points(:,20:end);

% Plotting the number of particle vs time

figure
plot(particle,time)
grid
xlabel 'Particle Number'
ylabel 'Time'
title 'The number of Particle vs Time'


% Plotting the number of particle vs function values
% at first, assign the function values of the global points obtained ...
% at the end of each iteration for different particle numbers.

fun_value = zeros(81,1);

for i=0:80
    
    fun_value(i+1,1) = Fun(global_points(:,20+i));
    
end


figure
plot(particle,fun_value)
grid
xlabel 'Particle Number'
ylabel 'Function Value'
title 'The number of Particle vs Global Function Values'


