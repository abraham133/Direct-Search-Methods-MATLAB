clc,clear

% different initial points 
x(:,1,1) = [-1.8 ; 0.8];
x(:,1,2) = [1.2 ; -0.2];
x(:,1,3) = [-0.5 ; -0.7];
x(:,1,4) = [0.4 ; 1.1];
x(:,1,5) = [0.2 ; 0.3];
x(:,1,6) = [0.06 ; 1.58];

% the time it takes to find the global minimum
time = zeros(6,1);

for i=1:6
    
    tic;
    k=1;
    
    %count how many times iteration stays at the same point
    again = 0;
    while 1
        
        d = [randn;randn];
        z = x(:,k,i) + d;
        
        
        funx = Fun(x(:,k,i));
        funz = Fun(z);
        
        
        if funz <= funx
            x(:,k+1,i) = z;
            funx_new = funz;
        else
            x(:,k+1,i) = x(:,k,i);
            again = again + 1;
            funx_new = Inf;
        end
        
        % stopping criteria
        if again>170000
            global_min = z
            break
        end
               
        % relative error criteria
        if abs(funx_new-funx) <=10^-2
            global_min = z
            break
        end
        k = k + 1;
    end
Fun(global_min)
time(i)=toc;
end

%% Find the relationship between distance to global min and time
global_min = [0.2427 ; -1.6226]; %obtained experimentally 
distance =zeros(6,1);

for i=1:6
    a=x(:,1,i);
    distance(i) = norm(a-global_min);
end

% sort the points in ascending order
[distance,I] = sort(distance);
time=time(I);

% plot
figure
plot(distance,time)
grid
title('Distance vs Time')
xlabel 'Distance'
ylabel 'Time'
