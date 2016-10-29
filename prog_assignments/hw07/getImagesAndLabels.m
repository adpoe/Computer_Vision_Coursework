%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #07
% Fall 2016
%
%   Get Images and Labels
%   1. get contents of directory
%   2. extract the features of training images
%   3. run kmeansML to find the codebook centers
%   4. compute the SPM representations
%   5. run the KNN classifer (incl. computing accuracy)
%   
%   run for following value of k:  1,5,25,25
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load in data from directory --> see code from HW5P for this, just change
% the directory location for input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This script is to illustrate a couple of the provided functions,
% and to demonstrate loading a data file.

% specify our directories from which to gather data
testingDir = 'CS1674-HW07/testing';
trainingDir = 'CS1674-HW07/training';

% open contents of each directory
testingData = get_data(testingDir, 1);
trainingData = get_data(trainingDir,1);

% open each image itself, based on the data we've extracted
testingImages = {};
trainingImages = {};

% store image matrices for all the TESTING images
for cell = 1:size(testingData,1)
    impath = testingData(cell).path;
    im = imread(impath);
    testingImages{cell} = {im};
end

% store image matrices for all the TRAINING images
for cell = 1:size(trainingData,1)
    impath = trainingData(cell).path;
    im = imread(impath);
    trainingImages{cell} = {im};
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% extract features of training images --> using SIFT from previous
% assignment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
descriptors_all = []; % don't worry about efficiency
% iterate through all images 
for i = 1:size(trainingImages,2)
    % grab the image and convert it to single, so we can pass it to
    % the vl_sift function in proper format
    im = trainingImages{i}{1};
    I = single(im);
    
    % get the frames and descriptors for our image
    [f,descriptors] = vl_sift(I);
    
    % store descriptors like HW05-P
    % --> looks like goal of this to ensure the size of each descriptor set
    %     is consistent, randomly picking 10 features from each image
    rd = randperm(size(descriptors,2)); % need to get second dim here, because we chaned orientation vs prev homework 
    rd = rd(1:min(10, length(rd)));
    descriptors_all = horzcat(descriptors_all, descriptors(:,rd));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run kmeansML on the SIFT feature descriptors of all taining images
%  --> include images from ALL CLASSES in set of feature descriptors
%       use kmeansML.m from HW5P, and save a variable called 'means', just
%       like in HW5P
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run kmeansML, just like in HW05-P
disp('kmeans run...');
k = 100; 
[membership, means] = kmeansML(k, double(descriptors_all));

%save('centers.mat', 'membership', 'means')

