clear; close;
load model
%load model-w-encoder
load opttheta;

inputSize  = 28 * 28;
numLabels  = 5;
hiddenSize = 200;


%% Load our test labels and features, O_O (Osman & Onur) dataset
testFeatures = zeros(inputSize, 20);
testLabels = zeros(20, 1);
files = dir('my_images/*.png');
numFiles = size(files);
for i=3:numFiles
    file = files(i);
    I = imread(['my_images/', file.name]);
    I = I(:,:,1);
    I(I == 25) = 0;
    I = double(imresize(I, 0.25)) / 255;
    fprintf('i=%d, %s\n', i, file.name);
    %I(I>0) = 1;
    testFeatures(:,i-2) = I(:);
    testLabels(i-2) = str2num(strtok(file.name, '-'));
end

    
% testFeatures = reshape(testFeatures, inputSize, 20);

%testFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, testFeatures);


[pred] = softmaxPredict(softmaxModel, testFeatures);
fprintf('Test Accuracy: %f%%\n', 100*mean(pred(:) == testLabels(:)));

