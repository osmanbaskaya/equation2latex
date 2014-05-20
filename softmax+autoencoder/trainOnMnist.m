function [model, acc, opttheta] = trainOnMnist(numTrain, isBinary)


inputSize  = 28 * 28;
hiddenSize = 200;
sparsityParam = 0.1; % desired average activation of the hidden units.
                    		            
lambda = 3e-3;       % weight decay parameter       
beta = 3;            % weight of sparsity penalty term   
maxIter = 100;

trainData = loadMNISTImages('mnist/train-images-idx3-ubyte');
trainLabels = loadMNISTLabels('mnist/train-labels-idx1-ubyte');

trainData = trainData(:, 1:numTrain);
if isBinary
    trainData(trainData > 0) = 1;
end
trainLabels = trainLabels(1:numTrain);

trainLabels(trainLabels==0) = 10; % Remap 0 to 10
numLabels  = length(unique(trainLabels));

testData = loadMNISTImages('mnist/t10k-images-idx3-ubyte');
if isBinary
    testData(testData > 0) = 1;
end

testLabels = loadMNISTLabels('mnist/t10k-labels-idx1-ubyte');
testLabels(testLabels==0) = 10; % Remap 0 to 10

theta = initializeParameters(hiddenSize, inputSize);

addpath minFunc/
options.Method = 'lbfgs'; 
options.maxIter = maxIter;
options.display = 'off';

visibleSize = inputSize;
[opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
                                   visibleSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, trainData), ...
                              theta, options);

trainFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
                                       trainData);

testFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
                                       testData);

model = softmaxTrain(size(trainFeatures,1),...
            numLabels, ...
            1e-4, trainFeatures, trainLabels, options);


pred = softmaxPredict(model, testFeatures);
acc = mean(testLabels(:) == pred(:));

end