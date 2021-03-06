function acc = testOnMy(model)

directory = '../digits/';
inputSize=28*28;

%% Load our test labels and features, O_O (Osman & Onur) dataset
files = dir([directory, '*.png']);
[numFiles, ~] = size(files);
inputData = zeros(inputSize, numFiles);
labels = zeros(1, numFiles);
for i=1:numFiles
    file = files(i);
    image_name = [directory, file.name];
    %fprintf('i=%d, %s\n', i, image_name);
    I = imread(image_name);
    I = I(:,:,1);
    inputData(:,i) = I(:);
    labels(i) = str2num(strtok(file.name, '-'));
end

inputData(inputData>0)=1;
[pred] = softmaxPredict(model, inputData);

acc = mean(labels(:) == pred(:));
% fprintf('Accuracy: %0.3f%%\n', acc * 100);
end
