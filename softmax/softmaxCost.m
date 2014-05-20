function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
theta = reshape(theta, numClasses, inputSize);

numCases = size(data, 2);

groundTruth = full(sparse(labels, 1:numCases, 1));
cost = 0;
thetagrad = zeros(numClasses, inputSize);

z = theta * data;
z = bsxfun(@minus, z, max(z, [], 1));
ez = exp(z);
prob = bsxfun(@rdivide, ez, sum(ez));
log_prob = log(prob);
cost = -1/numCases*sum(sum(log_prob .* groundTruth));

% J2
wd = sum(theta .^ 2);
cost = cost + lambda/2*sum(wd);

diff = groundTruth-prob;
thetagrad = -1/numCases*(diff*data') + lambda*theta;

grad = [thetagrad(:)];
end

