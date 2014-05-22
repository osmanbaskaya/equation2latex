function [accuracy, acc_std] = calculateSoftAccuracy(data, labels, numRun)

numInst = size(data, 2);
accs = zeros(1, numRun);

for i=1:numRun
    [training, taLabels, test, teLabels] = divideData(data, labels, floor(numInst/5));
    acc = softGetAccuracy(training, taLabels, test, teLabels);
    accs(i) = acc;
end

accuracy = mean(accs);
acc_std = std(accs, 1);

end
