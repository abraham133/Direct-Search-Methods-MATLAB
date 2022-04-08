function [output, objective_fun] = simplex(A,b,c)

[m,n] = size(A);

% a(:,:,i) ~ our basic columns at ith iteration 
a = zeros(m,m,1);

% x(:,i) ~ our  solution at ith iteration
x = zeros(n,1);

% y(:,i) ~ our basic solutions 
y = zeros(m,1);

%% Choose random m columns from A(mxn) matrix

% store indices as a binary
% e.g. if 3th column was selected, then index(1,:) = [0 0 1 0 0 0 0 .....0]
index = zeros(1,n);

% keep real indices in order
% e.g. if 3th column was selected at the first iteration,
% labels(1,:) = [3,....]
labels = zeros(1,m);

control = 1;
while control
    temp = A;
    i=1;
    
    while i<=m
        
        j = randi(n);
        
        % check that if jth column was taken before
        if temp(:,j) == 0
            continue
        end
        
        % store the indice of new basic columns
        index(1,j) = 1;
        labels(1,i) = j;
        
        % store the basic columns
        a(:,i,1) = temp(:,j);
        
        % make sure that u r not going to take a column taken before as basic
        % columns 
        temp(:,j) = 0;
        
        i = i + 1;
    end
    

    % control that if all solutions are nonnegative integers
    y(:,1) = a(:,:,1)\b;
    logic = ( floor(y(:,1))==ceil(y(:,1)) );
    if ((min(y(:,1))>=0) && ~(min(logic)==0))
        control = 0;
    else
        % restart the index array
        index(1,:) = 0;
    end
        
    if control==0

        % replace the basic solution the exact location ?????
        indices = labels(1,:);
        x(indices,1) = y(:,1);
        
    end
end


%% Implement simplex algorithm


control = 1;
iter = 2; % because of matlab indexing 
while control
    
    % current basic columns
    V = a(:,:,iter-1);
    
      
    
    % Find a new basic column.
    
    % store the index of nonbasic columns we choose during loop because, 
    % if all nonbasic columns are tried we need to finish searching a new 
    % basic column that is going to enter the basic solution.
    columns = [];
    counter = 1; %count the iteration number
    while 1
        
        if (length(unique(columns))==(n-m))
            disp('Solution found:')
            output = x(:,iter-1);
            objective_fun = transpose(c)*output;
            control = 0;
            break
        end
        
        % nonbasic columns indices
        nonbasic_cols = find(~index(iter-1,:));
        
        % we choose a column that will enters the solution
        k = randi(n-m); 
        q = nonbasic_cols(k);
        V(:,m+1) = A(:,q);
        
        % store the k values to check if there is an appropriate new basic
        % column that satisfy the criterias
        columns(counter) = k;
        
        % write it with the aid of the current basic columns.
        yq = rref(V);
        
        % get the coefficients (yq)
        yq = yq(:,m+1);

        % calculate the reduced cost coefficients of yq
        xq = zeros(n,1);
        k = labels(iter-1,:);
        
        xq(k,1) = yq;

        zq = transpose(c)*xq;
        cq = c(q);
        
        r = cq - zq;

        if r>=0   
            counter = counter + 1;
            continue
        end
        
         
        % the index of ap column in the current basis matrix
        p_basic = 0; 
        epsilon = Inf;
        for ii=1:m
            if (yq(ii)>0)
                temp = y(ii,iter-1) / yq(ii);
                if temp < epsilon
                    epsilon = temp;
                    p_basic = ii;
                end
            end
        end
        
        if (epsilon==0)
            counter = counter + 1;
            continue
        end
        
        if (epsilon==Inf)
            disp('Problem is unbounded')
            control =0;
            break
        end
        
        % p_basic is the index of the column leaving basis column in 
        % the a matrix.
        
        % p is the index of the column leaving basis column in A matrix.
        p = labels(iter-1,p_basic);
        
       

        % switch ap ~ aq
        a(:,:,iter) = a(:,:,iter-1);
        a(:,p_basic,iter) = A(:,q);

        % adjust the indices of the new basic columns
        index(iter,:) = index(iter-1,:);
        index(iter,q) = 1;
        index(iter,p) = 0;
        
        labels(iter,:) = labels(iter-1,:);
        labels(iter,p_basic) = q;

        % assign the new basic solution
        y(:,iter) = y(:,iter-1) - epsilon*yq;
        y(p_basic,iter) = epsilon;

        % assign the new x coefficients vector
        x(labels(iter,:),iter) = y(:,iter);
        
        break
        
    end
    iter = iter + 1;
end

end

