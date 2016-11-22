%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #10
% Fall 2016
%
% "Deep Network Categorization"
% 
%   SCRIPT: solution.m
%       - use pre-trained deep network to extact features
%       - then use these featurs to train an svm classifier which
%       discriminates betweeen 20 object categories
%       - finally, compare the deep-net features to SIFT features
%
%   Dependencies:
%       - Caffe package (C++ with Matlab interface)
%       - Cafe is pre-installed on the class4.cs.pitt.edu server
%           * need Pitt login and valid credentials to access
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% setup path to caffe director
addpath('/tmp/caffe/matlab/')

% create our net
net = caffe.Net('/tmp/caffe/models/deploy.prototxt', '/tmp/caffe/models/alexnet.caffemodel', 'test')

% get our image mean
image_mean = caffe.io.read_mean('/tmp/caffe/models/imagenet_mean.binaryproto');

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% DATA EXTRACTION %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data is located at /tmp/data/.
% - There are 20 folders with animal names. Each folder has ~100 images of
% the animal specified.
% - Use matlab command imageSet and 'recursive' parameters to to obtain a
% list of folders and all images in them for easy processing
imset = imageSet('/tmp/data/', 'recursive');
% yields --> 
%imset =
%  1x20 imageSet array with properties:
%    Description
%    ImageLocation
%    Count
% Can access each with imset(1).Description (and so on)
% And then with:  imset(1).ImageLocation(1)
% - Folder name is its 'ground truth' label
% - For each image, must extact three freatures from the CNN and store them
% in a variable.
% - Later will train a linear SVM on __each__ of the features
% - To extract features from each image, use this function: 
%       * caffe.io.load_image('/path/to/image/to/load')

% create cell arrays for each feature type / data label
fc8s = {};
fc7s = {};
fc6s = {};
data_labels = [];

% create a unique ID number for each image, we'll use this to index into
% our feature sets and keep things organized
imNum = 1;
for categoryNum = 1:size(imset,2)
    for imageNum = 1:size(imset(categoryNum).ImageLocation,2)
        feats = caffe.io.load_image(imset(categoryNum).ImageLocation{imageNum});
        label = imset(categoryNum).Description;
        
        % - After loading, use imresize(227) --> height and width must BOTH be set
        % to 227px. 
        resize = imresize(feats, [227,227]);
        % - After re-sizing, subtract the image_mean 
        resize_minus_mean = resize - image_mean;
        % - Run the image through the neural net using this command:
        %       * net.forward({image});
        net_img = net.forward({resize_minus_mean});
        % - Once image has been run through the Net, we are ready to extact features
        % from the network. Extract features from the 3 fully connected layers of
        % the network, 'fc8', 'fc7', and 'fc6'. To extract an image feature from
        % the network, use the command: 
        %       * net.blobs(feature_name).get_data()
        %           --> store each set of features some where for training the SVM
        fc8 = net.blobs('fc8').get_data();
        fc7 = net.blobs('fc7').get_data();
        fc6 = net.blobs('fc6').get_data();
        
        % store each feature description with a label and vector, indexing
        % by it's universal id number
        fc8s(imNum).Label = label;
        fc8s(imNum).Vector = fc8;
        
        fc7s(imNum).Label = label;
        fc7s(imNum).Vector = fc7;
        
        fc6s(imNum).Label = label;
        fc6s(imNum).Vector = fc6;
        
        % also store a numeric value for each label, to make things a
        % little simpler when we are comparing info later
        data_labels(imNum) = categoryNum;
        
        % increment the id number, each time
        imNum = imNum + 1;
    end
end

% Yields:
%fc8s =
%
%1x2000 struct array with fields:
%    Label
%    Vector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TRAINING AND TESTING %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Randomly split the data into two (2) sets: 80% training; 20% testing

% 2. Train 3 linear SVMs using Matlab's fitcecoc function. To specify that
% Matlab should train linear SVMs, pass the following templatesSVM to the

% store sample and test data for each feature
sample_labels = [];
sample_data_fc8 = [];
sample_data_fc7 = [];
sample_data_fc6 = [];

test_labels = [];
test_data_fc8 = [];
test_data_fc7 = [];
test_data_fc6 = [];

