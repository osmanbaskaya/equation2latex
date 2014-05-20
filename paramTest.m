%% Parameter test script

% binary, encoder/vanilla

inputType = [0, 1];
modelTypes = {'softmax', 'softmax+autoencoder'};
inputSizes = linspace(10000, 60000, 11);

for i=1:length(modelTypes)
    modelType = modelTypes{i};
    cd(modelType)
    for isBinary=inputType
        for inputSize=inputSizes
            modelFile = sprintf('../models/%s-%d-%d', modelType, inputSize, isBinary);
            if strcmpi('softmax+autoencoder', modelType)
                [model, trainAcc, theta] =  trainOnMnist(inputSize, isBinary);
                testAcc = testOnMy(model, theta);
                save(modelFile, 'model');
                thetaFile = sprintf('../models/theta-%d-%d', inputSize, isBinary);
                save(thetaFile, 'theta');
            else 
                [model, trainAcc] =  trainOnMnist(inputSize, isBinary);
                testAcc = testOnMy(model);
                save(modelFile, 'model');
            end
            fprintf('%s\t%d\t%d\t%.3f%%\t%.3f%%\n', modelType, inputSize, ...
                                    isBinary, trainAcc, testAcc);
        end 
    end
    cd('..')
end
