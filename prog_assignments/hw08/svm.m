%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #08
% Fall 2016
%
%   "svm.m"
%       - Calls the appropriate train/test functions
%       - Computes the accuracy on "set B" from an SVM that sees the images
%       in "set B" (unlike the zero-shot which does not and only sees the
%       attributes of the images in "set B"
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To start, load the data computed by 'zero_shot_setup.m'
% >>>> UPDATE THIS TO WORK ON YOUR RELATIVE PATH!!!
load('/Users/tony/Documents/MATLAB/CS1674-HW08/zero_shot_setup.mat')

% compute an SVM training model using set A 
svm_model = fitcecoc(set_A_samples, set_A_animals);

% compute the SVM test function, predicting output for set B
labels = predict(svm_model, set_B_samples);

% ensure our sizes are correct 
assert(size(labels,1) == size(set_B_animals,1))
assert(size(labels,2) == size(set_B_animals,2))

% compare our predicted labels with the true set B animals
% count correct predictions
correct_predictions = 0;
for i = 1:size(labels,1)
    if labels(i) == set_B_animals(i)
        correct_predictions = correct_predictions + 1;
    end
end

% print results
fprintf ('SVM RESULTS:  %f percent of predictions were correct\n\n', double(correct_predictions / size(labels,1)) ) 



% Compute accuracy on Set B with an SVM
% for i = 1:num_attributes
%     fprintf('Now processing attribute: %u/%u\n', i, num_attributes);
%     tic
%     % train an SVM to predict present/not for this attribute
%     model = fitcsvm(train_samples, train_attributes(:, i));
%     % convert the model so it can produce probabilities
%     model_probs = fitSVMPosterior(model);
%     % apply the model on the test samples
%     [~, scores] = predict(model_probs, set_B_samples);
%     % make sure proper probabilities, i.e. P(yes|feature)+P(no|feature)=1
%     assert(all(sum(scores, 2) == 1));
%     % store for later use
%     attr_probs{i} = scores;
%     toc
% end