function opttheta = calculateOptTheta(trainData)

addpath softmax+autoencoder
addpath softmax+autoencoder/minFunc

inputSize  = 28 * 28;
hiddenSize = 200;
sparsityParam = 0.1; % desired average activation of the hidden units.
lambda = 3e-3;       % weight decay parameter       
beta = 3;            % weight of sparsity penalty term   
maxIter = 100;

theta = initializeParameters(hiddenSize, inputSize);
options.Method = 'lbfgs'; 
options.maxIter = maxIter;
options.display = 'off';

visibleSize = inputSize;
[opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
                                   visibleSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, trainData), ...
                    theta, options);
                
                
end