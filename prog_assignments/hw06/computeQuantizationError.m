function [ error ] = computeQuantizationError( origImg, quantizedImg )
%computeQuantizationError - Finds the Euclidean distance between the original RGB ppixel values
%   and the quantized values (SSD errror, or sum of squared distances)
%   
%   INPUTS
%   orgImg - RGB image of type uint8
%   quantizedImg - RGB image of type uint8
%   
%   OUTPUTS
%   error - scalar giving the total SSD error across the image
%
%

% get the original image as a vector
v1 = origImg(:);

% get a vector of our quantized image and replicate it 3x,
% once for each RGB channel, so that we can do a fair comparison
v_temp = quantizedImg(:);
v_rgb = [v_temp; v_temp; v_temp];
v2 = v_rgb(:);

% do an element-wise subtraction
diffs = v1-v2;

% do element wise squaring
squared_diffs = diffs.^2;

% get the sum
SSD = sum(squared_diffs);

% set error=SSD
error=SSD;

end

