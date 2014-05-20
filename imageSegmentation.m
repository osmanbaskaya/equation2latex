%function preprocessedImage = imageSegmentation(model, filename)

filename = 'equation_images/relativity.png';
ImageSize = 28;
load model;

I = imread(filename);
I = I(:,:, 1);
CC = bwconncomp(I);
objects = objectSegmentation(CC, ImageSize);


%% Classification

preds = softmaxPredict(softmaxModel, objects);

%% Relativity

positions = getRelativePositions(CC);


%% Latex Mapping

getLatexMapping(preds, positions);







%end