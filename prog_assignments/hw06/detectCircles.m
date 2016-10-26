function [ centers ] = detectCircles( im, edges, radius, top_k )
%DETECTCIRCLES Function for find the center of the k-most prevalent circles
%   in an image, given the image itself and the edge information,
%   which must be returned from detectEdges()
%
%   INPUT
%       im = uint8 RGB image matrix
%       edges = Nx4 matrix, returned from detectEdges function
%       radius = radius of the circle, in pixels
%       top_k = uint8, the number of circles we want to locate
%
%   OUTPUT
%       centers = an Nx2 matrix where each row lists the x,y position of
%                 a detected circle's center
%

% declare an accumulator, with all zeros at init
H = zeros(size(im,1), size(im,2));

% iterate through all edges
for n = 1:size(edges,1)
    % get our x,y values for each each
    x = edges(n,1);
    y = edges(n,2);
    
    % grab the gradient as well
    theta = edges(n,4);
    
    % vote for elements around all radii for points of interest
    a = round(x - radius*cos(theta));
    b = round(y - radius*sin(theta));
    
    % guard against negative values
    if a < 1 || b < 1
        continue
    end
 
    % guard against values out of index bounds
    if a > size(im,2) || b > size(im,1)
        continue
    end
    
    % guard against NaN value
    if isnan(a) || isnan(b)
        continue
    end
    
    % vote for the particular X,Y value we've found in H
    % remember, Matlab indexes y's first
    H(b,a) = H(b,a) + 1; 
end

% show voting pattern
%figure; imshow(H);

% apply gaussian filter to our voting matrix to error correct
%gauss = fspecial('gaussian', radius);
%H = imfilter(H, gauss);


% sort by descending so we can find the max indices
% store H as a vector first so we can sort it more easily
h_vector = H(:);
%maxSortedIndices = sort(h_vector, 'descend');
[Values ,VectorIndices] = sort(h_vector, 'descend');

% Reference:
%[Y,I] = sort(X,DIM,MODE) also returns an index matrix I.
%    If X is a vector, then Y = X(I).  
%    If X is an m-by-n matrix and DIM=1, then
%        for j = 1:n, Y(:,j) = X(I(:,j),j); end


% Okay now find the centers we need
centers = zeros(top_k, 2);

% find the top-k vector indices
topIndices = VectorIndices(1:top_k);

% Translate back to a real matrix using ind2sub
[ys, xs] = ind2sub(size(im), topIndices);
% Reference:
% [I,J] = ind2sub(SIZ,IND) returns the arrays I and J containing the
%    equivalent row and column subscripts corresponding to the index
%    matrix IND for a matrix of size SIZ.  
%    For matrices, [I,J] = ind2sub(SIZE(A),FIND(A>5)) returns the same
%    values as [I,J] = FIND(A>5).

% Map our values from ys and xs back to their center locations
for index = 1:top_k
    centers(index,1) = ys(index);%ceil(ys(index) / radius);
    centers(index,2) = xs(index);%ceil(xs(index) / radius);
end

% show our result
figure; imshow(im);
viscircles(centers, radius * ones(size(centers, 1),1));
title(strcat('Radius Size=', num2str(radius)));


end

