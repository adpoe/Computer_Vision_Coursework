function [ bow ] = computeBOWRepr( descriptors, means )
%COMPUTEBOWREPR Computes a Bag-Of-Words (BOW) representation of an image 
%or image region (polyon). 
%   bow = normalized bag-of-words histogram
%   decriptors = Mx128 set of descriptors for the image or image region
%   means = 128xK set of cluster means

% Step 1:  Map a raw SIFT descriptor to its visual word. The raw descriptor
%   is assigned to the nearest visual word by computing the INDEX of the
%   cluster center to the descriptor is closest to it, in terms of Euclidean distance
%   (use the means variable from centers.mat). 
%   dist2.m --> gives the distance computations

% To make dist2() work, we need to both descriptors and means to have the
% same number of columns. So transpose means to accommodate this. 
means_transpose = means';

% assert that **descriptors** and **means** have same number of columns
% since our dist2 computation depends on that
assert(size(descriptors, 2) == size(means_transpose,2))

% okay, now get our distances
distances_list = dist2(means_transpose, descriptors);

% And find the minimums for each feature, overall, which tells us the
% cluster index for that minimum.
% >> Think:  Cluster center **closest to** == min. And we just got the
% distance, using dist2. So now jsut need to fin the mins values, and
% their indices. And we can do that by running min() on our distances list. 
[min_values, cluster_indices] = min(distances_list, [], 1);

% and finally, create the histogram, using histc

% Step 2: Map an image or region's features into its bag-of-words
%   histogram. The histogram for image I_j is a k-dimensional vector:
%   F(I_j) = [freq1j, freq2j, ... freqkj]
%       --> each entry in the vector is counts the number of occurrences of
%       the i-th visual word in the image, and k is the total number of
%       words in the vocabulary.
%       ... In other words, a single image's or image region's list of M
%       SIFT descriptors yields a k-dimensional BOW histogramj

range = 1:size(means,1); % the range of indices over which 
                         % to map our histogram
                         
% first get the 'raw' bag-of-words values for each feature, not normalized
bow_raw = histc(cluster_indices, range);

% then, compute the **normalized** bag of words,
% by dividing each entry in the bow vector by the sum of the vector
bow_cols = bow_raw / sum(bow_raw);

% if we use the 1st dimension, need to transpose at end,
% because the features were passed in as rows.
bow = bow_cols';

% Uncomment to visualize! 
%plot(bow);

end

