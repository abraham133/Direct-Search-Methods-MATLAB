clc,clear


time = [ 1 ; 2 ; 3];
distance = [ 5 ; 19.5 ; 44];

%% SECTION 1

% some parameters were obtained by hand 
s = 0;
t2 = 0;
st = 0;
st2 = 0;
t3 = 0;
t4 = 0;

for i=1:3
    s = s + distance(i);
    t2 = t2 + time(i)^2;
    st = st + distance(i)*time(i);
    st2 = st2 + distance(i)*time(i)^2;
    t3 = t3 + time(i)^3;
    t4 = t4 + time(i)^4;
end

% converted parameters to a linear system ~rank(A)<rank(A,b)~
A0 = [   t2    0 ;
       -2*st   t3;
       0.5*t4  0 ];
  
b0 = [2*s ; 0 ; st2];

% symbolic values that is going to be obtained at the end of the day
syms g g2
x0 = [ g ; g^2];

% for the clarity
A0_T = transpose(A0);

x0 =  ((A0_T*A0)\A0_T)*b0;

g0 = x0(1)


%% SECTION 2

G0 = A0_T*A0;

t_new = 4;
s_new = 78.5;

A1 = [ (t_new^2 - 2*s_new*t_new + 0.5*t_new^4) , t_new^3 ];
b1 = 2*s_new + s_new*t_new^2;
A1_T = transpose(A1);
G1 = G0 + A1_T*A1;

x1 = [g g^2];

x1 = x0 + G1\A1_T*(b1 - A1*x0);

g1 = x1(1)



%% CHECK THE SOLUTION

% converted parameters to a linear system ~rank(A)<rank(A,b)~
A_check = [    t2     0 ;
            -2*st     t3;
             0.5*t4   0 ;
              A1(1)   A1(2)];
  
b_check = [2*s ; 0 ; st2 ; b1];

% symbolic values that is going to be obtained at the end of the day
syms g g2
x_check = [ g ; g^2];

% for the clarity
A_check_T = transpose(A_check);

x_check =  ((A_check_T*A_check)\A_check_T)*b_check;

g_check = x_check(1)

%% a straightforward and simpler solution 

% the model function that we will converge to
syms s t g 

s = 0.5*g*t^2 ;

% implementation
D = [ 0.5*time(1)^2 ;
      0.5*time(2)^2 ;
      0.5*time(3)^2];
  
d = [distance(1) ; distance(2) ; distance(3)];

D_T = transpose(D);

% y0 = [ g ]
y0 =  ((D_T*D)\D_T)*d;
g_basic= y0
