function pos = getPosition(b1, b2)
    if b1(1) + b1(3) > b2(1)
        pos = 0;
    else
        pos = 1;
    end
end