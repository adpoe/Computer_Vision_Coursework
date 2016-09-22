%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #03
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% IMAGE PYRAMIDS SCRIPT %%%%

% Use the Matlab function rgb2gray.
image = imread('CS1674-HW03/Rainbow.jpg');
image = imresize(image, 0.5);
image = rgb2gray(image);

% also set the filter
im_filter = fspecial('gaussian', 30, 10);

% call pyramids and get our response matrices
[G, L] = pyramids(image, im_filter);


% show all gaussian and laplacian responses up to degree 5
for y = 1:5
    % print gaussian with labels
    str = 'Gaussian Number ';
    str = strcat(str, num2str(y));
    figure; imshow(G{y}); title(str);
end

for y = 1:5
    % print laplacian with labels
    str = 'Laplacian Number ';
    str = strcat(str, num2str(y));
    figure; imshow(L{y}); title(str);
end
