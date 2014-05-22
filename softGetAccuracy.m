function [acc, model] = softGetAccuracy(trainData, trainLabels, testData, testLabels)

addpath softmax
addpath softmax/minFunc

maxIter = 40;

options.Method = 'lbfgs'; 
options.maxIter = maxIter;
options.display = 'off';

model = softmaxTrain(size(trainData,1),...
            max(trainLabels), ...
            1e-4, trainData, trainLabels, options);

pred = softmaxPredict(model, testData);
acc = mean(testLabels(:) == pred(:));

end