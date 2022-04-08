function output = encode(x)

[m,n] = size(x);


for i=1:n
    for j=1:m
        temp = dec2bin(x(j,i),16);
        x_binary(j,:,i) = temp;
    end
end

output = x_binary;

end
