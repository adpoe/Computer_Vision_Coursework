function [ G, L] = pyramid_resize( im, fil )%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (6) Your code should include a function with signature 
% [G, L] = pyramids(im, fil);, 
% where G is the Gaussian pyramid and L is the Laplacian pyramid, 
% while im is a grayscale image 
% and fil is the output of fspecial('gaussian', hsize, sigma). 
% G should be a cell array such that G{i} returns the i-th level 
% of the Gaussian pyramid. 
% Similarly L{i} should return the i-th level of the Laplacian pyramid.

% assign input variables
im_filter = fil;
image = im;

% define output values
G = {};
L = {};

% gaussian of laplacian
for i = 1:5
    % gaussian blur
    im_blur = imfilter(image, im_filter);
    G{i} = im_blur;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (3) To compute the Laplacian at each stage, remember that your images 
    % (pre- and post-blurring) should be of the same size, 
    % but the image you store in the actual pyramid should be scaled down
    % by a factor of 2

    % laplacian details
    im_details = image - im_blur;
    L{i} = im_details;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (4) To scale an image down, simply ignore every other pixel. 
    % For example, you can retrieve only pixels in increments of 2. 
    % In Matlab, the way to do that is e.g. im = im(1:2:end, 1:2:end);
    % downsample by a factor of 2
    image = im_blur(1:2:end, 1:2:end);
    figure; imshow(image);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (5) Use the same filter at each step.

    % >>>> Done, because this is a For-loop....

end


end

