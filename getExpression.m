function expression = getExpression(CC, preds)

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
    character = getCharacter(pred);
    if type == 0;
        if all(b1 == 'star') || (i>1 && getType(preds(i-1)) == 1)
            buffer = sprintf('%s%s', buffer, character);
        else
            pos = getPosition(b1, b2);
            if pos == 0 % ust
                expression = sprintf('%s%s**%s', expression, buffer, character);
                buffer = '';
            else
                buffer = sprintf('%s%s', buffer, character);
            end     
        end
    elseif type == 1
        expression = sprintf('%s%s%s', expression, buffer, character);
        buffer = '';
    else
        expression = sprintf('%s%s', expression, character);
    end
end
expression = sprintf('%s%s', expression, buffer);
end


function character = getCharacter(label)
    if label <= 9
       character = num2str(label);
    elseif label == 10
        character = '0';
    elseif label == 11;
        character = '+';
    elseif label == 12;
        character = '-';
    elseif label == 13; % \times
        character = '*';
    elseif label == 14;
        character = '/';
    elseif label == 15; % \sigma
        character = 'S'; 
    elseif label == 16; % \prod
        character = 'P';
    end
end




