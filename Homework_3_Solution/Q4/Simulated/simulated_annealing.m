clc,clear

% different initial points in ascending order of distance to global point
% x(:,1,i) ~ith initial points
x(:,1,1) = [0.9 ; -1.8];
x(:,1,2) = [-0.5 ; -0.7];
x(:,1,3) = [1.1 ; -0.6];
x(:,1,4) = [1.2 ; -0.2];
x(:,1,5) = [0.2 ; 0.3];
x(:,1,6) = [2.1 ; -0.7];
x(:,1,7) = [-0.9 ; 0.2];
x(:,1,8) = [0.9 ; 0.8];
x(:,1,9) = [0.4 ; 1.1];
x(:,1,10) = [-1.8 ; 0.8];
x(:,1,11) = [0.06 ; 1.58];
x(:,1,12) = [2.7 ; 0.5];
x(:,1,13) = [0.6 ; 2.1];
x(:,1,14) = [0 ; 2.2];
x(:,1,15) = [-1.7 ; 1.7];

% choose an i index 

for i=14;
    
    tic;
    k=1;
    while 1
        
        d = [randn;randn];
        z = x(:,k,i) + d;
        
        T = 1 / log10(k+2);
        
        funx = Fun(x(:,k,i));
        funz = Fun(z);
        
        p = min(1,exp(-(funz - funx)/T ));
        
        
        if funz <= funx
            x(:,k+1,i) = z;
            funx_new = Fun(x(:,k+1,i));
        else
            if  p>=0.9
                x(:,k+1,i) = z;
                funx_new = Fun(x(:,k+1,i));
            else
                x(:,k+1,i) = x(:,k,i);
            end
        end
               
        
        % criteria is T value
        if T <=2.2*10^-1
            global_min = x(:,k+1,i);
            break
        end
        k = k + 1;
    end
time = toc;
end

%% Global min with respect to the initial x point

global_min

%% the time with respect to the x initial point

time


