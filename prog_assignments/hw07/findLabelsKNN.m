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

testing_spm = pyramids_test(1,:);
D = dist2(testing_spm, pyramids_train);

% find the k-minimum indices, to start
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

[Y,I] = max(label_counts);

labels = Y;
end

