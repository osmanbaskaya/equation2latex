function image2eq(filename)


%% Model Loading

modelType = 'softmax+autoencoder/';
addpath(modelType);
%addpath('models/');
load opdigit_model
load opdigit_theta

ImageSize = 28;
I = imread(filename);
I = I(:,:, 1);
I = I(50:740, 122:948); % Croping uncessesary regions (IPAD)

whiteIdx = I>100;
blackIdx = I<=100;
I(whiteIdx) = 0;
I(blackIdx) = 255;

CC = bwconncomp(I);
objects = objectSegmentation(CC, ImageSize);

%% Classification

testFeatures = feedForwardAutoencoder(opttheta, 200, 28*28, ...
                                       objects);

preds = softmaxPredict(model, testFeatures);
%preds = [15 3 2 11 5 4];


%% Relativity

expression = getExpression(CC, preds);
disp(expression);

end