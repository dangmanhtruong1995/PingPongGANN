% clear 
% clc
% rng('default');
set(0, 'DefaultFigureWindowStyle', 'docked');

%% Configurable parameters

num_of_inputs = 2;
num_of_hidden_units = 3;
num_of_outputs = 1;

num_of_chromosomes = 20;
crossover_rate = 0.8;
mutation_rate = 0.1;
num_of_elites = 1;
max_pertubation = 0.5;

%% Initialize the population
population = cell(1, num_of_chromosomes);
num_of_weights = (num_of_inputs+1)*num_of_hidden_units + (num_of_hidden_units+1)*num_of_outputs;
for i = 1 : num_of_chromosomes
    % population{i} = -500 + rand([1 num_of_weights]) * 1000;
    population{i} = -1 + rand([1 num_of_weights])*2;
end

%% It's show time!
fitness_scores = zeros(1, num_of_chromosomes);
iter_num = 1;
while 1
    % Test each chromosome to see how good it is at solving the problem 
    % at hand and assign a fitness score accordingly. The fitness score 
    % is a measure of how good that chromosome is at solving the problem 
    new_population = cell(1, num_of_chromosomes);
    current_best = [];
    best_fitness_score = -1;
    for i = 1 : num_of_chromosomes 
        chromosome_id = i;
        fitness_score_of_chromosome = fitness_score(population{i}, ...
            num_of_inputs, num_of_hidden_units, num_of_outputs, iter_num, chromosome_id);
        fitness_scores(i) = fitness_score_of_chromosome;        
        if best_fitness_score < fitness_score_of_chromosome
            current_best = population{i};
            current_best_idx = i;
            best_fitness_score = fitness_score_of_chromosome;
        end        
    end
       
    new_idx = 1;
    % Elitism
%     new_population{new_idx} = current_best;
%     new_idx = new_idx + 1;
    [~, fitness_scores_sorted_idx] =sort(fitness_scores, 'descend');
    for m = 1 : num_of_elites
        new_population{new_idx} = population{fitness_scores_sorted_idx(m)};
        new_idx = new_idx + 1;
    end
    
    while 1        
        % Select two members from the current population        
        if sum(fitness_scores)==0
            prob_vector = ones(1, num_of_chromosomes) * (1 / num_of_chromosomes);
        else
            prob_vector = fitness_scores ./ sum(fitness_scores);
        end  
        [member_1_index, member_2_index ] = select_2_members_using_roulette_wheel(num_of_chromosomes, prob_vector);
        member_1 = population{member_1_index};
        member_2 = population{member_2_index};

        % Depending on the crossover rate crossover the bits from each chosen 
        % chromosome at a randomly chosen point
        [new_member_1, new_member_2] = crossover(member_1, member_2, crossover_rate);

        % Step through the chosen chromosomes bits and flip depending on the
        % mutation rate.
        [new_member_1, new_member_2] = mutation(new_member_1, new_member_2, mutation_rate, ...
            max_pertubation);
        
        new_population{new_idx} = new_member_1;
        new_idx = new_idx + 1;
        new_population{new_idx} = new_member_2;
        new_idx = new_idx + 1;        
        if new_idx > num_of_chromosomes
            iter_num = iter_num + 1;      
            population = new_population;
            break;
        end
    end
    close    
end
best_neural_network.num_of_inputs = num_of_inputs;
best_neural_network.num_of_hidden_units = num_of_hidden_units;
best_neural_network.num_of_outputs = num_of_outputs;
best_neural_network.chromosome_id = current_best_idx;