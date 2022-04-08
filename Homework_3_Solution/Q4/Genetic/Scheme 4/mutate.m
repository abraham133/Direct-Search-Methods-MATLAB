function output = mutate(x_binary)

%% Encode the data as binary representation

% map the x, that is orginally in the interval of (-3,3), onto (0,2^16-1)
x_binary= (x_binary + 3)*(2^16-1)/6;

x_binary = encode(x_binary);

% we know that the chromosome has two components each of which is 16-bits.


%% ~ one-point mutation ~

[m,~,n] = size(x_binary);

for i=1:5:n
    for j=1:m
        a = randi(16);
        b = randi(16);
        num1 = typecast(uint16(bin2dec(x_binary(j,a,i))),'int16');
        num2 = typecast(uint16(bin2dec(x_binary(j,b,i))),'int16');
        if num1==1
            x_binary(j,a,i) = '0';
        else
            x_binary(j,a,i) = '1';
        end
        if num2==1
            x_binary(j,b,i) = '0';
        else
            x_binary(j,b,i) = '1';
        end
    end
end



%% Decode the data to integers values

y = decode(x_binary);

% map the y onto the interval of (-3,3)
y = (y*6/(2^16-1))-3;

output = y;
end