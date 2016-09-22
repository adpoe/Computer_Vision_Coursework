%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #2
% Fall 2016
% -- PART C --
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [15 points] Use your system with different kinds of images and seam combinations, 
% and see what kind of interesting results it can produce. 
% The goal is to form some perceptually pleasing outputs where 
% the resizing better preserves content than a blind resizing would, 
% as well as some examples where the output looks unrealistic or has artifacts 
% ("failure cases"). 
% Include results for at least THREE images of your own choosing. 
% Include an example or two of a "bad" outcome. 
% Be creative in the images you choose, 
% and in the amount of combined vertical and horizontal carvings you apply. 
% Try to predict types of images where you might see something interesting happen. 
% It's ok to fiddle with the parameters (seam sequence, number of seams, etc) 
% to look for interesting and explainable outcomes. 
% For each result, include the following things, 
% clearly labeled (see title function):
%       * the original input image,
%       * your system's resized image,
%       * the result one would get if instead a simple resampling were used (via Matlab's imresize),
%       * the input and output image dimensions,
%       * the sequence of enlargements and removals that were used, and
%       * a qualitative explanation of what we're seeing in the output.


% GOOD OUTCOMES
% (1) A Mountain Landscape From National Geographic
%     --> Believe that seam carving will work well on this since there are
%     large areas on the photo which have a single uniform color, and these
%     can be carved out without damaging the overall proportions.
% Generate the energy image for Mountains.jpg
im = imread('Mountains.jpg');
energyImage = energy_image(im);
figure; title('Mountains - Original Input image-708x945px'); imshow(im);

% do a standard re-size on Mountains.jpg
numrows = size(im,1) - 199;
numcols = size(im,2);
im_resize_standard = imresize(im, [numrows numcols]);
figure; title('Mountains - Standard Resize image-608x945'); 
imshow(im_resize_standard);
saveas(gcf, 'D_1_standard_resize.jpg');


% re-size mountains.jpg with seam carving
[ imReducedRGB, imReducedEnergy ] = reduceHeight( im, energyImage);
for x=1:199
    [ imReducedRGB, imReducedEnergy ] = reduceHeight( imReducedRGB, imReducedEnergy);
end
figure; title({'Mountains - Seam Carving--608x945'; 'Removes area from clouds instead of shrinking image non-uniformly and distorting it'}); 
imshow(imReducedRGB);
saveas(gcf, 'D_1_seam_carving_resize.jpg');

% (2) A Field in Provence
%   --> Believe that because of the repeated form (columns of flowers)
%   we'll be able to seam carve the width quite a lot, without losing the
%   spirit of the image. We'll just be removing repeated colors within the
%   rows of flowers--and the colors inside each row are roughyl uniform. 
% Generate the energy image for Provence.jpg
im = imread('Provence.jpg');
energyImage = energy_image(im);
figure; title('Provence - Original Input image-1424x1900px'); 
imshow(im);

% do a standard re-size on Provence.jpg
numrows = size(im,1);
numcols = size(im,2)-450;
im_resize_standard = imresize(im, [numrows numcols]);
figure; title('Provence - Standard Resize image-1424x1650'); 
imshow(im_resize_standard);
saveas(gcf, 'D_2_standard_resize.jpg');


% re-size mall.jpg with seam carving
[ imReducedRGB, imReducedEnergy ] = reduceWidth( im, energyImage);
for x=1:450
    [ imReducedRGB, imReducedEnergy ] = reduceWidth( imReducedRGB, imReducedEnergy);
    fprintf('Working on iteration %u\n', x);
end
figure; title({'Provence - Seam Carving--1424x1650'; 'Removes redundant area in the rows of flowers, instead of shrinking image non-uniformly and distorting it'}); 
imshow(imReducedRGB);
saveas(gcf, 'D_2_seam_carving_resize.jpg');

% BAD OUTCOMES

% (3) Artwork - Picasso's Blue Room
%   --> Believe this will re-size badly because the image is complex, and
%   the lines are not hard edges, but rather loose brush strokes. Moreover
%   this image is from Picasso's blue period, and the overall color palette of
%   the image is roughly uniform--blue hues. Picasso's work plays tricks on
%   the eyes, and he plays with proportions, foreshortening, etc., in
%   intricate ways. So I believe the image will look very strange after a
%   seam carving re-size.
% Generate the energy image for blue_room.jpg
im = imread('blue_room.jpg');
energyImage = energy_image(im);
figure; imshow(im);

% do a standard re-size on blue_room.jpg
numrows = size(im,1)-200;
numcols = size(im,2)-450;
im_resize_standard = imresize(im, [numrows numcols]);
figure; imshow(im_resize_standard);
saveas(gcf, 'D_3_standard_resize.jpg');

% re-size mall.jpg with seam carving -- width
[ imReducedRGB, imReducedEnergy ] = reduceWidth( im, energyImage);
for x=1:449
    [ imReducedRGB, imReducedEnergy ] = reduceWidth( imReducedRGB, imReducedEnergy);
    fprintf('Working on iteration %u\n', x);
end
% re-size mall.jpg with seam carving -- height
for x=1:200
    [ imReducedRGB, imReducedEnergy ] = reduceHeight( imReducedRGB, imReducedEnergy);
    fprintf('Working on iteration %u\n', x);
end
figure; imshow(imReducedRGB);
saveas(gcf, 'D_3_seam_carving_resize.jpg');

% (4) Circuit Board
%   --> Believe this will re-size poorly with seam carving because the
%   image is very intracate, with lots of twists and turns in the circuit
%   board. When seams get carved out, the circuit connections--which are
%   only a few px wide--will severed, showing that the photo was clearly
%   manipulated in some way.
im = imread('circuit_board.jpg');
energyImage = energy_image(im);
figure; imshow(im);

% do a standard re-size on blue_room.jpg
numrows = size(im,1)-200;
numcols = size(im,2)-100;
im_resize_standard = imresize(im, [numrows numcols]);
figure; imshow(im_resize_standard);
saveas(gcf, 'D_4_standard_resize.jpg');

% re-size with seam carving -- width
[ imReducedRGB, imReducedEnergy ] = reduceWidth( im, energyImage);
for x=1:99
    [ imReducedRGB, imReducedEnergy ] = reduceWidth( imReducedRGB, imReducedEnergy);
    fprintf('Working on iteration %u\n', x);
end
% re-size with seam carving -- height
for x=1:200
    [ imReducedRGB, imReducedEnergy ] = reduceHeight( imReducedRGB, imReducedEnergy);
    fprintf('Working on iteration %u\n', x);
end
figure; imshow(imReducedRGB);
saveas(gcf, 'D_4_seam_carving_resize.jpg');
