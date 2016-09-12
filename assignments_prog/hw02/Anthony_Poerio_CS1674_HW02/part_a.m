%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #2
% Fall 2016
% -- PART A --
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [5 points] Run your reduceHeight function on the provided prague.jpg
% and shrink the height by 100 pixels. Then run your reduceWidth function
% on the provided mall.jpg and shrink the width by 100 pixels. 
% Also show what standard image resizing would do 
% (use B = imresize(A, [numrows numcols])). Display the outputs, save them, 
% and submit them.


%%%%%%%%%%%%%%%%
%%%% PRAGUE %%%%
%%%%%%%%%%%%%%%%
% NOTES: Takes about 2-minutes to run on my computer

% Generate the energy image for prague.jpg
im = imread('prague.jpg');
energyImage = energy_image(im);
figure; imshow(im);


% do a standard re-size on prague.jpg
numrows = size(im,1) - 100;
numcols = size(im,2);
prague_resize_standard = imresize(im, [numrows numcols]);
figure; imshow(prague_resize_standard);
saveas(gcf, 'prague_standard_resize.jpg');


% shrink the prague image by 100px
% re-size mall.jpg with seam carving
[ pragueReducedRGB, pragueReducedEnergy ] = reduceHeight( im, energyImage);
for x=1:99
    [ pragueReducedRGB, pragueReducedEnergy ] = reduceHeight( pragueReducedRGB, pragueReducedEnergy);
end
figure; imshow(pragueReducedRGB);
saveas(gcf, 'prague_seam_carving_resize.jpg');


%%%%%%%%%%%%%%%
%%%% MALL %%%%%
%%%%%%%%%%%%%%%
% NOTES: Takes about 2-minutes to run on my computer

% Generate energy image for mall.jpg
% Generate the energy image for prague.jpg
im = imread('mall.jpg');
energyImage = energy_image(im);
figure; imshow(im);

% do a standard re-size on mall.jpg
numrows = size(im,1);
numcols = size(im,2)-100;
mall_resize_standard = imresize(im, [numrows numcols]);
figure; imshow(mall_resize_standard);
saveas(gcf, 'mall_standard_resize.jpg');


% re-size mall.jpg with seam carving
[ mallReducedRGB, mallReducedEnergy ] = reduceWidth( im, energyImage);
for x=1:99
    [ mallReducedRGB, mallReducedEnergy ] = reduceWidth( mallReducedRGB, mallReducedEnergy);
end
figure; imshow(mallReducedRGB);
saveas(gcf, 'mall_seam_carving_resisze.jpg');

