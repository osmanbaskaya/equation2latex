function objects = objectSegmentation2(CC, ImageSize)

padding = 3;
objects = zeros(ImageSize*ImageSize, CC.NumObjects);

Regions = regionprops(CC);

for i=1:CC.NumObjects
    objBox = floor(Regions(i).BoundingBox);
    diff = abs(objBox(3)-objBox(4));
    imagePadding = diff + 1;
    J = zeros(CC.ImageSize);
    J(CC.PixelIdxList{i}) = 1;
    J = padarray(J, [imagePadding, imagePadding]); 
    objBox(1:2) = objBox(1:2) + imagePadding;
    objBox(objBox == 0) = 1;
    slide = floor(diff / 2);
    if objBox(3) > objBox(4)
        object = J(objBox(2)-slide:objBox(2) + objBox(4)+slide, objBox(1):objBox(1) + objBox(3));
    else
        object = J(objBox(2):objBox(2) + objBox(4), objBox(1)-slide:objBox(1) + objBox(3)+slide);
    end
    imshow(object)
    object = imresize(object, [ImageSize-2*padding, ImageSize-2*padding]);
    object = padarray(object, [padding, padding]);
    % print( h, '-dpng', 'foo') should be tested
    imshow(object);
    objects(:, i) = object(:);
end
end