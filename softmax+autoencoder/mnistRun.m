clc,clear;
inputSize  = 28 * 28;
hiddenSize = 200;
sparsityParam = 0.1; % desired average activation of the hidden units.
                    		            
lambda = 3e-3;       % weight decay parameter       
beta = 3;            % weight of sparsity penalty term   
maxIter = 100;

trainData = loadMNISTImages('mnist/train-images-idx3-ubyte');
trainLabels = loadMNISTLabels('mnist/train-labels-idx1-ubyte');

trainData = trainData(:, 1:10000);
trainData(trainData > 0) = 1;
trainLabels = trainLabels(1:10000);

trainLabels(trainLabels==0) = 10; % Remap 0 to 10
numLabels  = length(unique(trainLabels));

testData = loadMNISTImages('mnist/t10k-images-idx3-ubyte');
testData(testData > 0) = 1;
testLabels = loadMNISTLabels('mnist/t10k-labels-idx1-ubyte');
testLabels(testLabels==0) = 10; % Remap 0 to 10

theta = initializeParameters(hiddenSize, inputSize);

addpath minFunc/
options.Method = 'lbfgs'; 
options.maxIter = maxIter;
options.display = 'on';

visibleSize = inputSize;
[opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
                                   visibleSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, trainData), ...
                              theta, options);
save opttheta-bin opttheta                         

trainFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
                                       trainData);

testFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
                                       testData);

softmaxModel = softmaxTrain(size(trainFeatures,1),...
            numLabels, ...
            1e-4, trainFeatures, trainLabels, options);

save softmaxModel-bin softmaxModel       

pred = softmaxPredict(softmaxModel, testFeatures);

fprintf('Test Accuracy: %f%%\n', 100*mean(pred(:) == testLabels(:)));
