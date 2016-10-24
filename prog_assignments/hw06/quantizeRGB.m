function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)
% QUANTIZERGB - Given an RGB image, perform clustering in the 3-dimensional RGB space, 
%   and map each pixel in the input image to its nearest k-means center. 
%   That is, replace the RGB value at each pixel with its nearest cluster's average RGB value.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% 1.a. -> get k-means image representation %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% read in the image
%im = imread('/CS1674-HW06/fish.jpg');
im = origImg;

% make sure image is of type double, so we can feed it to kmeans
im2 = im2double(im);

% find the number of pixels we need to reshape our matrix
numpixels = size(im,1) * size(im,2);

% create a matrix with the RGB features as rows
X = reshape(im2, numpixels, 3);

% run k-means and get our IDS and centroid locations
% k=2; % with a k of 2
[IDX, C] = kmeans(X, k); % C is the colormap we pass to imwrite

% cast IDX back to uint8, since that's what we need for saving output
ids = uint8(IDX);

% cast our image back to its orginal shape, now that we are done with
% kmeans algorithm
result_image = reshape(ids, size(im,1), size(im,2));

% Now, we are saving an image with results in range [1,2] in each pixel
% value... 
% BUT our color-map is on range [0, 1]...
% SO --> we need to **subtract 1** before we write out, so that our color-map
% is using the same value range as our indices in the image.
% otherwise, everything will just be 1 color, and one color only.
result_image_norm = result_image - 1;

% UNCOMMENT TO VIEW OR SAVE
%imshow(result_image_norm, C);
%imwrite(result_image_norm, C, 'fish_quantized.png');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% SET RETURN VALUES %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
outputImg = result_image_norm;
meanColors = C;
clusterIds = ids;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

