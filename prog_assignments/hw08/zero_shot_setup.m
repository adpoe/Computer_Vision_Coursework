% zero_shot_setup
% Author: Adriana Kovashka
   
[~, classes] = textread('classes.txt', '%u %s');
[train_classes] = textread('trainclasses.txt', '%s');
[test_classes] = textread('testclasses.txt', '%s');
M = load('predicate-matrix-binary.txt');
num_animals = size(M, 1);
assert(num_animals == length(classes));
num_attributes = size(M, 2);

train_samples = [];
train_animals = [];
train_attributes = [];
set_A_samples = [];
set_A_animals = [];
set_A_attributes = [];
set_B_samples = [];
set_B_animals = [];
set_B_attributes = [];

max_samples_per_class = 50; % set to e.g. 50 if you want to use less, or Inf if you want to use all

% for all classes/animals
for i = 1:num_animals
    fprintf('Now processing animal class: %u/%u\n', i, num_animals);
    tic
    % get the list of files we have for that animal
    samples_this_animal = dir(strcat('sift-hist/', classes{i}, '/*.txt'));
    samples_this_animal = {samples_this_animal(:).name}; 
    % for each file, capped at the max number of files to be used per animal
    for j = 1:min(length(samples_this_animal), max_samples_per_class)
        % load file, contains a histogram computed from SIFT features
        this_sample = load(strcat('sift-hist/', classes{i}, '/', samples_this_animal{j}));
        % if it's a training sample (i.e. belongs to one of the training 
        % classes), put the features, animal ID, and attribute labels, in 
        % the corresponding variable, for the train set
        if(any(strcmp(classes{i}, train_classes)))
            train_samples = [train_samples; this_sample];
            train_animals = [train_animals; i];
            train_attributes = [train_attributes; M(i, :)];
        % otherwise, put in corresponding variables for test set
        % YOU CAN USE THE BELOW VARIABLES IN YOUR CODE!!!
        elseif(rand(1, 1) <= 0.5) % flip a coin
            set_A_samples = [set_A_samples; this_sample];
            set_A_animals = [set_A_animals; i];
            set_A_attributes = [set_A_attributes; M(i, :)];
        else
            set_B_samples = [set_B_samples; this_sample];
            set_B_animals = [set_B_animals; i];
            set_B_attributes = [set_B_attributes; M(i, :)];
        end
    end
    toc
end

% train and test classes are names so far, let's get list of their IDs so
% we can use those IDs to look into the predicate matrix
train_ids = unique(train_animals);
test_ids = unique(set_B_animals);
assert(length(test_ids) == 10);

% probabilities of attribute presence for the "set B" samples
attr_probs = cell(num_attributes, 1); 

% saved here

for i = 1:num_attributes
    fprintf('Now processing attribute: %u/%u\n', i, num_attributes);
    tic
    % train an SVM to predict present/not for this attribute
    model = fitcsvm(train_samples, train_attributes(:, i));
    % convert the model so it can produce probabilities
    model_probs = fitSVMPosterior(model);
    % apply the model on the test samples
    [~, scores] = predict(model_probs, set_B_samples);
    % make sure proper probabilities, i.e. P(yes|feature)+P(no|feature)=1
    assert(all(sum(scores, 2) == 1));
    % store for later use
    attr_probs{i} = scores;
    toc
end

% save all outputs
save('zero_shot_setup.mat');


