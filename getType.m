function type = getType(pred)

% 0 -> digits
% 1 -> operator
% 2 -> Sigma, Pi


if pred <= 10
    type = 0;
elseif pred >= 11 && pred <= 14
    type = 1;
else
    type = 2;
end