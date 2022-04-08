clc,clear

%% Assign a matrix mxn , m>n

% an arbitrary linear system created by user

A = [1.5    2    1    3   2;
      3     4    9    0   7;
      2     3    5    1   8;
      2     2    8   -3   5];

b = [8 ; 38 ; 23 ; 30];


% arbitrarily n dimension vector that is not a solution to the system Ax=b.
x0 = [1 ; 2 ; 3 ; 4 ; 5];

% check the dimension

[m,n] = size(A);

r = rank(A);

if ~(r==m)
    display('ERROR : The rank of A matrix should be equal to the number of')
    display('rows of the matrix')
    display('Ignore the solution below!!!')
end


% for the clarity
A_T = transpose(A);

% gauss elimination was used in the formula instead of inversing a matrix
x_prime =  A_T*((A*A_T)\b) + (eye(n) - A_T*((A*A_T)\A))*x0

% check the results
b=A*x_prime

norm = norm(x0-x_prime)