function [ vals ] = kl_drv( rho, rho_hats )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
vals=zeros(length(rho_hats),1);
for i = 1:length(rho_hats)
    vals(i) = -1*(rho/rho_hats(i))+((1-rho)/(1-rho_hats(i)));
end

end

