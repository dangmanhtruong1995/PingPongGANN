function [output] = neural_network_decision(neural_network, input )
z = logsig(neural_network.w1 * [1; input]);
% z = neural_network.w1 * [1; input];
% output = logsig(neural_network.w2 * [1; z]);
output = neural_network.w2 * [1; z];
disp('');
end

