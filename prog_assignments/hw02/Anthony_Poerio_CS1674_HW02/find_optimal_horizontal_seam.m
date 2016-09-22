% Code written for CS1674 by Adriana Kovashka 
% DO NOT SHARE as students in the next issue might need to implement this

function [horizontalSeam] = find_optimal_horizontal_seam(M)

    [num_rows, num_cols] = size(M);

    horizontalSeam = zeros(num_cols, 1);
          
    [~, ind] = min(M(:, num_cols));
    horizontalSeam(num_cols) = ind;
    
    for j = num_cols:-1:2
        if( (ind > 1) && (ind < num_rows) )
            [~, ind_new] = min([M(ind-1, j-1) M(ind, j-1) M(ind+1, j-1)]);
            ind = ind-2 + ind_new;
        elseif(ind > 1)
            [~, ind_new] = min([M(ind-1, j-1) M(ind, j-1)]);
            ind = ind-2 + ind_new;
        elseif(ind < num_rows)
            [~, ind_new] = min([M(ind, j-1) M(ind+1, j-1)]);
            ind = ind-1 + ind_new;
        else
            % index stays the same
        end
        horizontalSeam(j-1) = ind;
    end
    
   