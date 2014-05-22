function [combinedData, combinedLabels] = combineData(data1, labels1, data2, labels2)

combinedData = [data1, data2];
combinedLabels = [labels1; labels2];

end