function [training, trainLabels, test, testLabels] = divideData(data, labels, testDataSize)

idx = randperm(size(data, 2));
testIdx = idx(1:testDataSize);
trainIdx = idx(testDataSize+1:end);
test = data(:, testIdx);
testLabels = labels(testIdx);
training = data(:, trainIdx);
trainLabels = labels(trainIdx);

end