%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #2
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
figure; displaySeam(im, verticalSeam, 'VERTICAL');

% (5) Reduced Color Image Functions
[reducedColorImage,reducedEnergyImage] = reduceWidth(im, energyImage);
%imshow(reducedColorImage);
%imshow(reducedEnergyImage);
[reducedColorImage,reducedEnergyImage] = reduceHeight(im, energyImage);



% Testing
rm = energyImage;
% successfully removes 1 col, WIDTH
rm(:,1) = [];
% now try passing it the horiztonal seam, which is the correct
% dimension...instead of the : operator, which vectorizes first col
rm = energyImage;
rm(verticalSeam(:), 1) = [];
x_axis = 1:size(energyImage,2);
y_axis = 1:size(energyImage,1);
rm(verticalSeam, y_axis) = 4.999;
rm(verticalSeam, 1) = 0.000;
rm(verticalSeam, 1) = [];



for y = 1:size(energyImage(1))
    rm(verticalSeam(y), 1) = 0;
end



% Can maybe make the whole thing a single vector, remove with ind2sub, and
% then make the thing a vector of size Nx(M-1) ? 
vectorEnergy = N(:);

im(verticalSeam(1), 1) = [];
verticalSeam(1) 
y_seam = zeros(size(im,1), 1);
% build array indices
for y = 1:size(im,1)
    for x = size(im,2)
        
    end
end

for j = 1:x
    m = horizontalSeam(j) : y-1;
end





