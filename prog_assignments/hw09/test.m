%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #09
% Fall 2016
%
% "Pedestrian Detection System in Computer Vision"
% 
%   SCRIPT: test.m
%       - Implements sliding window detection for a test image
%       - List out:
%           * how many bounding boxes the system predicted positive
%           * how many really were positive
%           * how many ground-truth persons were in the test set
%           * what the precision/recall of the system is
%       - Save 10 windows iwth positive detections, in jpg/png format
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the previous session, so we can use the SVM we've trained
load('CS1674-HW09/setup.mat');

% use the classifier we've trained to find pedestrians in new test image
% pick 10 images from the test data, pedestrian_detection_test_data.
% Note: in most test images, the people are not at the same scale as in the
% positive crops. 
% Normally, might try to look for a person at multiple sizes. However this
% is problematic. So, instead, reeisze the test images that DO contain
% people, so that the person is at the visually correct size. Also include
% some test images that do NOT contain people, to see how many false
% positives your system returns

% set window size
window_size_y = size(pos_sample_ims(1).image,1);
window_size_x = size(pos_sample_ims(1).image,2);

% perform sliding window detection
test_dir_path = 'CS1674-HW09/small_test/';
test_ims = dir(test_dir_path);


% setup variables to save our matches
positives = {};
pos_count = 1;
neg_count = 1;

% for each test image
% load it in
for index = 3:size(test_ims,1) % start at 3 to avoid . and ..
    im = imread(strcat(test_dir_path, test_ims(index).name));
    
    % slide a window of same size as the positive patches
    for y_topLeft = 1:10:size(im,1)
        % guard against out of bounds
        if (y_topLeft + window_size_y) >=  size(im,1)
            %disp('made it to guard y')
            continue
        end
        for x_topLeft = 1:10:size(im,2)
            % guard against out of bounds
             if (x_topLeft + window_size_x) >=  size(im,2)
                 %disp('made it to guard x')
                 continue
             end
            window = im(y_topLeft:(y_topLeft + window_size_y), x_topLeft:(x_topLeft + window_size_x), :);

            % extract the HOG features for that window
            cellSize = 8 ;
            hog = vl_hog(single(window), cellSize) ;
            
            % run the SVM on it, using predict to see if the SVM predicted positive or
            % negative for that window
            hog_vector = reshape(hog, [],1);
            hog_vector = hog_vector';
            %test_HOGs = [test_HOGs; hog_vector];
            label = predict(svm_model, hog_vector);
            
            if label == 0
               neg_count = neg_count + 1;
            end
            
            % check if we have a match, and store it, if so
            if label == 1
                positives(pos_count).image = window;
                pos_count = pos_count + 1;
            end
            
        end
    end

end


% save 10 windows on which the SVM predicts positive and include them in
% your submission
increment = floor(size(positives,2)/10);
for save_index = 1:increment:size(positives,2)
    im = positives(save_index).image;
    im_name = strcat(strcat('CS1674-HW09/pos_predictions/pred',num2str(save_index)), '.png');
    imwrite(im, im_name);
end



% because we have so many positives (1000+), I'm taking a uniform sample
% from the data set of size n=30, so that I can compute recall and
% precision from that
increment = floor(size(positives,2)/30);
for save_index = 1:increment:size(positives,2)
    im = positives(save_index).image;
    im_name = strcat(strcat('CS1674-HW09/uniform_sample/sample',num2str(save_index)), '.png');
    imwrite(im, im_name);
end


