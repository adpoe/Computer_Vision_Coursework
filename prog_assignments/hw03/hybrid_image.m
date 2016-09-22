%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #03
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Part II: Hybrid Images (10 points)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) Download one pair of images: woman_happy and woman_neutral, or baby_happy and baby_weird.
% Selected: >>> 'woman_happy' and 'woman_neutral'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (2) In your code, read in both images and resize them to the same square size (e.g. 512x512).
% Also convert both of them to grayscale. Name your script hybrid_image.m.

% read in, resize and show 'woman_happy.png'
woman_happy = imread('CS1674-HW03/woman_happy.png');
woman_happy = rgb2gray(woman_happy);
woman_happy = imresize(woman_happy, [512,512]);
%figure; imshow(woman_happy)


% read in, resize and show 'woman_neutral.png'
woman_neutral = imread('CS1674-HW03/woman_neutral.png');
woman_neutral = rgb2gray(woman_neutral);
woman_neutral = imresize(woman_neutral, [512,512]);
%figure; imshow(woman_neutral)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (3) Create a Gaussian filter with fspecial('gaussian', hsize, sigma);
%
im_filter = fspecial('gaussian', 30, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (4) Apply the filter to both, saving the results as im1_blur, im2_blur.
% 
im1_blur = imfilter(woman_happy, im_filter);
figure; imshow(im1_blur);

im2_blur = imfilter(woman_neutral, im_filter);
%figure; imshow(im2_blur);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (5) For the second image, subtract the blur of the image from the image 
% (as we did with the Pittsburgh image in class), and save the result as im2_detail.
im2_detail = woman_neutral - im2_blur;
%figure; imshow(im2_detail);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (6) Now add im1_blur and im2_detail, show the image, save it, 
% and include it with your submission. 
% Play with scaling it up and down (by dragging in Matlab) 
% to see the "hybrid" effect.
hybrid_image = im1_blur + im2_detail;
figure; imshow(hybrid_image);
