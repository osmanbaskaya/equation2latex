%clear; close;
load model
%load model-w-encoder
%load opttheta;

inputSize  = 28 * 28;
numLabels  = 5;
hiddenSize = 200;


%% Load our test labels and features, O_O (Osman & Onur) dataset
files = dir('my_images/*.png');
[numFiles, ~] = size(files);
testFeatures = zeros(inputSize, numFiles);
testLabels = zeros(1, numFiles);
for i=1:numFiles
    file = files(i);
    image_name = ['my_images/', file.name];
    fprintf('i=%d, %s\n', i, image_name);
    I = imread(image_name);
    I = I(:,:,1);
    I(I == 25) = 0;
    I = double(imresize(I, 0.25)) / 255;
    %I(I > 1) = 255;
    testFeatures(:,i) = I(:);
    testLabels(i) = str2num(strtok(file.name, '-'));
end

%testFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, testFeatures);


[pred] = softmaxPredict(softmaxModel, testFeatures);
fprintf('Test Accuracy: %f%%\n', 100*mean(pred(:) == testLabels(:)));

