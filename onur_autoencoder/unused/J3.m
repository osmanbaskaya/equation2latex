function [ cost, grad ] = J3( theta, visibleSize, hiddenSize, data, beta, sParam)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
W1 = reshape(theta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
W2 = reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize), visibleSize, hiddenSize);
b1 = theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
b2 = theta(2*hiddenSize*visibleSize+hiddenSize+1:end);

m = length(data);
grad = zeros(length(theta),1);
cost = 0;

a1=data;
z2 = W1 * data + repmat(b1,1,m);
a2 = sigmoid(z2);
% z3 = W2 * a2 + repmat(b2,1,m);
% h = sigmoid(z3);
% a3 = h;
% delta3 = -1*(data-a3) .* a3 .* (1 - a3);

rHats = mean(a2')/m;
cost = beta*kl(sParam,rHats);

vk = kl_drv(sParam, rHats);
delta2 = repmat(vk,1,length(a2)) .* a2 .* (1-a2);

W1grad = delta2*a1';
W2grad = zeros(size(W2));
b1grad = sum(delta2');
b2grad = zeros(size(b2));
grad = [W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)];
end

