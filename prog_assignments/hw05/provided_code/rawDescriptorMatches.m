% rawDescriptorMatches
% The code asks the user (you) to select a region from the first image. 
%   MAKE SURE that when you are drawing a polygon region, the last point 
%   you click on overlaps with some point you drew before, so the polygon 
%   can be closed!!!
% The code then determines which SIFT features are within the user-selected
%   region, and finally finds their matches in the second image.

load('twoFrameData');

fprintf('\n\nuse the mouse to draw a polygon, double click to end it\n');
oninds = selectRegion(im1, positions1);

[inds] = matchRawDescriptors(descriptors1(oninds, :), descriptors2);

figure; imshow(im2)
displaySIFTPatches(positions2(inds, :), scales2(inds), orients2(inds), im2);