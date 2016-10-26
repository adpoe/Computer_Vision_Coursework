
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #6
% Fall 2016
%
%   Find the circles in example images used for assignment #06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read in the images
jupiter = imread('/CS1674-HW06/jupiter.jpg');
%figure; imshow(jupiter); impixelinfo;
egg = imread('/CS1674-HW06/egg.jpg');
%figure; imshow(egg); impixelinfo;

%%%%%%%%%%%%%%%%%%%%%%
%%%% Detect Edges %%%%
%%%%%%%%%%%%%%%%%%%%%%
% Testing thresholding for detect edges as well
% a value between [1, 2] works well for this.
threshold=1.5;
jupiter_edges = detectEdges( jupiter, threshold );
threshold=1.1;
egg_edges = detectEdges( egg, threshold );

%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Detect Cirlces %%%%
%%%%%%%%%%%%%%%%%%%%%%%%
% set top_k=10, at my own discretion
top_k=10;
radius=100;
jupiter_centers = detectCircles( jupiter, jupiter_edges, radius, top_k );
radius=10;
egg_centers =  detectCircles( egg, egg_edges, radius, top_k );

