%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #5
% Fall 2016
%
% 'homography_script.m' --> Compute the Homography from matching points
%    between two images. This can tell us where points from the first 
%    image appear in the second.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Load in the provided images, 'img1' and 'img2', and show them
% also call the command 'impixelinfo'
im1 = imread('CS1674-HW05/keble1.png');
figure; imshow(im1);
impixelinfo;

im2 = imread('CS1674-HW05/keble2.png');
figure; imshow(im2);
impixelinfo;

% 2. Examine the images, and determine at least 4 pairs of points (one from
% the first image and one from second) that are distinctive. 
% Write these points down in **matrix form** in the script, with rows being
% the points and columns being the (x,y) locations --> [1, [y,x]].
% Call these A and B, and use below. 

% Point 1 = bottom left of middle steeple, where it intersects with roof
% Point 2 = bottom left of main steeple
% Point 3 = top right of window at bottom of building, immediately left of 
%           steeple selected for point 1
% Point 4 = topmost point of large 'bay window' to left a main entrance
A = [157 103; 254 103; 153 186; 271 160];
B = [60 114; 161 117; 53 198; 173 174];

% 3.  Compute the homography between A and B
H = compute_homography(A,B);

% 4. Call the function to compute where p1 from the 1st image
%       lands in the in the 2nd image after computing the homography

for i = 1:4
    p1 = A(i,:);
    p2 = apply_homography(p1, H);

    % And convert BACK from homogeneous coordinates, as well
    transformed_x = p2(1)/p2(3);
    transformed_y = p2(2)/p2(3);
    t1 = [transformed_x, transformed_y];

    % Finally, write down the "test" points and find where they land in the
    % second image. Create two appropriately named figures, one which shows the
    % first image with the p1 point selected on it shown in YELLOW. And the
    % other which shows the second image, with the p2 point computed using the
    % homography shown in RED.

    % Show start point in yellow
    figure; imshow(im1);
    hold on
    x = p1(1);
    y = p1(2);
    plot(x,y,'y+', 'MarkerSize', 20);
    xlabel(strcat('P1 point for  selection ',num2str(i)));
    hold off

    % Show transform point point in red
    figure; imshow(im2);
    hold on
    x = t1(1);
    y = t1(2);
    plot(x,y,'r+', 'MarkerSize', 20);
    xlabel(strcat('Homography point for selection ',num2str(i)));
    hold off
end
