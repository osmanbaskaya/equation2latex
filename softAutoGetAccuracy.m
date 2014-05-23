function [acc, model, opttheta] = softAutoGetAccuracy(trainData, trainLabels, testData, testLabels, thetaFile)

addpath softmax+autoencoder
addpath softmax+autoencoder/minFunc
load(thetaFile);

inputSize  = 28 * 28;
hiddenSize = 200;  
maxIter = 100;

%numLabels  = length(unique(trainLabels));
%numLabels = 10;
numLabels = max(trainLabels);

options.Method = 'lbfgs'; 
options.maxIter = maxIter;
options.display = 'off';

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