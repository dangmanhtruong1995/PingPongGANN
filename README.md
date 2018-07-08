# PingPongGANN
An AI for PingPong using Neural network and Genetic Algorithm

You can watch the AI train from scratch (run.m) or you can just run the pretrained model (run_pretrained.m)

When run.m is run, it constantly shows new figures for each chromosome, so if you don't want to be distracted too much by the 
figures, you should dock it. First, type this command:
    figure
    
Then, dock the figure. 

Afterwards, type this command:
    set(0, 'DefaultFigureWindowStyle', 'docked');
    
Then run the file. The same goes for run_pretrained.m

# The algorithm used in PingPongGANN

Here I use genetic algorithm to train a neural network, which will play the PingPong game.

The neural network is encoded as a sequence of real numbers. Crossover is performed in the same way as with binary sequences. Mutation is performed by pertubing the weights with a random (real) number.

Here I only use a simple 1-hidden layer neural network. But maybe due to the fact that this is a very simple game, the results has been a little bit weird.

https://user-images.githubusercontent.com/20016033/42417879-4ad01d24-82be-11e8-90f3-27671f8647eb.gif
