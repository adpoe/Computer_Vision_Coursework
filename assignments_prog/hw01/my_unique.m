function [ num_unique_rows, unique_return_matrix ] = my_unique( input_matrix )
% (19) Implement a function my_unique that returns the number of unique rows in a matrix, 
%       and returns another matrix with any duplicate rows removed. 
%       You cannot just call Matlab's unique.

num_unique_rows = 0;
unique_return_matrix = [];
matrix_highest_dim = 1;


rows_y = size(input_matrix,1);

% getthe current row
    for y = 1:rows_y
        current_row = input_matrix(y,:);
        
        % check all rows after it for equality
        for x = y+1:rows_y
            next_row = input_matrix(x,:);
            
            % if our rows aren't equal and next_row hasn't just been added
            if ~isequal(current_row, next_row)
                
                % guard to make sure we don't double add something
                if size(unique_return_matrix,1) == 0 || ...
                  ~isequal(unique_return_matrix(matrix_highest_dim,:), input_matrix(x,:))
            
                        % ONLY add rows to the unique_return_matrix
                        last = size(unique_return_matrix, 1) + 1;
                        matrix_highest_dim = last;
                        unique_return_matrix(last, :) = input_matrix(x,:);
                    
                end  % end-if
            end  % end-if
            
        end %end-for
    end %endo-for
    
    % clean up at the end, to take care of edge/corner cases
    %if size(unique_return_matrix, 1) > size(input_matrix, 1)
    %unique_return_matrix = sort_rows(unique_return_matrix);
    % to get started
    unique_return_matrix = sortrows(unique_return_matrix);
    %get the size
    matrix_size = size(unique_return_matrix,1);
    % remove rows until there are no dupes
    while matrix_size > size(input_matrix, 1)
        for row_index = 1:matrix_size
            current_row = unique_return_matrix(row_index, :);
            next_row = unique_return_matrix( (row_index + 1), :);
            % if we get a match
            if isequal(current_row, next_row)
                % delete the next row
                unique_return_matrix( (row_index + 1), :) = [];
                % decrement matrix size
                matrix_size = matrix_size - 1;
                % break out of current loop iteration
                break
            end
        end
    end
    
    
    % set return variables
    num_unique_rows = size(unique_return_matrix, 1);
    
end %end-function 

