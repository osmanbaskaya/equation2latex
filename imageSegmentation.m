%function preprocessedImage = imageSegmentation(filename)


clear, close all
filename = 'equation_images/resize.png';
ImageSize = 28;
load model

I = imread(filename);
I = I(:,:, 1);
CC = bwconncomp(I);
objects = objectSegmentation(CC, ImageSize);


%% Classification

pred = softmaxPredict(softmaxModel, objects)


%% Relativity


%% Latex Mapping








%end