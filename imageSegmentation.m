%function preprocessedImage = imageSegmentation(model, modelType, filename)
clear; close
filename = 'equation_images/relativity2.png';
modelType = 'softmax/';
ImageSize = 28;
addpath(modelType);
load model;


I = imread(filename);
I = I(:,:, 1);
CC = bwconncomp(I);
objects = objectSegmentation(CC, ImageSize);

preds = [3, 5, 0, 2, 11, 5];

%% Classification

%preds = softmaxPredict(softmaxModel, objects);

%% Relativity

positions = getRelativePositions(CC, preds);


%% Latex Mapping

getLatexMapping(preds, positions);







%end