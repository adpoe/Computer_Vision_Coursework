function [sim] = compareSimilarity(bow1, bow2)

    assert(length(bow1) == length(bow2));

    sim = dot(bow1, bow2) / (norm(bow1, 2) * norm(bow2, 2));

    % other way
    %num = sum(bow1 .* bow2);
    %denom = sqrt(sum(power(bow1, 2))) * sqrt(sum(power(bow2, 2)));
    %sim2 = num/denom;