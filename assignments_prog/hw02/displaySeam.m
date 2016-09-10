function [] = displaySeam( im, seam, seamDirection )
% DISPLAYSEAM displays the selected seam on top of the image
%   im = result of an imread
%   seam = result of find_optimal_vertical_seam or
%   find_optimal_horizontal_seam
%   seamDirection = string 'VERTICAL' or 'HORIZONTAL'
%   OUTPUT = Display the imaged passed in as 'im' with the seam plotted on
%   top of it. Use one plot color for horizontal and another for vertical
%   seems. 

% Use imshow(im) to plot points on top of a displayed image; followed by
% hold on; followed by plot(. . .). The origin of the plot will be the top
% left corner of the image. Note that for the plot, rows are the y-axis,
% and columns are the x-axis

% figure out which direction we are plotting in
if strcmp(seamDirection, 'VERTICAL') == 1
    % define vertical seam
    % along y-axis
    y_axis = 1:size(im,1);
    imshow(im);
    hold on;
    %---> works but along horizontal::  plot(y_axis, seam);
    plot(seam, y_axis);
else 
    % define horiztonal seam
    % along x-axis
    x_axis = 1:size(im,2);
    imshow(im);
    hold on;
    plot(x_axis,seam, 'r');
end




end

