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


% THINK:  Scores, attr_probs has all of the P(YES) and P(NO) values
% for our 243 test samples for set B
% "The P(attribute_i = 0|x) and P(attribute_i = 1|x) probabilities are stored as the first and second columns, respectively, in the variable attr_probs{i}."
% You must read the script zero_shot_setup.m to see what exactly lives in attr_probs{i}. 
% There's one row for each data sample for set_B, not for each animal type.
% We're dealing with individual animal examples, not just the animal classes.


% manually enter the actual possible animal numbers we could select
% obtained by examining data in 'set_B_animals' variable,
% which was computed by the 'zero_shot_setup.m' script
possible_animal_list = test_ids;

% for each animal in this list, find which attributes are relevant
attr_list_by_animal = zeros(10,85);  % 10 animals, 85 attributes
probs_by_animal_HAS  = double(zeros(10,85)); % store all positive probs per animal
probs_by_animal_HAS_NOT = double(zeros(10,85)); % store all negative probs, per animal
 
% and store the probs of each
for i = 1:10
    % index into the possible animal list, so we can get data by each
    % animal we are classifying
    index = possible_animal_list(i);
    % iterate through all 85 attributes, per animal
    for j = 1:85
        % Indexing into M gives me the 85 attributes for my 10
        % animals which are unseen, just as classifiers
        % --> store the the attribute's presence 0/1, no/yes
        attr_list_by_animal(i,j) = M(index,j);
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% ZERO-SHOT PREDICTION FUNCTION %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
labels = zeros(243,1);
for test_num = 1:243
    % check which animal we are closest to
    for animal = 1:10
        % for each animal, build a list of probabilities for each attribute
        prob_list_by_animal = ones(10,85);
        
        % go through each attribute and find the value that's relevant
        for attribute = 1:85
            
           % if the animal we're looking at doesn't have attribute
           % then, use the probability from column=1 in attr_probs
            if attr_list_by_animal(animal, attribute) == 0
                prob = attr_probs{attribute}(test_num,1);
                
            % otherwise, we want to use the probability from
            % column=2, for our tests
            else
                prob = attr_probs{attribute}(test_num,2);
                
            end
            
            % and store the relevant attribute probability 
            % for the animal we are evaluating
            prob_list_by_animal(animal,attribute) = prob;
            
        end % end-attribute loop
        
    end % end-animal loop
    
     % get the product of all probabilities by animal
    product_of_probs_by_animal = prod(prob_list_by_animal, 2);
    
    % find the inex with the maximum probability, based on our calculations
    [~, ind] = max(product_of_probs_by_animal);
    
    % map this probability back to the animal numbers in our list
    animal_num = possible_animal_list(ind);
    
    % assign the label corresponding to that animal number
    labels(test_num,1) = animal_num;
    
end % end-test_num loop



% count the number of predictions we've made correctly
correct_predictions = 0;
for i = 1:size(labels,1)
    if labels(i) == set_B_animals(i)
        correct_predictions = correct_predictions + 1;
    end
end

% print results, calculating the number of predictions we've made correctly
fprintf ('ZERO SHOT RESULTS:  %f percent of predictions were correct\n\n', double(correct_predictions / size(labels,1)) ) 

