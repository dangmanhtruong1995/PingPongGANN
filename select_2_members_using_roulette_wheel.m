function [member_1_index, member_2_index ] = select_2_members_using_roulette_wheel(num_of_chromosomes, prob_vector)
member_1_index = roulette_wheel_selection(num_of_chromosomes, prob_vector);
while 1
    member_2_index = roulette_wheel_selection(num_of_chromosomes, prob_vector);
    if member_2_index ~= member_1_index                
        break;
    end
end

end

