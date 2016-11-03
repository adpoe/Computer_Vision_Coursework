%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #08
% Fall 2016
%
%   "zero_shot.m"
%       - Implements zero-shot recognition
%       - Prints the average accuracy onn"set B" from zero-shot recognition
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To start, load the data computed by 'zero_shot_setup.m'
% >>>> UPDATE THIS TO WORK ON YOUR RELATIVE PATH!!!
load('/Users/tony/Documents/MATLAB/CS1674-HW08/zero_shot_setup.mat')


% To perform the classification of a query image from "SET B", assign it to
% a test class (out of 10) whose attribute "signature" it matches the best.
% The probabilities for each image are stored in the 1st and 2nd columns,
% respectively, in the variable attr_probs --> an 85x1 cell array --> 85
% attributes total
%       WHERE: attr_probs{i} = [243x2 double]
%       attr_probs{1}(1,2)

% GIVEN:  Set_B_Attributes --> 243x85 double
%             WHERE:  (i,j) tells us if the ith class has the jth attribute
%         scores --> 243 --> 2 double


% create our labels output value
labels = zeros(size(set_B_attributes, 1),1);

% iterate through all classes
for i = 1:size(set_B_attributes,1)
    
    % create array to hold all of our probs
    all_probs = []; 
    
    % iterate through all attributes
    for j = 1:num_attributes
        probs = [];
        
        % Use set_B_attributes to find out which probability set we should use
        x = set_B_attributes(i,j);
        
        % 0 = attr_probs{i}(:,1)
        if x == 0
            probs = attr_probs{j}(:,1);
        end
        
        % 1 = attr_probs{i}(:,2)
        if x == 1
            probs = attr_probs{j}(:,2);
        end
        
        % get probs as a row vector so we can vertcat
        probs = probs';
        
        % cat all probs for this vector
        all_probs = vertcat(all_probs, probs);
 
    end
    
    % take the product of all our probs
    products = prod(all_probs, 1);
    
    % find the best match
    [~, ind] = max(all_probs);
    
    % store this match in labels
    labels(i,:) = max(ind);
end


correct_predictions = 0;
labels = ind';
for i = 1:size(labels,1)
    if labels(i) == set_B_animals(i)
        correct_predictions = correct_predictions + 1;
    end
end

% print results
fprintf ('ZERO SHOT RESULTS:  %f percent of predictions were correct\n\n', double(correct_predictions / size(labels,1)) ) 

