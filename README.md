# PingPongGANN
An AI for PingPong using Neural network and Genetic Algorithm. The graphics of this program is hacked from https://www.mathworks.com/matlabcentral/fileexchange/45619-pingpong-game?focused=3809624&tab=function

You can watch the AI train from scratch (run.m) or you can just run the pretrained model (run_pretrained.m)

When run.m is run, it constantly shows new figures for each chromosome, so if you don't want to be distracted too much by the 
figures, you should dock it. First, type this command:

        figure
    
Then, dock the figure: https://stackoverflow.com/questions/8488758/inhibit-matlab-window-focus-stealing (texnic's answer)

Afterwards, type this command:

        set(0, 'DefaultFigureWindowStyle', 'docked');
    
Then run the file. The same goes for run_pretrained.m

The algorithm used in PingPongGANN
------------
Here I use genetic algorithm to train a neural network, which will play the PingPong game.

The neural network is encoded as a sequence of real numbers. Crossover is performed in the same way as with binary sequences. Mutation is performed by pertubing the weights with a random (real) number.

Here I only use a simple 1-hidden layer neural network, with logistic sigmoid activation function. There are 2 output class, "uparrow" and "downarrow". There is no class "donothing" so sometimes you will see the patch juggle around in one place. The input to the network is the difference between the position of the ball and the patch position. The fitness function is simply the game score.

The design of the neural network and the genetic algorith follows closely from the book 

                AI techniques for game programming - Mat Buckland
Some results
------------
Maybe due to the fact that this is a very simple game, the results has been a little bit weird.

Firstly, when I used 10 hidden units, the network simply follows the ball very closely. Perharps it learns to follow whatever direction the ball is moving in the y-axis.

![](https://user-images.githubusercontent.com/20016033/42417879-4ad01d24-82be-11e8-90f3-27671f8647eb.gif?raw=true "")

Secondly, when I used 3 hidden units, the network just goes upwards, but when the ball closes in the networks moves in very quickly and pushes the ball away, which is quite weird.

![](https://user-images.githubusercontent.com/20016033/42418031-927c6328-82c1-11e8-86f2-6d8a749ee447.gif?raw=true "")

Enjoy!
