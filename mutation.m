function [new_member_1, new_member_2] = mutation(member_1, member_2, mutation_rate, max_pertubation)
% Dang Manh Truong (dangmanhtruong@gmail.com)

length_1 = numel(member_1);
length_2 = numel(member_2);
new_member_1 = member_1;
new_member_2 = member_2;
mutation_decisions = randsample([false true], length_1, true,[(1-mutation_rate) mutation_rate]);
for i = 1 : length_1    
    do_a_mutation = mutation_decisions(i);
    if do_a_mutation        
        new_member_1(i) = member_1(1) + ((-max_pertubation) + rand*max_pertubation*2);
    end
end

mutation_decisions = randsample([false true], length_2, true,[(1-mutation_rate) mutation_rate]);
for i = 1 : length_2    
    do_a_mutation = mutation_decisions(i);
    if do_a_mutation        
        new_member_1(i) = member_2(1) + ((-max_pertubation) + rand*max_pertubation*2);        
    end
end

end

