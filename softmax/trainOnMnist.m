function [softmaxModel, acc] = trainOnMnist(numTrain, isBinary)
inputSize = 28 * 28; % Size of input vector (MNIST images are 28x28)
lambda = 1e-4; % Weight decay parameter

trainData = loadMNISTImages('mnist/train-images-idx3-ubyte');
trainLabels = loadMNISTLabels('mnist/train-labels-idx1-ubyte');
trainLabels(trainLabels==0) = 10; % Remap 0 to 10
trainData = trainData(:,1:numTrain);
trainLabels = trainLabels(1:numTrain);
numClasses  = length(unique(trainLabels));

if isBinary
    trainData(trainData>0)=1;
end

options.maxIter = 100;
options.display = 'off';
softmaxModel = softmaxTrain(inputSize, numClasses, lambda, ...
                            trainData, trainLabels, options); 

testData = loadMNISTImages('mnist/t10k-images-idx3-ubyte');
testLabels = loadMNISTLabels('mnist/t10k-labels-idx1-ubyte');
testLabels(testLabels==0) = 10; % Remap 0 to 10

if isBinary
    testData(testData>0)=1;
end

% You will have to implement softmaxPredict in softmaxPredict.m
[pred] = softmaxPredict(softmaxModel, testData);

acc = mean(testLabels(:) == pred(:));
% fprintf('Accuracy: %0.3f%%\n', acc * 100);
end
