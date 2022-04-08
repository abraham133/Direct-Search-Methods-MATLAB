clc,clear

Aeq = [1 0 0 0 1 0 0 0 0 0 0 0 ;
       0 1 0 0 0 1 0 0 0 0 0 0 ;
       0 0 1 0 0 0 1 0 0 0 0 0 ;
       0 0 0 1 0 0 0 1 0 0 0 0 ;
       1 1 0 0 0 0 0 0 1 0 0 0 ;
       1 0 0 1 0 0 0 0 0 1 0 0 ;
       0 1 1 0 0 0 0 0 0 0 1 0 ;
       0 1 0 1 0 0 0 0 0 0 0 1 ];
     
beq = [8 ; 3 ; 3 ; 4 ; 10 ; 8 ; 3 ; 4];

A=[];
b=[];
lb = [0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0];
ub = [];

c = [-6 ; -10 ; -3 ; -9 ; 0;0;0;0;0;0;0;0];

%% our function written by hand
[x,z] = simplex(Aeq,beq,c)

%% Matlab built-in function
%[X,Z] = linprog(c,A,b,Aeq,beq,lb,ub)