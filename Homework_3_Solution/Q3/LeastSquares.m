clc,clear 

% assign some known parameters
a = -2;
b = 2;



% assign a set of  output signal
y = rand(101,1);
y(1) = 0;

[m,n] = size(y);

% size(A) = (m-1,m-1) because of matlab indexing
A=b*eye(m-1,m-1);


B = zeros(m-1,1);
for i=1:(m-1)
    B(i) = y(i+1) - a.*y(i);
end


A_T = transpose(A);

u =  ((A_T*A)\A_T)*B



  