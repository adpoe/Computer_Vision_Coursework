% Code written for CS1674 by Adriana Kovashka 
% DO NOT SHARE as students in the next issue might need to implement this

function [M] = cumulative_minimum_energy_map(energyImage, seamDirection)

    if(strcmp(seamDirection, 'VERTICAL'))
              
        % compute from top to bottom 
        
        [num_rows, num_cols] = size(energyImage);
        M = zeros(size(energyImage));
        M(1:num_rows, 1:num_cols) = -Inf;
        
        M(1, :) = energyImage(1, :);
        
        for i = 2:num_rows
            for j = 1:num_cols
                if(j > 1) 
                    if(j < num_cols)    % standard case 
                        M(i, j) = energyImage(i, j) + min([M(i-1, j-1) M(i-1, j) M(i-1, j+1)]);
                    else    % if only have two cells above (at right image boundary)
                        M(i, j) = energyImage(i, j) + min([M(i-1, j-1) M(i-1, j)]);
                    end
                else        % at left image boundary
                    M(i, j) = energyImage(i, j) + min([M(i-1, j) M(i-1, j+1)]);
                end
                assert(~isinf(M(i, j)));
            end
        end         
           
    else
        assert(strcmp(seamDirection, 'HORIZONTAL'));

        % compute from left to right
        
        [num_rows, num_cols] = size(energyImage);
        M = zeros(size(energyImage));
        M(1:num_rows, 1:num_cols) = -Inf;
        
        M(:, 1) = energyImage(:, 1);
        
        for j = 2:num_cols
            for i = 1:num_rows
                if(i > 1) 
                    if(i < num_rows)    % standard case 
                        M(i, j) = energyImage(i, j) + min([M(i-1, j-1) M(i, j-1) M(i+1, j-1)]);
                    else                % if only have two cells to the left (at bottom image boundary)
                        M(i, j) = energyImage(i, j) + min([M(i-1, j-1) M(i, j-1)]);
                    end
                else                    % at top image boundary 
                    M(i, j) = energyImage(i, j) + min([M(i, j-1) M(i+1, j-1)]);
                end
                assert(~isinf(M(i, j)));
            end
        end      
        
    end
        