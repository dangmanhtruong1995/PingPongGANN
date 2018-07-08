function [neural_network ] = chromosome_as_1_hidden_layer_neural_network(chromosome, num_of_inputs, ...
    num_of_hidden_units)
first_layer_weights = chromosome(1 : (num_of_inputs+1)*num_of_hidden_units);
second_layer_weights = chromosome((num_of_inputs+1)*num_of_hidden_units+1 : end);
w1 = vec2mat(first_layer_weights, num_of_inputs+1);
w2 = vec2mat(second_layer_weights, num_of_hidden_units+1);
neural_network.w1 = w1;
neural_network.w2 = w2;

end

