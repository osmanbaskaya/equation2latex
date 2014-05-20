%% Parameter test script

% binary, encoder/vanilla

inputType = [0, 1];
modelTypes = {'softmax+autoencoder'};
inputSizes = linspace(10000, 30000, 5);
%inputSizes = 20:10:100;


for i=1:length(modelTypes)
    modelType = modelTypes{i};
    cd(modelType)
    for isBinary=inputType
        for inputSize=inputSizes
            if strcmpi('softmax+autoencoder', modelType)
                [model, trainAcc, theta] =  trainOnMnist(inputSize, isBinary);
                testAcc = testOnMy(model, theta);
            else 
                [model, trainAcc] =  trainOnMnist(inputSize, isBinary);
                testAcc = testOnMy(model);
            end
            
            fprintf('%s\t%d\t%d\t%.3f%%\t%.3f%%\n', modelType, inputSize, ...
                                    isBinary, trainAcc, testAcc);
        end 
    end
    cd('..')
end