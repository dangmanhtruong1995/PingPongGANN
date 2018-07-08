function [new_member_1, new_member_2] = crossover(member_1, member_2, crossover_rate)
% Dang Manh Truong (dangmanhtruong@gmail.com)
% Crossover is performed by selecting a random gene along the length of the
% chromosomes and swapping all the genes after that point.
if rand > crossover_rate
    new_member_1 = member_1;
    new_member_2 = member_2;
else
    length_1 = numel(member_1);
    length_2 = numel(member_2);
    min_length = min(length_1, length_2);
    new_member_1 = member_1;
    new_member_2 = member_2;
    position_of_no_return = randi(min_length);
    temp = new_member_1(position_of_no_return+1 : min_length);
    new_member_1(position_of_no_return+1 : min_length) = new_member_2(position_of_no_return+1 : min_length);
    new_member_2(position_of_no_return+1 : min_length) = temp;
end

end

