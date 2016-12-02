function [ loss_for_each_weight_set ] = softmax_loss(scores, correct_index)
%   take in a vector of f(x) results for each x_i and weight grouping
%   calculate loss (L_i) for each
%   return a vector with loss for each weight class

j = correct_index; % correct IMAGE index
L = [0,0,0]; % we have 3 weights to calculate, so do it all at once, and return a vector
N = size(scores,2); % N=Number of images

% iterate through all images
for y_i = 1:N 
    
    % taking sums across all dimensions because we have 25xN vectors,
    % so not sure how else to handle this.
    L_i_1 = -log(exp(sum(scores(:,y_i,1)))/sum(scores(:,j,1))); %max(0, sum(scores(:,j,1) - scores(:,y_i,1)) + 1);
    L_i_2 = -log(exp(sum(scores(:,y_i,2)))/sum(scores(:,j,2))); %max(0, sum(scores(:,j,2) - scores(:,y_i,2)) + 1);
    L_i_3 = -log(exp(sum(scores(:,y_i,3)))/sum(scores(:,j,3))); %max(0, sum(scores(:,j,3) - scores(:,y_i,3)) + 1);
    
    % increment our total loss value, each iteration
    L(1) = L(1) + L_i_1;
    L(2) = L(2) + L_i_2;
    L(3) = L(3) + L_i_3;

end

% return the final loss vector
loss_for_each_weight_set = L/N;

end

