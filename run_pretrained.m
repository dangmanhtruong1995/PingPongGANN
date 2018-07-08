clear;
clc;

%% Load pretrained model
load('best_neural_network.mat');
% load('best_neural_network_2.mat');
num_of_inputs = best_neural_network.num_of_inputs;
num_of_hidden_units = best_neural_network.num_of_hidden_units;
num_of_outputs = best_neural_network.num_of_outputs;
chromosome = best_neural_network.chromosome;
iter_num = best_neural_network.iter_num;
chromosome_id = best_neural_network.chromosome_id;

%% It's show time!
score = fitness_score(chromosome, ...
            num_of_inputs, num_of_hidden_units, num_of_outputs, iter_num, chromosome_id);