function [ x, y, scores, Ix, Iy ] = extract_keypoints( image )
%EXTRACT_KEYPOINTS Extracts points with a high degree of 'cornerness' from
%RGB image matrix of type uint8
%   Input - image = NxMx3 RGB image matrix
%   Output - x = nx1 vector denoting the x location of each of n
%                detected keypoints 
%            y = nx1 vector denoting the y location of each of n 
%                detected keypoints
%            scores = an nx1 vector that contains the value (R) to which a
%            a threshold was applied, for each keypoint
%            Ix = A matrix with the same number of rows and columns as the
%            input image, storing the gradients in the x-direction at each
%            pixel
%            Iy = A matrix with the same nuimber of rwos and columns as the
%            input image, storing the gradients in the y-direction at each
%            pixel

%image = imread('prague.jpg');
% compute the gradients, re-use code from HW2P, use window size of 5px
% convert image to grayscale first
G = rgb2gray(image);

% convert to double
G2 = im2double(G);

% create X and Y filters
horizontal_filter = [1 0 -1; 2 0 -2; 1 0 -1];
vertical_filter = [1 2 1; 0 0 0 ; -1 -2 -1];

%horizontal_filter = [1 0 -1; 1 0 -1; 1 0 -1];
%vertical_filter = horizontal_filter';

% using imfilter to get our gradient in each direction
filtered_x = imfilter(G2, horizontal_filter);
filtered_y = imfilter(G2, vertical_filter);

% store the values in our output variables, for clarity
Ix = filtered_x;
Iy = filtered_y;

% Compute the values we need for the matrix
%Ixy = Ix .* Iy;
%Iy2 = Iy .^ 2;
%Ix2 = Ix .^2;

% I get negative values, unless I apply gaussian filters to our Ixy, Iy2
% % and Ix2 values.... 
% g = fspecial('gaussian');
% Ix2= conv2 (Ix.^2, g, 'same');
% Iy2= conv2 (Iy.^2, g, 'same');
% Ixy= conv2 (Ix.*Iy, g, 'same');

% try with filter, not conv
f = fspecial('gaussian');
Ix2 = imfilter(Ix.^2, f);
Iy2 = imfilter(Iy.^2, f);
Ixy = imfilter(Ix.*Iy, f);

% set empirical constant between 0.04-0.06
k = 0.04;

num_rows = size(image,1);
num_cols = size(image,2);

% create a matrix to hold the Harris values
H = zeros(num_rows, num_cols);
H1 = zeros(num_rows, num_cols);

% % get our matrix M for each pixel
% for y = 1:size(image,1)
%     for x = 1:size(image,2)
%         % build a matrix using what we computed earlier
%         M = zeros(2,2);
%         M(1,1) = Ix2(y,x);
%         M(2,1) = Ixy(y,x);
%         M(1,2) = Ixy(y,x);
%         M(2,2) = Iy2(y,x);
%         
%         % compute R, using te matrix we just created
%         R = det(M) - ( k * trace(M)^2 );
%         %alt
%         %R = (Ix2.*Iy2 - Ixy.^2) - k(Ix2+Iy2).^2;
%         
%         % store the R values in our Harris Matrix
%         H(y,x) = R;
%        
%     end
% end

% Try alternate computation for R
% from: http://slazebni.cs.illinois.edu/spring16/harris.m
H1 = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps); % Harris corner measure


% % set threshold of 'cornerness' to 5 times average R score
% avg_r = mean(mean(H))
% threshold = 5 * avg_r

avg_r1 = mean(mean(H1));
threshold1 = 5 * avg_r1;

[row, col] = find(H1 > threshold1);

% get all the values
for index = 1:size(row,1)
    % see what the values are
    r = row(index);
    c = col(index);
    
    % store the scores
    scores(index) = H1(r,c);
end

y = row;
x = col;

% 
% % find top 1% of values
% n = size(H(:),1);
% m = n * 0.01;
% 
% %[sortedValues, sortedIndex] = sort(Max_Suppressed_H(:), 'descend');
% %maxIndex = sortedIndex(1:m);
% %scores = sortedValues(1:m);
% 
% % sort the values and get the largest m values that make up the 1%
% sortedValues = unique(H(:));          
% maxValues = sortedValues(end-m:end);
% maxIndex = ismember(H,maxValues); 
% 
% 
% % get indices of all 1's
% [y, x] = find(maxIndex == 1);
% indices = [y,x];
% size(indices);
% 
% 
% % get the scores, so we can return them
% scores = zeros(size(y));
% for index = 1:size(indices,1)
%     % find the score at each value in our matrix
%     y_index = y(index,1);
%     x_index = x(index,1);
%     
%     % get the actual value of each score
%     scr = H(y_index, x_index);
%     
%     % store each score in the scores vector
%     scores(index,1) = scr;
% end
% 

% This needs to be LAST
% http://stackoverflow.com/questions/1856197/how-can-i-find-local-maxima-in-an-image-in-matlab
% non max suppression
%Max_Suppressed_H = H > imdilate(H, [1 1 1; 1 0 1; 1 1 1]);

% OR: http://www.mathworks.com/help/images/ref/imregionalmax.html
%BW = imregionalmax(H);


end

