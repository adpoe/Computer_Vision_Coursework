function [pyramid] = computeSPMHistogram(im, means)
% INPUTS
%       im = grayscale image whose SIFT features we are going to extract
%       means = cluster centers from the BOW clustering operation
%
% OUTPUTS
%       pyramid = 1xd feature descriptor of the image that we compute
%
% NOTE: --> may pass in optional extra parameters, if it helps
%
    [height, width] = size(im);

    % updated here --> my means is already coming in in this orientation
    %means = means';
    
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    
    [frames, descriptors] = vl_sift(single(im));
     
    % updated here -- changed orientation of descriptors and cast to double
    level_0 = getHistogram(double(descriptors'), means);
  
     % need to initialize to zeros in case we don't have any descriptors
    q1_descriptors = zeros(128,1); % [];
    q2_descriptors = zeros(128,1); % [];
    q3_descriptors = zeros(128,1); % [];
    q4_descriptors = zeros(128,1); % [];
    
    for i = (1 : length(frames))
        x = (frames(1, i)/width) * 100.00;
        y = (frames(2, i)/height) * 100.00;
        
        if x <= 50 && y <= 50
            q1_descriptors = [q1_descriptors descriptors(:, i)];
        elseif x > 50 && y <= 50
            q2_descriptors = [q2_descriptors descriptors(:, i)];
        elseif x <= 50 && y > 50
            q3_descriptors = [q3_descriptors descriptors(:, i)];
        elseif x > 50 && y > 50
            q4_descriptors = [q4_descriptors descriptors(:, i)];
        end
    end
    
    % updated here -- changed orientation of descriptors and cast to double
    level_1 = [getHistogram(double(q1_descriptors'), means) getHistogram(double(q2_descriptors'), means) getHistogram(double(q3_descriptors'), means) getHistogram(double(q4_descriptors'), means)];
    
    % need to initialize to zeros in case we don't have any descriptors
    q1_descriptors = zeros(128,1); % [];
    q2_descriptors = zeros(128,1); % [];
    q3_descriptors = zeros(128,1); % [];
    q4_descriptors = zeros(128,1); % [];
    q5_descriptors = zeros(128,1); % [];
    q6_descriptors = zeros(128,1); % [];
    q7_descriptors = zeros(128,1); % [];
    q8_descriptors = zeros(128,1); % [];
    q9_descriptors = zeros(128,1); % [];
    q10_descriptors = zeros(128,1); % [];
    q11_descriptors = zeros(128,1); % [];
    q12_descriptors = zeros(128,1); % [];
    q13_descriptors = zeros(128,1); % [];
    q14_descriptors = zeros(128,1); % [];
    q15_descriptors = zeros(128,1); % [];
    q16_descriptors = zeros(128,1); % [];
    
    for i = (1 : length(frames))
        x = (frames(1, i)/width) * 100.00;
        y = (frames(2, i)/height) * 100.00;
        
        if     x <= 25  && y <= 25
            q1_descriptors = [q1_descriptors descriptors(:, i)];
        elseif x <= 50  && y <= 25
            q2_descriptors = [q2_descriptors descriptors(:, i)];
        elseif x <= 75  && y <= 25
            q3_descriptors = [q3_descriptors descriptors(:, i)];
        elseif x <= 100 && y <= 25
            q4_descriptors = [q4_descriptors descriptors(:, i)];
        elseif x <= 25  && y <= 50
            q5_descriptors = [q5_descriptors descriptors(:, i)];
        elseif x <= 50  && y <= 50
            q6_descriptors = [q6_descriptors descriptors(:, i)];
        elseif x <= 75  && y <= 50
            q7_descriptors = [q7_descriptors descriptors(:, i)];
        elseif x <= 100 && y <= 50
            q8_descriptors = [q8_descriptors descriptors(:, i)];
        elseif x <= 25  && y <= 75
            q9_descriptors = [q9_descriptors descriptors(:, i)];
        elseif x <= 50  && y <= 75
            q10_descriptors = [q10_descriptors descriptors(:, i)];
        elseif x <= 75  && y <= 75
            q11_descriptors = [q11_descriptors descriptors(:, i)];
        elseif x <= 100 && y <= 75
            q12_descriptors = [q12_descriptors descriptors(:, i)];
        elseif x <= 25  && y <= 100
            q13_descriptors = [q13_descriptors descriptors(:, i)];
        elseif x <= 50  && y <= 100
            q14_descriptors = [q14_descriptors descriptors(:, i)];    
        elseif x <= 75  && y <= 100
            q15_descriptors = [q15_descriptors descriptors(:, i)];        
        elseif x <= 100 && y <= 100
            q16_descriptors = [q16_descriptors descriptors(:, i)];
        end
        
    end
    
    % updated here -- changed orientation of descriptors and cast to double
    level_2 = [getHistogram(double(q1_descriptors'), means) getHistogram(double(q2_descriptors'), means) getHistogram(double(q3_descriptors'), means) getHistogram(double(q4_descriptors'), means) getHistogram(double(q5_descriptors'), means) getHistogram(double(q6_descriptors'), means) getHistogram(double(q7_descriptors'), means) getHistogram(double(q8_descriptors'), means) getHistogram(double(q9_descriptors'), means) getHistogram(double(q10_descriptors'), means) getHistogram(double(q11_descriptors'), means) getHistogram(double(q12_descriptors'), means) getHistogram(double(q13_descriptors'), means) getHistogram(double(q14_descriptors'), means) getHistogram(double(q15_descriptors'), means) getHistogram(double(q16_descriptors'), means)];
    pyramid = [level_0 level_1 level_2];
    
end