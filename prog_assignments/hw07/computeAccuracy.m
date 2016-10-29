function [accuracy] = computeAccuracy(trueLabels, predictedLabels)
    
    correct_count = 0;

    for i = (1 : length(trueLabels))
        
        if trueLabels{i} == predictedLabels{i}
            correct_count = correct_count + 1;
        end
    end

    accuracy = correct_count / length(trueLabels);

end