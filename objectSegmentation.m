function objects = objectSegmentation(CC, ImageSize)

padding = 3;
objects = zeros(ImageSize*ImageSize, CC.NumObjects);

for i=1:CC.NumObjects
    J = zeros(CC.ImageSize);
    J(CC.PixelIdxList{i}) = 1;
    Regions = regionprops(CC);
    box = floor(Regions(i).BoundingBox);
    object = J(box(2):box(2) + box(4), box(1):box(1) + box(3));
    object = imresize(object, [ImageSize-2*padding, ImageSize-2*padding]);
    object = padarray(object, [padding, padding]);
    % Check this 5 later.
    object(object > 5) = 255;
    %figure, imshow(object);
    % print( h, '-dpng', 'foo') should be tested.
    objects(:, i) = object(:);
end



end