% means --> 128xk -- this is mean of our training set data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use getHistogram (provided) to compute a BOW representation for EACH
% _training_ AND _test_ image.
% use k=100... --> this forms representation at level L=0 of the pyramind
% (whole image)
% this is part of of the (computeSPMHistogram) function which is NOT
% provided. So, once that's done, move it into computeSPMHistogram...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %compute a BOW histogram for each descriptor
    [bow] = getHistogram(double(descriptors'), means); 
    % --> this was my testing code, I've ported it to all the relevant
    % places in the computeSPMHistogram function

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% feed that data into SPM and compute representations --> provided code
%   USE:  computeSPMHistogram....
%       * once we're in this function, 'computeSPMHistogram' will divide the
%       image into 4 quadrants so that we know in WHICH quadrant they fall.
%       VLFeat provides these (see documentation for details)
%       now the code in computeSPMHistogram will create the quadrants as
%       shown in the handout
%       * next, the draft code will concatenate the histograms computed
%       above. ensure histograms are concatenated in SAME order for all
%       images. YIELDS --> 1xd-dimensional descriptor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% test computing SPM histogram
im = testingImages{1}{1};
[pyramid] = computeSPMHistogram(double(im), means);
% --> my pyramid is coming back at size 1x2100
%     intuitively, this seems about right, as I would expect it to be of
%     dimensionality=1x2048... because I would expect dimensions (d) to be
%     equal to size 16 * 128. 
%       - This is because we divide into 16 quadrants, and quadrant should
%       have 128-dimensions, being part of SIFT feature space, which is 128
%       dimensional.
%       - So, 1x2100 is a little higher than I expected, but it's in the
%       right area. And moreover, I didn't change much of the code itself,
%       compared to what was given.

% okay, now that we know we can create SPM histograms, let's create them
% for all images and attach labels to them
trainingSPM = [];
for i = 1:size(trainingImages,2)
    im = trainingImages{i}{1};
    [pyramid] = computeSPMHistogram(double(im), means);
    trainingSPM = vertcat(trainingSPM, pyramid);
end

label_list = [];
% attach labels next, using what we know in trainingData
for i=1:size(trainingData,1);
    category = trainingData(i).category;
    
    % base case, label=1 (not really a base case, but just starting number)
    label = 1;
    
    % match based on category name
    if strcmp(category, 'bedroom')
        label=1;
    elseif strcmp(category, 'CALsuburb')
        label=2;
    elseif strcmp(category, 'industrial')
        label=3;
    elseif strcmp(category, 'kitchen')
        label=4;
    elseif strcmp(category, 'livingroom')
        label=5;
    elseif strcmp(category, 'MITcoast')
        label=6;
    elseif strcmp(category, 'MITforest')
        label=7;
    elseif strcmp(category, 'MIThighway')
        label=8;
    elseif strcmp(category, 'MITinsidecity')
        label=9;
    elseif strcmp(category, 'MITmountain')
        label=10;
    elseif strcmp(category, 'MITopencountry')
        label=11;
    elseif strcmp(category, 'MITstreet')
        label=12;
    elseif strcmp(category, 'MITtallbuilding')
        label=13;
    elseif strcmp(category, 'PARoffice')
        label=14;
    elseif strcmp(category, 'store')
        label=15;
    else
        disp('found item which has no matching label.');
    end
    
    % add the label to our list
    label_list = vertcat(label_list, label);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% now, goal is to learn a classifier which can predict, for a test image to 
% which of the 15 scene categories te image belongs.
%       - each folder is a category, and all photos within these folders
%       should have the same label
%       - the label values should be integers between 1 and 15
testingSPM = [];
for i = 1:size(testingImages,2)
    im = testingImages{i}{1};
    [pyramid] = computeSPMHistogram(double(im), means);
    testingSPM = vertcat(testingSPM, pyramid);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% next, use the KNN classifer. WRITE OWN CODE FOR KNN. Cannot use built-in
% Matlab function. 
%       * for each test image, compute the k-closest neighbors (by
%       euclidean distance in SIFT feature space between this image's
%       descriptor and the data in in our training image's descriptor
%       (the descriptors are now the spatial pyramids)
%       * USE: the dist2 code from HW5P for this euclidean distance
%       calculation.
%       * then find the k-nearest neighbors among only the training images.
%       Since these are training images, you know their labels. 
%       * Find the mode (most common value) --> (i.e - Matlab function
%       (mode))
%       * assign the test image a label = the mode


% Run this for 4 separate values for K
k=1; 
[ predicted_labels_k1 ] = findLabelsKNN( trainingSPM, testingSPM, label_list, k );

k=5; 
[ predicted_labels_k5 ] = findLabelsKNN( trainingSPM, testingSPM, label_list, k );

k=25; 
[ predicted_labels_k25 ] = findLabelsKNN( trainingSPM, testingSPM, label_list, k );

k=125; 
[ predicted_labels_k125 ] = findLabelsKNN( trainingSPM, testingSPM, label_list, k );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% after evaluating, need to evaluate the accuracy of the classifiers.
% compute what fraction of the test images was assigned to the correct
% label (i.e. - the 'ground truth' label that came with the data set)
% this function is provided for you --> computeAccuracy(trueLabels,
% predicedLabels))
%       WHERE:  trueLabels is the Nx1 vector of 'ground truth' labels
%       (15x1) all ints
%               predictionLabels is the corresponding Nx1 vector of labels
%               predicted by the classifier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Get Ground Truth Labels
ground_truth_labels = [];
% attach labels next, using what we know in trainingData
for i=1:size(testingData,1);
    category = testingData(i).category;
    
    % base case, label=1 (not really a base case, but just starting number)
    label = 1;
    
    % match based on category name
    if strcmp(category, 'bedroom')
        label=1;
    elseif strcmp(category, 'CALsuburb')
        label=2;
    elseif strcmp(category, 'industrial')
        label=3;
    elseif strcmp(category, 'kitchen')
        label=4;
    elseif strcmp(category, 'livingroom')
        label=5;
    elseif strcmp(category, 'MITcoast')
        label=6;
    elseif strcmp(category, 'MITforest')
        label=7;
    elseif strcmp(category, 'MIThighway')
        label=8;
    elseif strcmp(category, 'MITinsidecity')
        label=9;
    elseif strcmp(category, 'MITmountain')
        label=10;
    elseif strcmp(category, 'MITopencountry')
        label=11;
    elseif strcmp(category, 'MITstreet')
        label=12;
    elseif strcmp(category, 'MITtallbuilding')
        label=13;
    elseif strcmp(category, 'PARoffice')
        label=14;
    elseif strcmp(category, 'store')
        label=15;
    else
        disp('found item which has no matching label.');
    end
    
    % add the label to our list
    ground_truth_labels = vertcat(ground_truth_labels, label);
end

% finally, predict accuracy for each set of labels
[accuracy_k1] = computeAccuracy(ground_truth_labels, predicted_labels_k1);
[accuracy_k5] = computeAccuracy(ground_truth_labels, predicted_labels_k5);
[accuracy_k25] = computeAccuracy(ground_truth_labels, predicted_labels_k25);
[accuracy_k125] = computeAccuracy(ground_truth_labels, predicted_labels_k125);

% print accuracies to console
fprintf('Accuracy for k=1:   %f PERCENT CORRECT\n', accuracy_k1);
fprintf('Accuracy for k=5:   %f PERCENT CORRECT\n', accuracy_k5);
fprintf('Accuracy for k=25:   %f PERCENT CORRECT\n', accuracy_k25);
fprintf('Accuracy for k=125:   %f PERCENT CORRECT\n', accuracy_k125);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

