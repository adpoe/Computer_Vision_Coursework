%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #09
% Fall 2016
%
% "Pedestrian Detection System in Computer Vision"
% 
%   SCRIPT:  setup_and_train.m
%       - Get Postiive crops
%       - Generate Negative crops
%       - Extract features of each
%       - Train an SVM using these sets of features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get a list of positive crops --> can be a sample, say 50
pos_dir_path = 'CS1674-HW09/person_detection_training_data/pos/';
pos_samples = dir(pos_dir_path);
% get 100 samples --> must generate the random numbers in our range,
% which is the size of the directory struct itself
increment = floor(size(pos_samples,1)/100);
% either get 100 samples, or if we have less than 100 samples in our
% directory, just get however many we have
if increment == 0 
    incremenent = 1;
end
% create structure to store our samples and counter to specify where in the
% struct we will save each
pos_sample_ims = {};
save_index = 1;
% grab 100 samples, evenly spaced throughout directory
for index = 3:increment:size(pos_samples,1)
    im = imread(strcat(pos_dir_path, pos_samples(index).name));
    pos_sample_ims(save_index).image = im;
    im_name = strcat(strcat('CS1674-HW09/pos_sample/pos_sample',num2str(save_index)), '.png');
    imwrite(im, im_name);
    save_index = save_index + 1;
end

% get the size of our positive images
im_size = size(pos_sample_ims(1).image);
y_size = im_size(1);
x_size = im_size(2);
% generate ranges, for when we generate random numbers


 %NOTES
%------------------
% read them in this way
%imshow( strcat(pos_dir_path, pos_samples(50).name))
% access with
%pos_sample_ims(66).image;
%-------------------

% generate a negative data from uncropped images in the 'neg' directory
% ensure these are SAME SIZE as pos crops, and equal in number
neg_dir_path = 'CS1674-HW09/person_detection_training_data/neg/';
neg_samples = dir(neg_dir_path);
% get 100 samples --> must generate the random numbers in our range,
% which is the size of the directory struct itself
increment = floor(size(neg_samples,1)/100);
% either get 100 samples, or if we have less than 100 samples in our
% directory, just get however many we have
if increment == 0 
    incremenent = 1;
end
% create structure to store our samples and counter to specify where in the
% struct we will save each
neg_sample_ims_raw = {};
save_index = 1;
% grab 100 samples, evenly spaced throughout directory
for index = 3:increment:size(neg_samples,1)
    im = imread(strcat(neg_dir_path, neg_samples(index).name));
    neg_sample_ims_raw(save_index).image = im;
    save_index = save_index + 1;
end


neg_sample_ims_cropped = {};
save_index = 1;
% save an equal number of negative examples as we have positives
for index = 1:size(pos_sample_ims,2)
    % set end range
    y_end_range = size(neg_sample_ims_raw(index).image,1) - y_size;
    x_end_range = size(neg_sample_ims_raw(index).image,2) - x_size;
    
    %   - cycle through random locations in some negative image
    %   - set those to be the top-left of the crop
    % get a valid random location
    %   - check where bottom-right would end up, using the size of the pos
    %   crops, and skip this location if its outside the bounds of the image
    %           >>> Done implicitly above
    y_topLeft_ind = randi([1,y_end_range],1);
    x_topLeft_ind = randi([1 x_end_range],1);
    %   - if it is inside the bounds, get the corresponding pixels (in a
    %   matrix)
    %           >>> Always the case here
    y_bottomRight_ind = y_topLeft_ind + y_size;
    x_bottomRight_ind = x_topLeft_ind + x_size;
    % and use imwrite to save the crop as a new image
    im_crop = neg_sample_ims_raw(index).image(y_topLeft_ind:y_bottomRight_ind,x_topLeft_ind:x_bottomRight_ind ,:);
    im_name = strcat(strcat('CS1674-HW09/neg_sample/neg_sample',num2str(index)), '.png');
    imwrite(im_crop, im_name);
    neg_sample_ims_cropped(save_index).image = im_crop;
    save_index = save_index + 1;
    %   - must use a variety of diff images/settings to get good sample data
end

% extract positive HOGs
positive_HOGs = [];
for index = 1:size(pos_sample_ims,2)
    % extract HOG features from all positive and negative patches, using
    % VLFeat's vl_hog function
    cellSize = 8 ;
    hog = vl_hog(single(pos_sample_ims(index).image), cellSize) ;
  
    % show the HOG
    %imhog = vl_hog('render', hog, 'verbose') ;
    %clf ; imagesc(imhog) ; colormap gray ;
    
    % reshape our HOG
    hog_vector = reshape(hog, [],1);
    hog_vector = hog_vector';
    positive_HOGs = [positive_HOGs; hog_vector];
end

% extract negative HOGs
negative_HOGs = [];
for index = 1:size(neg_sample_ims_cropped,2)
    % extract HOG features from all positive and negative patches, using
    % VLFeat's vl_hog function
    cellSize = 8 ;
    hog = vl_hog(single(neg_sample_ims_cropped(index).image), cellSize) ;
   
    % show the HOG
    %imhog = vl_hog('render', hog, 'verbose') ;
    %clf ; imagesc(imhog) ; colormap gray ;
    
    % reshape our HOG
    hog_vector = reshape(hog, [],1);
    hog_vector = hog_vector';
    negative_HOGs = [negative_HOGs; hog_vector];
end

% build full smaple data
sample_data = [positive_HOGs; negative_HOGs];

% create our response variables
sample_labels = zeros(202,1);
for index = 1:101
    sample_labels(index) = 1; % 1 == pos
end

for index = 102:202
    sample_labels(index) = 0; % 0 == neg
end

% create our SVM model, using fitececoc
svm_model = fitcsvm(sample_data, sample_labels);

% save the workspace, so we can load and use our SVM, later
save('CS1674-HW09/setup.mat');

