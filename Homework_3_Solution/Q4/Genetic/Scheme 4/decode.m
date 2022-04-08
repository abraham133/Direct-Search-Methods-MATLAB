function output = decode(x)

[m,~,n] = size(x);

y = zeros(m,n);
for i=1:n
    for j=1:m
        a = typecast(uint16(bin2dec(x(j,:,i))),'int16');
        a = double(a);
        y(j,i) = a;
    end
end
output = y;
end