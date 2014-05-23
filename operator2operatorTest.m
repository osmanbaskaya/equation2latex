clear; clc; close all;
[digitData, digitLabels] = readData('digits/');
[opData, opLabels] = readData('operators/');
[data, labels] = combineData(digitData, digitLabels, opData, opLabels);
[acc, acc_std] = calculateSoftAutoAccuracy(data, labels, 'opdigit_theta', 5)