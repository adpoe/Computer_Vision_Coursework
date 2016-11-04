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


% manually enter the actual possible animal numbers we could select
% obtained by examining data in 'set_B_animals' variable,
% which was computed by the 'zero_shot_setup.m' script
possible_animal_list = [6;14;15;18,;24;25;34;39;42;48];

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
        % store the the attribute prescence 0/1, no/yes
        attr_list_by_animal(i,j) = set_B_attributes(index,j);
        
        % store both the positive and negative prob, per animal
        probs_by_animal_HAS(i,j) = attr_probs{j}(index,1);
        probs_by_animal_HAS_NOT(i,j) = attr_probs{j}(index,2);
    end
end


% now, compare these against our test set
labels = zeros(243,1);
for test_num = 1:243
    
    % store total prob for each animal 
    prob_list_by_animal = ones(10,85);
    
    for attr_num = 1:85
        test_attr = set_B_attributes(test_num, attr_num);
        
        % compute values for our animal vs. all 10 of our test animals
        % and see which one is the highest
        % then map that value back to what is stored in the test animal index
        for animal = 1:10
            % if attr==1, then the animal has it
            if test_attr == 1
                prob = probs_by_animal_HAS(animal,attr_num);
            end
            
            % otherwise, the animal does NOT have it
            if test_attr == 0
                prob = probs_by_animal_HAS_NOT(animal,attr_num);
            end
            
            % store the probability corresponding to whether we expect this
            % animal to HAVE or NOT_HAVE the attribute
            prob_list_by_animal(animal,attr_num) = prob;
        end
        
    end
    
    % get the product of all probabilities by animal
    product_of_probs_by_animal = prod(prob_list_by_animal, 2);
    
    % find the inex with the maximum probability, based on our calculations
    [~, ind] = max(product_of_probs_by_animal);
    
    % map this probability back to the animal numbers in our list
    animal_num = possible_animal_list(ind);
    
    % assign the label corresponding to that animal number
    labels(test_num,1) = animal_num;
end


% count the number of predictions we've made correctly
correct_predictions = 0;
for i = 1:size(labels,1)
    if labels(i) == set_B_animals(i)
        correct_predictions = correct_predictions + 1;
    end
end

% print results, calculating the number of predictions we've made correctly
fprintf ('ZERO SHOT RESULTS:  %f percent of predictions were correct\n\n', double(correct_predictions / size(labels,1)) ) 

