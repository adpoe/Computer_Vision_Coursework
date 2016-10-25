function [ edges ] = detectEdges( im, threshold )
%detectEdges - Find edges above given threshould in an input image
%   INPUTS
%       im = RGB uint8 image
%       threshold = user set threshold for detecting edges
%                   HERE, threshold is expressed as an uint8,
%                   where the threshold value is marked as (thresh*avg)
%                   for the overall average of the image's
%                   pixel gradient values
%                   SUGGESTED THRESHOLD = 2.
%
%   OUTPUTS
%       edges = Nx4  matrix
%           --> where N is the number of edges detected
%           AND: 
%           edges(N,1) = location of the x point
%           edges(N,2) = location of the y point
%           edges(N,3) = gradient magnitude at this point
%           edges(N,4) = gradient orientation (non-quantized) of this point


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% COMPUTE GRADIENTS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ß
% convert image to grayscale first
G = rgb2gray(im);

% convert to double
%G2 = im2double(G);

% perform gaussian smoothing
g = fspecial('gaussian');
%G2 = imfilter(G2, g);
G = imfilter(G, g);
G = im2double(G);

% create X and Y Sobel filters
horizontal_filter = [1 0 -1; 2 0 -2; 1 0 -1];
vertical_filter = [1 2 1; 0 0 0 ; -1 -2 -1];

% using imfilter to get our gradient in each direction
filtered_x = imfilter(G, horizontal_filter);
filtered_y = imfilter(G, vertical_filter);

% store the values in our output variables, for clarity
Ix = filtered_x;
Iy = filtered_y;


%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% THRESHOLD %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
% set threshold of 'cornerness' to 5 times average R score
avg_r = mean(mean(G));
threshold_total = abs(threshold * avg_r);

[row, col] = find(G > threshold_total);

%scores = [];
%get all the values
%for index = 1:size(row,1)
%    %see what the values are
%    r = row(index);
%    c = col(index);
%    scores = cat(2, scores,G(r,c));
%end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% FIND GRADIENT ORIENTATION %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grad_mag = zeros(size(Ix));
grad_orient = zeros(size(Ix));

% first, find all of the gradient orients and magnitudes
for i = 1:size(Iy, 1)
    for j = 1:size(Ix, 2)
        % fill the magnitude matrix
        grad_mag(i, j) = sqrt(Ix(i,j)^2 + Iy(i,j)^2);
        
        % find the orient
        orient_raw = atand(Iy(i,j) / Ix(i,j));
        
        % set the orient
        grad_orient(i,j) = orient_raw;
%         
%         if (isnan(orient_raw))
%             assert(grad_mag(i,j) == 0);
%             orient_raw = 0; % if no change, we won't count a gradient magnitude
%         end
%         
%         
%         % get the correct bin
%         assert(orient_raw >= -90);
%         if (orient_raw <= -67.5)
%             grad_orient(i,j) = 1;
%         elseif (orient_raw <= -45)
%             grad_orient(i,j) = 2;
%         elseif (orient_raw <= 22.5)
%             grad_orient(i,j) = 3;
%         elseif (orient_raw <= 0)
%             grad_orient(i,j) = 4;
%         elseif (orient_raw <= 22.5)
%             grad_orient(i,j) = 5;
%         elseif (orient_raw <= 45)
%             grad_orient(i,j) = 6;
%         elseif (orient_raw <= 67.5)
%             grad_orient(i,j) = 7;
%         else % orient_raw > 67.5
%             grad_orient(i,j) = 8;
%         end
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% CREATE RETURN DATA STRUCTURE %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%think:
%edges(n,1) = col(n)
%edges(n,2) = row(n)
%edges(n,3) = grad_mag(row(n), col(n))
%edges(n,4) = grad_orient(row(n), col(n))

% define our edges matrix, empty at first
N = size(col,1);
edges = zeros(N, 4);

% fill the edge matrix with relevant values across all 4 dimensions
for index = 1:N
    edges(index,1) = col(index);
    edges(index,2) = row(index);
    edges(index,3) = grad_mag(row(index), col(index));
    edges(index,4) = grad_orient(row(index), col(index));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% SAVE & DISPLAY RESULTING IMAGE %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display_img = zeros(size(im,1), size(im,2));

% fill the values we have only in display image, all others are 0
for n = 1:size(col,1)
    % get x-y coords
    x = edges(n,1);
    y = edges(n,2);
    
    % get gradient mag
    val = edges(n,3);
    
    % fill the value
    display_img(y,x) = val;
end

% display the image
figure; imshow(display_img);

% save the iamge
imwrite(display_img, 'edge_detection.png');

end

