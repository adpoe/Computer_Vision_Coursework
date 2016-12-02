%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #11
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load file data for Part IV
load('weights_inputs.mat');

% loop over each dimension of W1, and compute the derivative
% --> make W1 into a vector W1(:)
W = W1(:);
W_plus_h = zeros(size(W));
h = 0.0001;

% gather values for W+h
for index = 1:size(W,1)
    W_plus_h(index) = W_plus_h(index) + h;
end

% --> use reshape to reshape any intermediate W1_plus_h (needed in process
% of computing the derivative, back to a 4x25 matrix
%  Note:  make changes to the dimensions of the weight vector one at a time
%         so keep an original version of the weight vector before any
%         changes were made, and reset that weight vector to the original,
%         each time you loop.

% reshape both vectors
% >>>>>>
W = reshape(W, [4,25]);
% >>>>>>
W_plus_h = reshape(W_plus_h, [4,25]);

% compute SVM loss for W and W_plus_h
% Scores for W1
scores(:,1,1) = x1 .* W1(1,:)';
scores(:,2,1) = x2 .* W1(2,:)';
scores(:,3,1) = x3 .* W1(3,:)';
scores(:,4,1) = x4 .* W1(4,:)';

% Scores for W_Plus_H
% Scores for W1
scores_h(:,1,1) = x1 .* W_plus_h(1,:)';
scores_h(:,2,1) = x2 .* W_plus_h(2,:)';
scores_h(:,3,1) = x3 .* W_plus_h(3,:)';
scores_h(:,4,1) = x4 .* W_plus_h(4,:)';

% flatten into vectors again
W = W(:);
W_plus_h = W_plus_h(:);
G = size(W); % gradient calculation results
% Now, compute the gradient! 
for index = 1:size(W,1)
   % calculate: f(x+h) - f(x) / h
   % store it in G.
   G = (W_plus_h - W)/h;
end

% stack the derivatives together, & output result vector as gradient
disp('Resulting Gradient Vector, with (h=0.0001) is: \n');
G
G = reshape(G, [4,25]);

% stack the scores into a 3-d vector, only so we don't have to re-write the
% SVM_loss code, which was hard coded to work with the previous example
scores_gradient(:,1,3) = x1 .* G(1,:)';  
scores_gradient(:,2,3) = x2 .* G(2,:)';
scores_gradient(:,3,3) = x3 .* G(3,:)';
scores_gradient(:,4,3) = x4 .* G(4,:)';

% use SVM loss to compute the loss for that weight vector over all examples
% only the THIRD DIMENSION matters here, because that's all we loaded in
% the scores gradient. This is kind of a hack, but it'll work for our
% purposes.
loss_x1 = SVM_loss(scores_gradient, 1);
loss_x1 = loss_x1(3);

loss_x2 = SVM_loss(scores_gradient, 2);
loss_x2 = loss_x2(3);

loss_x3 = SVM_loss(scores_gradient, 3);
loss_x3 = loss_x3(3);

loss_x4 = SVM_loss(scores_gradient, 4);
loss_x4 = loss_x4(3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% after you compute the gradient, also show the result of a weight update
% with learning rate of 0.001
W = W_plus_h(:);
W_plus_h = zeros(size(W));
h = 0.001;

% gather values for W+h
for index = 1:size(W,1)
    W_plus_h(index) = W_plus_h(index) + h;
end

% --> use reshape to reshape any intermediate W1_plus_h (needed in process
% of computing the derivative, back to a 4x25 matrix
%  Note:  make changes to the dimensions of the weight vector one at a time
%         so keep an original version of the weight vector before any
%         changes were made, and reset that weight vector to the original,
%         each time you loop.

% reshape both vectors
% >>>>>>
W = reshape(W, [4,25]);
% >>>>>>
W_plus_h = reshape(W_plus_h, [4,25]);

% compute SVM loss for W and W_plus_h
% Scores for W1
scores(:,1,1) = x1 .* W1(1,:)';
scores(:,2,1) = x2 .* W1(2,:)';
scores(:,3,1) = x3 .* W1(3,:)';
scores(:,4,1) = x4 .* W1(4,:)';

% Scores for W_Plus_H
% Scores for W1
scores_h(:,1,1) = x1 .* W_plus_h(1,:)';
scores_h(:,2,1) = x2 .* W_plus_h(2,:)';
scores_h(:,3,1) = x3 .* W_plus_h(3,:)';
scores_h(:,4,1) = x4 .* W_plus_h(4,:)';

% flatten into vectors again
W = W(:);
W_plus_h = W_plus_h(:);
G = size(W); % gradient calculation results
% Now, compute the gradient! 
for index = 1:size(W,1)
   % calculate: f(x+h) - f(x) / h
   % store it in G.
   G = (W_plus_h - W)/h;
end

% stack the derivatives together, & output result vector as gradient
G = reshape(G, [4,25]);

% stack the scores into a 3-d vector, only so we don't have to re-write the
% SVM_loss code, which was hard coded to work with the previous example
scores_gradient(:,1,3) = x1 .* G(1,:)';  
scores_gradient(:,2,3) = x2 .* G(2,:)';
scores_gradient(:,3,3) = x3 .* G(3,:)';
scores_gradient(:,4,3) = x4 .* G(4,:)';

% use SVM loss to compute the loss for that weight vector over all examples
% only the THIRD DIMENSION matters here, because that's all we loaded in
% the scores gradient. This is kind of a hack, but it'll work for our
% purposes.
loss_x1 = SVM_loss(scores_gradient, 1);
loss_x1 = loss_x1(3);

loss_x2 = SVM_loss(scores_gradient, 2);
loss_x2 = loss_x2(3);

loss_x3 = SVM_loss(scores_gradient, 3);
loss_x3 = loss_x3(3);

loss_x4 = SVM_loss(scores_gradient, 4);
loss_x4 = loss_x4(3);