sample_index = 1;
test_index = 1;
for im = 1:size(fc8s,2)
    
    % randomly decide whether we are going to store as test/training
    training_sample = 0;
    
    % generate random num between [0,1)
    random_num = rand();  
    if random_num <= 0.8
        training_sample = 1;
    end
    
    % assign to sample if it's a training image (80% chance)
    if training_sample == 1;
        sample_labels(sample_index) = data_labels(im);
        sample_data_fc8 = [sample_data_fc8; fc8s(im).Vector']; %fc8s(im).Vector;
        sample_data_fc7 = [sample_data_fc7; fc7s(im).Vector'];
        sample_data_fc6 = [sample_data_fc6; fc6s(im).Vector'];
        %sample_data_fc7(sample_index) = fc7s(im).Vector;
        %sample_data_fc6(sample_index) = fc6s(im).Vector;
        
        sample_index = sample_index + 1;
    % otherwise it's a test image
    else
        test_labels(test_index) = data_labels(im);
        test_data_fc8 = [test_data_fc8; fc8s(im).Vector'];
        test_data_fc7 = [test_data_fc7; fc7s(im).Vector'];
        test_data_fc6 = [test_data_fc6; fc6s(im).Vector'];
        %test_data_fc8(test_index) = fc8s(im).Vector;
        %test_data_fc7(test_index) = fc7s(im).Vector;
        %test_data_fc6(test_index) = fc6s(im).Vector;
        
        test_index = test_index + 1;
    end
end

% create fitcecoc function (svm model) for each feature set
template = templateSVM('Standardize',1,'KernelFunction','linear');
svm_model_fc8 = fitcecoc(sample_data_fc8, sample_labels, 'Learners', template);
svm_model_fc7 = fitcecoc(sample_data_fc7, sample_labels, 'Learners', template);
svm_model_fc6 = fitcecoc(sample_data_fc6, sample_labels, 'Learners', template);

% 3. Test each of your SVMs on the test set and report the accuracy.
% Also include the confusion matrix for ONE of the features, using the
% `confusionmat` function, and include it in our submission. 

% keep counts of how many corrects/incorrects
correct_fc8 = 0.0;
correct_fc7 = 0.0;
correct_fc6 = 0.0;

wrong_fc8 = 0.0;
wrong_fc7 = 0.0;
wrong_fc6 = 0.0;

% store predicted test labels for fc8, for confusion matrix
predicted_test_labels_fc8 = [];

% make a prediction for each of our images in the test set
% and check whether it was correct
for image_index = 1:size(test_labels, 2)

    % grab relevant vector for each feature type
    fc8_vector = test_data_fc8(image_index, :);
    fc7_vector = test_data_fc7(image_index, :);
    fc6_vector = test_data_fc6(image_index, :);
    
    % get our correct 'ground truth' label
    ground_truth_label = test_labels(image_index);
    
    % and then our prediction labels
    label_fc8 = predict(svm_model_fc8, fc8_vector);
    label_fc7 = predict(svm_model_fc7, fc7_vector);
    label_fc6 = predict(svm_model_fc6, fc6_vector);

    % store predicted test labels for fc8, for a confusion matrix
   predicted_test_labels_fc8(image_index) = label_fc8;
    
    % then check veracity of each prediction, and store statistics
    if label_fc8 == ground_truth_label
        correct_fc8 = correct_fc8 + 1.0;
    else
        wrong_fc8 = wrong_fc8 + 1.0;
    end
    
    if label_fc7 == ground_truth_label
        correct_fc7 = correct_fc7 + 1.0;
    else
        wrong_fc7 = wrong_fc7 + 1.0;
    end
    
    if label_fc6 == ground_truth_label
        correct_fc6 = correct_fc6 + 1.0;
    else
        wrong_fc6 = wrong_fc6 + 1.0;
    end
end

% output correctness for each
fprintf('FC8 Correctness = %f\n\n', correct_fc8/(correct_fc8 + wrong_fc8))
fprintf('FC7 Correctness = %f\n\n', correct_fc7/(correct_fc7 + wrong_fc7))
fprintf('FC6 Correctness = %f\n\n', correct_fc6/(correct_fc6 + wrong_fc6))

% confusion matrix
CM = confusionmat(test_labels, predicted_test_labels_fc8);
% 4. What do you observe about the types of errors your the network makes?
% Enter your answer in a new text file, 'obsvervations.txt'
