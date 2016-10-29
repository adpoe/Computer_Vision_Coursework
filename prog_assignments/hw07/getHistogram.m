function [bow] = getHistogram(descriptors, means)

    means = means';

    k = size(means, 1);
    bow = zeros(1, k);

    dists = dist2(descriptors, means);
    [~, inds] = min(dists, [], 2);
    
    for i = 1:k
        bow(i) = sum(inds == i);
    end
    
    bow = bow / sum(bow);
    
        
        