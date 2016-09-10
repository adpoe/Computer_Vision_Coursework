function [ energy_matrix ] = energy_image( image_matrix_input )
%ENERGY_IMAGE Computes the energy at each pixel in a matrix nxmx3 matrix
%   Outputs a 2D-matrix containing energy equation outputs, of datatype DBL

% convert image to grayscale first
G = rgb2gray(image_matrix_input);

% convert to double
G2 = im2double(G);

% create X and Y filters
horizontal_filter = [1 0 -1; 2 0 -2; 1 0 -1];
vertical_filter = [1 2 1; 0 0 0 ; -1 -2 -1];

% using imfilter to get our gradient in each direction
filtered_x = imfilter(G2, horizontal_filter);
filtered_y = imfilter(G2, vertical_filter);

energy_matrix = zeros(size(G2,1), size(G2,2));
% compute the energy at each pixel using the magnitude of the x and y
% gradients:  sqrt((dI/dX)^2+(dI/dY)^2))
for y = 1:size(G2, 1)
    for x = 1:size(G2,2)
        % calculate energy function
        y_magnitude = filtered_y(y,x) ^ 2;
        x_magnitude = filtered_x(y,x) ^ 2;
        energy_output = sqrt( y_magnitude + x_magnitude );
        % fill energy matrix with our calculation
        energy_matrix(y,x) = energy_output;
    end
end

end

