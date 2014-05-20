function [ cost, grad ] = J1( theta, visibleSize, hiddenSize, data, beta, sParam)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
W1 = reshape(theta(1:hiddenSize*visibleSize), hiddenSize, visibleSize);
W2 = reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize), visibleSize, hiddenSize);
b1 = theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
b2 = theta(2*hiddenSize*visibleSize+hiddenSize+1:end);
m = length(data);
grad = zeros(length(theta),1);

a1=data;
z2 = W1 * data + repmat(b1,1,m);
a2 = sigmoid(z2);
z3 = W2 * a2 + repmat(b2,1,m);
h = sigmoid(z3);
a3 = h;
diff = (data-h);
cost = sum(0.5*(sqrt(sum(diff.^2)).^2))/m;

rHats = mean(a2')';%for sparsity

delta3 = -1*(data-a3) .* a3 .* (1 - a3);
% delta2 = (W2'*delta3) .* a2 .* (1-a2);
vk = kl_drv(sParam, rHats);%for sparsity
W2_delta3 = W2'*delta3;
delta2 = (W2_delta3 + beta*repmat(vk,1,length(W2_delta3))) .* a2 .* (1-a2);

% costJ3
y = kl(sParam,rHats);
costJ3 = beta*kl(sParam,rHats);
cost = cost + costJ3;

W1grad = delta2*a1';
W2grad = delta3*a2';
b1grad = sum(delta2');
b2grad = sum(delta3');

grad = [W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)]./m;
end

