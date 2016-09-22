%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #03
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Part III: Image Pyramids (15 points)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this problem, you will illustrate different levels of detail in an image, 
% using image pyramids, as discussed in class.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1)  Choose an image that has an interesting variety of texture 
% (from Flickr/Google/Bing or your own images). 
% The image should be at least 640x480 pixels and converted to grayscale. 
% Use the Matlab function rgb2gray.
image = imread('CS1674-HW03/Rainbow.jpg');
image = imresize(image, 0.5);
image = rgb2gray(image);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (2) Write code for a Gaussian and Laplacian pyramids of level N (use for loops). 
% In each level, the resolution should be reduced by a factor of 2. 
% As discussed in class, before each subsampling, the image should be blurred; 
% use the Matlab function imfilter.

% N = 5, just as a starting point for experimentation
N = 5;

% gaussian of laplacian
for y = 1:N
    % gaussian blur
    im_filter = fspecial('gaussian', 30, 10);
    im_blur = imfilter(image, im_filter);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (3) To compute the Laplacian at each stage, remember that your images 
    % (pre- and post-blurring) should be of the same size, 
    % but the image you store in the actual pyramid should be scaled down
    % by a factor of 2

    % laplacian details
    im_details = image - im_blur;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (4) To scale an image down, simply ignore every other pixel. 
    % For example, you can retrieve only pixels in increments of 2. 
    % In Matlab, the way to do that is e.g. im = im(1:2:end, 1:2:end);
    % downsample by a factor of 2
    image = image(1:2:end, 1:2:end);
    figure; imshow(image);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (5) Use the same filter at each step.

    % >>>> Done, because this is a For-loop....

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (6) Your code should include a function with signature 
% [G, L] = pyramids(im, fil);, 
% where G is the Gaussian pyramid and L is the Laplacian pyramid, 
% while im is a grayscale image 
% and fil is the output of fspecial('gaussian', hsize, sigma). 
% G should be a cell array such that G{i} returns the i-th level 
% of the Gaussian pyramid. 
% Similarly L{i} should return the i-th level of the Laplacian pyramid.

% >>> SEE:  'pyramids.m'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (7) Set L{n} = G{n};

% Use the Matlab function rgb2gray.
image = imread('CS1674-HW03/Rainbow.jpg');
image = imresize(image, 0.5);
image = rgb2gray(image);

% also set the filter
im_filter = fspecial('gaussian', 30, 10);


[G, L] = pyramids(image, im_filter);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (8) Your code should also include a script titled image_pyramids.m that
% loads the image, runs the pyramids code, and shows the pyramids. 
% Show a Gaussian and Laplacian pyramid of level 5 for your chosen image 
% using your code. You can show each G{i} and L{i} separately, 
% resulting in 10 separate figures which you label appropriately using title, 
%or you can show them together in 1 subplot with 10 figures or
% 2 subplots with 5 figures. You can (but don't have to) also use the 
% tight_subplot function to format your plot. 

% Show all of these at the same size.

for y = 1:5
    % print gaussian with labels
    str = 'Gaussian Number ';
    str = strcat(str, num2str(y));
    figure; imshow(G{y}); title(str);
end

for y = 1:5
    % print laplacian with labels
    str = 'Laplacian Number ';
    str = strcat(str, num2str(y));
    figure; imshow(L{y}); title(str);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (9)  Also include the original image you chose and the image
% pyramid figure(s) in your submission.