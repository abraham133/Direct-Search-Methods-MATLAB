function gbest_new = global_best(p)

[~,~,part] = size(p);


for i=1:part
    if i==1
        val = Fun(p(:,1,i));
        gbest_new = p(:,1,i);
    else
        new_val = Fun(p(:,1,i));
        if new_val<val
            val = new_val;
            gbest_new = p(:,1,i);
        end
    end
end
            
        

end