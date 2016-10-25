%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #6
% Fall 2016
%
%   Color Quantization with K-Means
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Part I
% Find and Display K-means on Fish Image
origImg = imread('/CS1674-HW06/fish.jpg');

for k=2:5
    [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k);
    figure; imshow(outputImg, meanColors); title(strcat('Quantized Fish Image for K= ', num2str(k)));
    quantizedImg = outputImg;
    [ error ] = computeQuantizationError( origImg, quantizedImg );
    fprintf('Error for k=%u is %u\n', k, error);
end