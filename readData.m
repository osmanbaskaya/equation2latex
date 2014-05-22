function [data, labels] = readData(directory)

inputSize = 28*28;

files = dir([directory, '*.png']);
[numFiles, ~] = size(files);
data = zeros(inputSize, numFiles);
labels = zeros(numFiles, 1);
for i=1:numFiles
    file = files(i);
    image_name = [directory, file.name];
    %fprintf('i=%d, %s\n', i, image_name);
    I = imread(image_name);
    I = I(:,:,1);
    data(:,i) = I(:);
    labels(i) = str2num(strtok(file.name, '-'));
end

data(data>0)=1; % be sure that image is black and white.

end
