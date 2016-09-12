%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #2
% Fall 2016
% -- PART C --
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [5 points] For the same two images, display, 
% save and submit the original image overlaid with 
%    (a) the first selected horizontal seam and 
%    (b) the first selected vertical seam.

%%%%%%%% (a) PRAGUE SEAMS %%%%%%%%
% (1) Energy Image
im = imread('prague.jpg');
energyImage = energy_image(im);
%imshow(energyImage);
%saveas(gcf, 'erm_en.jpg');

% (2) Cumulative Min Energy Map
M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
N = cumulative_minimum_energy_map(energyImage, 'VERTICAL');

% (3) Find Optimal Seams
horizontalSeam = find_optimal_horizontal_seam(M);
verticalSeam = find_optimal_vertical_seam(N);

% (4) Display Seam
figure; displaySeam(im, horizontalSeam, 'HORIZONTAL');
saveas(gcf, 'PRAGUE_HORIZONTAL_SEAM.jpg');
figure; displaySeam(im, verticalSeam, 'VERTICAL');
saveas(gcf, 'PRAGUE_VERTICAL_SEAM.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%% (b) MALL SEAMS %%%%%%%%
% (1) Energy Image
im = imread('mall.jpg');
energyImage = energy_image(im);
%imshow(energyImage);
%saveas(gcf, 'erm_en.jpg');

% (2) Cumulative Min Energy Map
M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
N = cumulative_minimum_energy_map(energyImage, 'VERTICAL');

% (3) Find Optimal Seams
horizontalSeam = find_optimal_horizontal_seam(M);
verticalSeam = find_optimal_vertical_seam(N);

% (4) Display Seam
figure; displaySeam(im, horizontalSeam, 'HORIZONTAL');
saveas(gcf, 'MALL_HORIZONTAL_SEAM.jpg');
figure; displaySeam(im, verticalSeam, 'VERTICAL');
saveas(gcf, 'MALL_VERTICAL_SEAM.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%