function model = trainOnMnist(numTrain, isBinary)
inputSize = 28 * 28; % Size of input vector (MNIST images are 28x28)
numClasses = 10;     % Number of classes (MNIST images fall into 10 classes)

lambda = 1e-4; % Weight decay parameter

images = loadMNISTImages('mnist/train-images-idx3-ubyte');
labels = loadMNISTLabels('mnist/train-labels-idx1-ubyte');
labels(labels==0) = 10; % Remap 0 to 10

inputData = images(:,1:numTrain);
if isBinary
    inputData(inputData>0)=1;
end

% Randomly initialise theta
theta = 0.005 * randn(numClasses * inputSize, 1);

[cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, inputData, labels);
options.maxIter = 100;
softmaxModel = softmaxTrain(inputSize, numClasses, lambda, ...
                            inputData, labels, options); 

images = loadMNISTImages('mnist/t10k-images-idx3-ubyte');
labels = loadMNISTLabels('mnist/t10k-labels-idx1-ubyte');
labels(labels==0) = 10; % Remap 0 to 10

inputData = images;
inputData(inputData>0)=1;

% You will have to implement softmaxPredict in softmaxPredict.m
[pred] = softmaxPredict(softmaxModel, inputData);

acc = mean(labels(:) == pred(:));
fprintf('Accuracy: %0.3f%%\n', acc * 100);
end
