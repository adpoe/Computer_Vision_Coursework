%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #2
% Fall 2016
% -- PART B --
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [5 points] Display, save and submit 
% (i) the energy_image function output for the provided images prague.jpg and mall.jpg, 
% and (ii) the two corresponding cumulative minimum energy maps (M) for the seams 
% in each direction (use the imagesc function).

%%%%%%%%% PRAGUE %%%%%%%%%%%
% (i) Prague Energy image function
im = imread('prague.jpg');
energyImage = energy_image(im);
figure; imshow(energyImage);
saveas(gcf, 'prague_energy_image.jpg');

% (ii) Cumulative minimum energy maps
M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
N = cumulative_minimum_energy_map(energyImage, 'VERTICAL');

figure; imagesc(M);
saveas(gcf, 'PRAGUE_cum_min_HORIZONTAL_energy_map.jpg');

figure; imagesc(N);
saveas(gcf, 'PRAGUE_cum_min_VERTICAL_energy_map.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%  MALL  %%%%%%%%%%%% 
% (i)  Mall energy image function
im = imread('mall.jpg');
energyImage = energy_image(im);
figure; imshow(energyImage);
saveas(gcf, 'mall_energy_image.jpg');

% (ii) Cumulative minimum energy maps
M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
N = cumulative_minimum_energy_map(energyImage, 'VERTICAL');

figure; imagesc(M);
saveas(gcf, 'MALL_cum_min_HORIZONTAL_energy_map.jpg');

figure; imagesc(N);
saveas(gcf, 'MALL_cum_min_VERTICAL_energy_map.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

