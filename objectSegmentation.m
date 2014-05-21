function objects = objectSegmentation(CC, ImageSize)

padding = 3;
objects = zeros(ImageSize*ImageSize, CC.NumObjects);

Regions = regionprops(CC);

for i=1:CC.NumObjects
    J = zeros(CC.ImageSize);
    J(CC.PixelIdxList{i}) = 1;
    box = floor(Regions(i).BoundingBox);
    box(box == 0) = 1;
    object = J(box(2):box(2) + box(4), box(1):box(1) + box(3));
    object = imresize(object, [ImageSize-2*padding, ImageSize-2*padding]);
    object = padarray(object, [padding, padding]);
    % Check this 5 later.
    object(object > 5) = 1;
    %figure, imshow(object);
    % print( h, '-dpng', 'foo') should be tested.
    objects(:, i) = object(:);
end



end