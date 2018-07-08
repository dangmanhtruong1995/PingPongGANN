function [score] = fitness_score(chromosome, num_of_inputs, num_of_hidden_units, num_of_outputs,...
    iter_num, chromosome_id)
neural_network = chromosome_as_1_hidden_layer_neural_network(chromosome, num_of_inputs, ...
    num_of_hidden_units);
score = pingpong_GA_NN(neural_network, iter_num, chromosome_id);

end

