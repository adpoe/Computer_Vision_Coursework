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
feats = caffe.io.load_image(imset(1).ImageLocation{1});
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TRAINING AND TESTING %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Randomly split the data into two (2) sets: 80% training; 20% testing
% 2. Train 3 linear SVMs using Matlab's fitcecoc function. To specify that
% Matlab should train linear SVMs, pass the following templatesSVM to the
% fitcecoc function:  
%       * templateSVM('Standardize',1,'KernelFunction','linear');
% 3. Test each of your SVMs on the test set and report the accuracy.
% Also include the confusion matrix for ONE of the features, using the
% `confusionmat` function, and include it in our submission. 
% 4. What do you observe about the types of errors your the network makes?
% Enter your answer in a new text file, 'obsvervations.txt'
