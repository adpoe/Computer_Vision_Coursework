function [ labels ] = findLabelsKNN( pyramids_train, pyramids_test, labels_train, k )
%FINDLABELSKNN predicts the labels of the test images using KNN classifer
%   INPUT
%       - pyramids_train = Mx1 cell array
%           where M is size of training set
%                 and each pyramids_train{i} = 1x3 SPM of the corresponding
%                 training test image
%
%       - pyramids_test = Nx1 cell array
%           where N is size of test image set
%
%       - labels_train = Mx1 vector of training labels
%
%       - k = the k-number of nearest neighbors
%
%   OUTPUT
%       - labels = Nx1 vector of **predicted** labels for the test images
%     

%pyramids_train = trainingSPM;
%pyramids_test = testingSPM;
%labels_train = label_list;

% initialize our labels array, that we will add to and return
labels = zeros(size(pyramids_test,1), 1);

% iterate through all testing SPMs and assign a predicted label to each
for p = 1:size(pyramids_test,1);
    % grap the pyramid testing spm we are interested in 
    testing_spm = pyramids_test(p,:);
    % find its difference, compared to the trained data set
    % in SIFT feature-space
    D = dist2(testing_spm, pyramids_train);
    
    % find the k-minimum indices, comparing against those vectors 
    % which are already known in SIFT feature space
    min_indices = zeros(k,1);
    for i = 1:k
        [Y,I] = min(D,[],2);
        min_indices(i) = I;
        D(I) = [];
    end
    
    % index into labels and count how many of each
    label_counts = zeros(15,1);
    for i=1:k
        index = min_indices(i);
        label_number = labels_train(index);
        label_counts(label_number) = label_counts(label_number) + 1;
    end

    % get the max value (Y) and index (I)
    [Y,I] = max(label_counts);

    % the label we are interested in is the max index (I)
    predicted_label = I;
    
    % add the label we've just found to our labels output vector
    labels(p) = predicted_label;
    
end

    
end

