function [ reducedColorImage, reducedEnergyImage ] = reduceHeight( im, energyImage)
%REDUCE_HEIGHT Carve seams out of an image height-wise, along the y-axis
%   Pass in the the image, and its energy map --> Get a carved image and
%   a new energy map, so you can repeat the process as long as desired. 

%%%% --> OKAY, need invert this so that it works on a horizontal image

% First, find our Vertical Seam
M = cumulative_minimum_energy_map(energyImage, 'HORIZONTAL');
horizontalSeam = find_optimal_horizontal_seam(M);

% TODO:   TRANSLATE THIS TO WORK HORIZTONALLY, THEN PRODUCE IMAGE OUTPUTS

% So Using another method. THIS WORKS... BUT SLOW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% REMOVE 1-COL FROM ENERGY_IMAGE  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% first define a matrix that is 1 row SMALLER than than input,
% i.e --> (N-1)xM

reducedEnergyImage = zeros(size(energyImage,1)-1, (size(energyImage,2)) );
% Then copy over everyting from previous, full sized energyImage....
% EXCEPT the one row where the y-value we are iterating over
% is the row we have stored in our horizontalSeam
for x = 1:(size(horizontalSeam, 1))
   y_found = false;  
   for y = 1:(size(energyImage,1)-1)
       % don't copy the horizontalSeam over to our new matrix
       if y == horizontalSeam(x)
           y_found = true;
       end
       
       if y_found == false
           reducedEnergyImage(y,x) = energyImage(y,x);
       else
           reducedEnergyImage(y,x) = energyImage(y+1,x);
       end
   end
 end

 % at the end, this yields a matrix that is (N-1)xM and has the
 % horizontalSeam removed from it. 
 % figure; imshow(reducedEnergyImage);
 
%%%%%%%%%%%%%
%%%% END %%%%
%%%%%%%%%%%%%


 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% REMOVE 1-ROW FROM **EACH** RGB CHANNEL IN IMAGE  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% first define a matrix that is 1 row SMALLER than than input,
% i.e --> (N-1)xMx3

%%%%%%%%%%%%%
%%%% RED %%%%
%%%%%%%%%%%%%

reducedColorImage = zeros((size(im,1)-1), size(im,2), 3);
% Then copy over everyting from previous, full sized energyImage....
% EXCEPT the one row where the y-value we are iterating over
% is the row we have stored in our horizontalSeam
 for x = 1:(size(horizontalSeam, 1))
   y_found = false;
   for y = 1:(size(energyImage,1)-1)
       % don't copy the verticalSeam over to our new matrix
       if y == horizontalSeam(x)
           y_found = true;
       end
       
       if y_found == false
           reducedColorImage(y,x,1) = im(y,x,1);
       else
           reducedColorImage(y,x,1) = im(y+1,x,1);
       end
   end
 end
 reducedColorImage = uint8(reducedColorImage);
 % at the end, this yields a matrix that is Nx(M-1)x3 and has the
 % horizontalSeam removed from it. 
 
 %%%%%%%%%%%%%%%
 %%%% GREEN %%%%
 %%%%%%%%%%%%%%%
% Then copy over everyting from previous, full sized energyImage....
% EXCEPT the one row where the y-value we are iterating over
% is the row we have stored in our horizontalSeam
 for x = 1:(size(horizontalSeam, 1)) 
   y_found = false;
    for y = 1:(size(energyImage,1)-1)
       % don't copy the verticalSeam over to our new matrix
       if y == horizontalSeam(x)
           y_found = true;
       end
       
       if y_found == false
           reducedColorImage(y,x,2) = im(y,x,2);
       else
           reducedColorImage(y,x,2) = im(y+1,x,2);
       end
   end
 end
 reducedColorImage = uint8(reducedColorImage);
 % at the end, this yields a matrix that is Nx(M-1)x3 and has the
 % horizontalSeam removed from it. 
 
 %%%%%%%%%%%%%%
 %%%% BLUE %%%%
 %%%%%%%%%%%%%%
% Then copy over everyting from previous, full sized energyImage....
% EXCEPT the one row where the y-value we are iterating over
% is the row we have stored in our horizontalSeam
 for x = 1:(size(horizontalSeam, 1))
   y_found = false;
   for y = 1:(size(energyImage,1)-1)
       % don't copy the verticalSeam over to our new matrix
       if y == horizontalSeam(x)
           y_found = true;
       end
       
       if y_found == false
           reducedColorImage(y,x,3) = im(y,x,3);
       else
           reducedColorImage(y,x,3) = im(y+1,x,3);
       end
   end
 end
 reducedColorImage = uint8(reducedColorImage);
 % at the end, this yields a matrix that is Nx(M-1)x3 and has the
 % horizontalSeam removed from it. 
 
%%%%%%%%%%%%%
%%%% END %%%%
%%%%%%%%%%%%%

end

