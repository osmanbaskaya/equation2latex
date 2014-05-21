function image2eq(filename)


%% Model Loading

modelType = 'softmax+autoencoder/';
addpath(modelType);
addpath('models/');
load softmax+autoencoder-55000-1
load theta-55000-1

ImageSize = 28;
I = imread(filename);
I = I(:,:, 1);

CC = bwconncomp(I);
objects = objectSegmentation(CC, ImageSize);

%% Classification

%preds = softmaxPredict(softmaxModel, objects);
preds = [15 3 2 11 5 4];


%% Relativity

expression = getExpression(CC, preds);
disp(expression);

end