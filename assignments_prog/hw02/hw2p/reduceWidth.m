function [ reducedColorImage, reducedEnergyImage ] = reduceWidth( im, energyImage )
% REDUCE_WIDTH Reduce the width of an input matrix, carving out the optimal seam
%   im = resulte of reading in an image with imread - NxMx3 Matrix, uint8
%   energyImage = result of calling energy_image on the (im) structure
%   OUTPUT - a 2D matrix of type double
%   reducedColorImage = same matrix as "im", but with WIDTH reduce by 1px,
%   and the optimal seam carved out of it
%   reducedEnergyImage = 2D matrix of type double, same the same as
%   energyImage but with the width reduce by 1px

% remove rows or cols by setting them to the empty vector, []
% ---> Kept getting errors when trying to use the empty vector, like this:
% rm = energyImage;
% x_axis = 1:size(energyImage,2);
% rm(verticalSeam,x_axis) = [];
% ----> ERROR:   "A null assignment can have only one non-colon index."
% But I can set everything in that column to a value without issue...


% Can maybe make the whole thing a single vector, remove with ind2sub, and
% then make the thing a vector of size Nx(M-1) ? 

% First, find our Vertical Seam
N = cumulative_minimum_energy_map(energyImage, 'VERTICAL');
verticalSeam = find_optimal_vertical_seam(N);


% So Using another method. THIS WORKS... BUT SLOW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% REMOVE 1-COL FROM ENERGY_IMAGE  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% first define a matrix that is 1 column SMALLER than than input,
% i.e --> Nx(M-1)
condition_met = 0;
reducedEnergyImage = zeros(size(energyImage,1), (size(energyImage,2)-1) );
% Then copy over everyting from previous, full sized energyImage....
% EXCEPT the one column where the x-value we are iterating over
% is the column we have stored in our verticalSeam
 for y = 1:size(verticalSeam,1)
   for x = 1:(size(energyImage, 2) - 1)
       % don't copy the verticalSeam over to our new matrix
       if x ~= verticalSeam(y)
           % BUT copy everything else...
           reducedEnergyImage(y,x) = energyImage(y,x);
       else
           condition_met = condition_met + 1;
       end   
   end
 end

 % at the end, this yields a matrix that is Nx(M-1) and has the
 % verticalSeam removed from it. 
 
%%%%%%%%%%%%%
%%%% END %%%%
%%%%%%%%%%%%%


 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% REMOVE 1-COL FROM **EACH** RGB CHANNEL IN IMAGE  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% first define a matrix that is 1 column SMALLER than than input,
% i.e --> Nx(M-1)x3
condition_met = 0;


%%%%%%%%%%%%%
%%%% RED %%%%
%%%%%%%%%%%%%

reducedColorImage = zeros(size(im,1), (size(im,2)-1), 3);
% Then copy over everyting from previous, full sized energyImage....
% EXCEPT the one column where the x-value we are iterating over
% is the column we have stored in our verticalSeam
 for y = 1:size(verticalSeam,1)
   for x = 1:(size(im, 2) - 1)
       % don't copy the verticalSeam over to our new matrix
       if x ~= verticalSeam(y)
          % BUT copy everything else...
           reducedColorImage(y,x,1) = im(y,x,1);
       else 
           condition_met = condition_met + 1;
       end   
   end
 end
 reducedColorImage = uint8(reducedColorImage);
 % at the end, this yields a matrix that is Nx(M-1)x3 and has the
 % verticalSeam removed from it. 
 
 %%%%%%%%%%%%%%%
 %%%% GREEN %%%%
 %%%%%%%%%%%%%%%
 
% Copy over everyting from previous, full sized energyImage....
% EXCEPT the one column where the x-value we are iterating over
% is the column we have stored in our verticalSeam
 for y = 1:size(verticalSeam,1)
   for x = 1:(size(im, 2) - 1)
       % don't copy the verticalSeam over to our new matrix
       if x ~= verticalSeam(y)
          % BUT copy everything else...
           reducedColorImage(y,x,2) = im(y,x,2);
       else 
           condition_met = condition_met + 1;
       end   
   end
 end
 reducedColorImage = uint8(reducedColorImage);
 
 %%%%%%%%%%%%%%
 %%%% BLUE %%%%
 %%%%%%%%%%%%%%
% Copy over everyting from previous, full sized energyImage....
% EXCEPT the one column where the x-value we are iterating over
% is the column we have stored in our verticalSeam
 for y = 1:size(verticalSeam,1)
   for x = 1:(size(im, 2) - 1)
       % don't copy the verticalSeam over to our new matrix
       if x ~= verticalSeam(y)
          % BUT copy everything else...
           reducedColorImage(y,x,3) = im(y,x,3);
       else 
           condition_met = condition_met + 1;
       end   
   end
 end
 reducedColorImage = uint8(reducedColorImage);
 
%%%%%%%%%%%%%
%%%% END %%%%
%%%%%%%%%%%%%

end

