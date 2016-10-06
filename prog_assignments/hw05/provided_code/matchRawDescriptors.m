function [inds] = matchRawDescriptors(d1, d2)
% d1 (MxN) is a set of M descriptors, each of length N, from the first
%   image; each row in d1 is a separate descriptor;
% d2 (LxN) is a set of L descriptors, each of length N, from the second
%   image; each row in d2 is a separate descriptor;
% inds is of size Mx1, so there are as many indices as descriptors in the 
%   first image; for each descriptor in the first image, we find its 
%   closest match in the second image

    dists = dist2(d1, d2);
    assert(size(dists, 2) == size(d2, 1));
    
    % find best match between each descriptor in image 1 and any descriptor in image 2
    [~, inds] = min(dists, [], 2);
        
    
