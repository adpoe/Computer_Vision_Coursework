%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #11
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load file data for Part IV
load('weights_inputs.mat');

% goal: determine which set of weights results in the smallest SVM LOSS
% first image, (x1) is of class 1; second is of class 2, etc.
% define the the loss function to be: f(x) = W*x

% build scores vector that is 25x4x3 -- Scores-x-Image-x-Weight
% Scores for W1
scores(:,1,1) = x1 * W1(1);
scores(:,2,1) = x2 * W1(2);
scores(:,3,1) = x3 * W1(3);
scores(:,4,1) = x4 * W1(4);
% Scores for W2
scores(:,1,2) = x1 * W2(1);
scores(:,2,2) = x2 * W2(2);
scores(:,3,2) = x3 * W2(3);
scores(:,4,2) = x4 * W2(4);
% Scores for W3
scores(:,1,3) = x1 * W3(1);
scores(:,2,3) = x2 * W3(2);
scores(:,3,3) = x3 * W3(3);
scores(:,4,3) = x4 * W3(4);

% get the svm_Loss for each of our indices
svm_weights_im01 = SVM_loss(scores, 1);
svm_weights_im02 = SVM_loss(scores, 2);
svm_weights_im03 = SVM_loss(scores, 3);
svm_weights_im04 = SVM_loss(scores, 4);

% find the total sum for weight weighting, across classes
summed_weights_by_W_class_softmax = (svm_weights_im01 + svm_weights_im02 + svm_weights_im03 + svm_weights_im04);

% goal: determine which set of weights results in smallest SOFTMAX LOSS
sfmax_weights_im01 = softmax_loss(scores, 1);
sfmax_weights_im02 = softmax_loss(scores, 2);
sfmax_weights_im03 = softmax_loss(scores, 3);
sfmax_weights_im04 = softmax_loss(scores, 4);
% find the total sum for weight weighting, across classes
summed_weights_by_W_class = (sfmax_weights_im01 + sfmax_weights_im02 + sfmax_weights_im03 + sfmax_weights_im04);

