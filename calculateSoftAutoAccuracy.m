function [accuracy, acc_std] = calculateSoftAutoAccuracy(data, labels, thetaFile, numRun)

numInst = size(data, 2);
accs = zeros(1, numRun);

for i=1:numRun
    [training, taLabels, test, teLabels] = divideData(data, labels, floor(numInst/5));
    acc = softAutoGetAccuracy(training, taLabels, test, teLabels, thetaFile);
    accs(i) = acc;
end

accuracy = mean(accs);
acc_std = std(accs, 1);

end
