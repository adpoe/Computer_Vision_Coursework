function [accuracy] = computeAccuracy(trueLabels, predictedLabels)
    % CHANGED THIS TO USE **ARRAYS**
    % >>> NOT 'Cell Arrays'
    correct_count = 0;

    for i = (1 : length(trueLabels))
        
        %if trueLabels{i} == predictedLabels{i} % changed this line {} --> ()
                                                % because no longer using
                                                % cell arrays
                                                
        if trueLabels(i) == predictedLabels(i)                                         
            correct_count = correct_count + 1;
        end
    end

    accuracy = correct_count / length(trueLabels);

end