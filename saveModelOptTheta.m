clear; clc; close all;
[digitData, digit_labels] = readData('digits/');
[opData, op_labels] = readData('operators/');
[data, labels] = combineData(digitData, digit_labels, opData, op_labels);
%opttheta = calculateOptTheta(data);
load opdigit_theta

addpath softmax+autoencoder
addpath softmax+autoencoder/minFunc

inputSize  = 28 * 28;
hiddenSize = 200;  
maxIter = 100;
numLabels = max(labels);

%numLabels  = length(unique(trainLabels));
%numLabels = 10;

options.Method = 'lbfgs'; 
options.maxIter = maxIter;
options.display = 'off';

trainFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
                                       data);


model = softmaxTrain(size(trainFeatures,1),...
            numLabels, ...
            1e-4, trainFeatures, labels, options);

%save opdigit_theta opttheta
save opdigit_model model