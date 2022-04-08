function output = crossoverbin(x,y,N)


% N is the number of parent for the next generation after crossover
% m=2 at this example

[m,n] = size(x);

%% Encode the data as binary representation

% map the x, that is orginally in the interval of (-3,3), onto (0,2^16-1)
x = (x + 3)*(2^16-1)/6;

x_binary = encode(x);

% we know that the chromosome has two components each of which is 16-bits.
x_binary;


%% Implement two-point crossover operation

% counter
k=1;

% this parameter was taken from Chong's book
p_c = 0.75;

% the number of pairs we need to choose
p = p_c*N/2;

x_temp = x_binary;


x_index = 1:n;
for i=1:ceil(p)

    % choose two random parents not chosen before
    nonzeros = find(x_index);

    r1 = randi(length(nonzeros));
    r2 = randi(length(nonzeros));

    r1 = nonzeros(r1);
    r2 = nonzeros(r2);



    % choose two crossing site point
    
    r3 = randi(ceil(n/2))+ceil(n/2);
    r4 = randi(ceil(n/2));

    x_binary(:,:,n+k) = x_temp(:,:,r1);
    x_binary(:,:,n+k+1) = x_temp(:,:,r2);

    x_binary(1,r3:end,n+k) = x_temp(1,r3:end,r2);
    x_binary(2,1:r4,n+k) = x_temp(2,1:r4,r2);

    x_binary(1,r3:end,n+k+1) = x_temp(1,r3:end,r1);
    x_binary(2,1:r4,n+k+1) = x_temp(2,1:r4,r1);

    x_index(r1) = 0;
    x_index(r2) = 0;

    k = k + 2;
end



%% Decode the data to select the best of them

[~,~,n1] = size(x_binary);

x = decode(x_binary);

% map the y onto the interval of (-3,3)
x = (x*6/(2^16-1))-3;


% calculate the fitness of the new children of the parents

for i=(n+1):n1
    y(i) = Fun(x(:,i));
end

% choose the best N chromosome 
[~,I] = sort(y);

temp=x;
for i=1:N
    x(:,i) = temp(:,I(i));
end

output = x(:,1:N);
end