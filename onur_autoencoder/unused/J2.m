function [ cost, grad ] = J2( theta, visibleSize, hiddenSize, data, lambda)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
W1 = reshape(theta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
W2 = reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize), visibleSize, hiddenSize);
b1 = theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
b2 = theta(2*hiddenSize*visibleSize+hiddenSize+1:end);
m = length(data);
grad = zeros(length(theta),1);
cost = 0;

cost = (lambda/2)*(sum(sum(W1.^2)) + sum(sum(W2.^2)));


W1grad = W1;
W2grad = W2;
b1grad = zeros(1,length(b1));
b2grad = zeros(1,length(b2));
grad = lambda*[W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)];
end

