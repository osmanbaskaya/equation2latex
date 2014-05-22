function dataAcquire(input_path, output_path)

imageSize = 28;
files = dir([input_path, '*.png']);
[numFiles, ~] = size(files);
image_no = 1;
for i=1:numFiles
    file = files(i);
    digit = strtok(file.name, '-');
    I = imread([input_path, '/', file.name]);
    I = I(:,:,1);
    CC = bwconncomp(I);
    objects = objectSegmentation(CC, imageSize);
    objects = reshape(objects, imageSize, imageSize, size(objects, 2));
    for j=1:size(objects, 3)
        image_name = sprintf('%s-%d.png', digit, image_no);
        fprintf('%s\n', image_name);
        object = objects(:, :, j);
        imshow(object);
        outFilename = sprintf('%s/%s', output_path, image_name);
        imwrite(object, outFilename);
        image_no = image_no + 1;
    end
end