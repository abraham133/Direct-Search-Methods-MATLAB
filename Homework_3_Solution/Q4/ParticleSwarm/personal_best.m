function pbest_new = personal_best(x,p_best_old)


new_val = Fun(x);
p_best_old_val = Fun(p_best_old);

if (new_val<p_best_old_val)
    pbest_new = x;
else
    pbest_new = p_best_old;
end

end