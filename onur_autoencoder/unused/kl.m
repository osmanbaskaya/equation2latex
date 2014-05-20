function [ val ] = kl( rho, rho_hats )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
val=0;
for j = 1:length(rho_hats)
    val = val + (rho*log(rho/rho_hats(j))) ....
    + ((1-rho)*(log((1-rho)/(1-rho_hats(j)))));
end

end

