%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #1
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) Energy Image
im = imread('ermine.jpg');
energyImage = energy_image(im);
imshow(energyImage);
saveas(gcf, 'erm_en.jpg');

% (2) Cumulative Min Energy Map
M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
N = cumulative_minimumas_energy_map(energyImage, 'VERTICAL');

% (3) Find Optimal Seams
horizontalSeam = find_optimal_horizontal_seam(M);
verticalSeam = find_optimal_vertical_seam(N);

% (4) Display Seam
displaySeam(im, horizontalSeam, 'HORIZONTAL');
displaySeam(im, verticalSeam, 'VERTICAL');

