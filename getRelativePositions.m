function expression = getRelativePositions(CC, preds)

Regions = regionprops(CC);
boxes = cell(1, CC.NumObjects+2);
boxes{1} = 'star';
for i=2:CC.NumObjects+1
    box = floor(Regions(i-1).BoundingBox);   
    boxes{i} = box;
end
boxes{CC.NumObjects+2} = 'endo';

expression = '';
buffer = '';
for i=1:length(boxes)-2
    b1 = boxes{i};
    b2 = boxes{i+1};
    pred = preds(i);
	type = getType(pred);
    if type == 0;
        if all(b1 == 'star') || (i>1 && getType(preds(i-1)) == 1)
            buffer = sprintf('%s%d', buffer, pred);
        else
            pos = getPosition(b1, b2);
            if pos == 0 % ust
                expression = sprintf('%s%s^%d', expression, buffer, pred);
                buffer = '';
            else
                buffer = sprintf('%s%d', buffer, pred);
            end     
        end
    elseif type == 1
        % TODO: mapping
        expression = sprintf('%s%s%s', expression, buffer, '+');
        buffer = '';
    else
        % TODO: SIGMA vs.
        ex = '';
    end
end

expression = sprintf('%s%s', expression, buffer);

end


