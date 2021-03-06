%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #03
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Part I: Image Representation with Filters (25 points)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) Download these images: cardinal1, cardinal2, leopard1, leopard2, panda1, panda2. 
%  As you can see, there are two images for each of three animal categories. 
%  Use a cell array to store the image filenames in Matlab, 
%  so you can use matrix/vector indices to refer to the k-th image. 
%  For simplicity, convert all images to the same square size (e.g. 512x512).

% Store the image filenames in a cell array
ImageNames = {'CS1674-HW03/cardinal1.jpg', 'CS1674-HW03/cardinal2.jpg';
              'CS1674-HW03/leopard1.jpg', 'CS1674-HW03/leopard2.jpg';
              'CS1674-HW03/panda1.jpg', 'CS1674-HW03/panda2.jpg'};

% Create an array that maps our image names to their array representations
ImageArrays = {zeros(512,512), zeros(512,512);
               zeros(512,512), zeros(512,512);
               zeros(512,512), zeros(512,512)};

% for every image in ImageNames, do an imread on the filename,
% and store the resulting image in the ImageArrays cell
for y = 1:size(ImageNames, 1)
    for x = 1:size(ImageNames, 2)
        % read each image and convert to 512x512
        fname = ImageNames{y,x};
        
        I = imread(fname);
        I = double(I);
        
        % >>> CONVERT TO 512x512
        resize = imresize(I, [512,512]);
        
        % put result in ImageArray, at same index
        ImageArrays{y,x} = resize;
    end
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (2) Download the Leung-Malik filter bank code (one function) 
% and read the description at the top of how to run it. 
% Run the code to obtain the filter bank F. You only need to do this once.

% function is in file named: 'makeLMfilters.m'
F = makeLMfilters();






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (3) For each image, you need to do the following. First, read in the image, 
% and reduce its size by 0.5 or 0.25 (the smaller the faster it will be to
% convolve) using Matlab's imresize. 
% Then convolve each pixel in your image with each of the 48 filters. 
% i.e. with each F(:, :, i). This would allow you to generate images
% like the responses to the Capitol image shown in class. 
% Use the function imfilter(image, filter). For three of the six images,
% show the response of the image to each filter, using subplots. 


% Read the image and reduce its size by 0.5 or 0.25
% for every image in Imagenames, do an imread on the filename,
% and store the resulting image in the ImageArrays cell
for y = 1:size(ImageNames, 1)
    for x = 1:size(ImageNames, 2)
        % read each image and convert to 512x512
        fname = ImageNames{y,x};
        
        I = imread(fname);
        I = double(I);
        
        % >>> CONVERT TO 3/4 size
        resize = imresize(I, [512,512]);
        %resize = imresize(I, 1.0);
        
        % put result in ImageArray, at same index
        ImageArrays{y,x} = resize;
    end
end


% convolve each pixel with each of the 48 filters
ImageList = ImageArrays(:);
for y = 1:size(ImageList,1)
    % grab the image
    image = ImageList{y};
    
    %convert it to gray
    image = rgb2gray(image);
    
    % run each filter on the image
    for i = 1:size(F,3)
        filter = F(:, :, i);
        imfilter(image, filter);    
    end 
end


% for three of the six images, show the response to each filter,
% using subplots

Nums = [1:48];
% Show response to each filter using sublots for three images
count = 1;
ImageList = ImageArrays(:);
for y = 2:2:size(ImageList(:),1)
    % run each filter on the image
    for i = 1:size(F,3)
        % grab the image
        image = ImageList{y};
    
        %convert it to gray
        %image = rgb2gray(image);
        
        %%%% Compute the filter %%%%
        filter = F(:, :, i);
        imfilter(image, filter);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% UNCOMMENT THIS TO >> SHOW << INSTEAD OF SAVE %%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % show the image
        %figure;
        %subplot(1, 2, 1); imagesc(filter);
        %subplot(1, 2, 2); imagesc(image);
        %%%%%%%%%%%%%%%%%%% END CODE FOR SHOW %%%%%%%%%%%%%%%%%
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%% CODE TO SAVE ALL 48 IMAGES %%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % >>> COMMENT OUT THIS SECTION IF YOU DON'T WANT TO SAVE <<
        % create a file name to save
        if count <= 48
            fname = 'leopard1_filter';
        elseif count <= (48*2)
            fname = 'cardinal2_filter';
        else 
            fname = 'panda2_filter';
        end
        % concat the filename
        fname = strcat(fname, num2str(Nums(1,i)));
        fname = strcat(fname, '.png');
        
        % save the image
        figure('Visible', 'Off'); 
        subplot(1, 2, 1); imagesc(filter);
        subplot(1, 2, 2); imagesc(image);
        saveas(gcf, fname);
        fprintf('Saving file: %s\n',fname);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % keep count
        count = count + 1;
    end 
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (4) For each image, compute a histogram over the filter responses. 
% Let filt_im = imfilter(im, F(:, :, j)); filt_im = filt_im(:); 
% be the vector containing the responses to the i-th filter.
% Use histc to compute a histogram over the responses, 
% after fixing the bin edges to 2.^(0:0.5:7). 
% Then concatenate the histograms for all filters, resulting in a 1x720 vector. 
% This vector is now the descriptor for the image. 
% You will have one descriptor per image.
image_descriptors = [];
for y = 1:size(ImageList,1)
    % create a vector we can concat into
    all_responses = [];
    for j = 1:size(F,3)
        % get image reference
        im = ImageList{y};
        
        % compute the vector response to j-th filter
        filt_im = imfilter(im, F(:, :, j)); 
        filt_im = filt_im(:); 

        %bin_edges = 48 * length(2.^(0:0.5:7));  
        bin_edge =  length(2.^(0:0.5:7));
        [response] = histc(filt_im, 1:bin_edge);
        % each N is 48, so you concat them all and we get 720
        all_responses = cat(1, all_responses, response);
    end    
    % get a 1x720 vector at the end of this process, that's our image
    % vector--> the descriptor for filtering everything over this filter
    % bank...
    descriptor_vector = all_responses';
    % and we want to store all of the vectors, so that we have 6x720 vectors
    image_descriptors = cat(1, image_descriptors, descriptor_vector);
end

% At the end of this process, the image_descriptors variable has 6 vectors,
% each of which are image descriptors, of length 720... and every 15
% columns maps to ONE of the filters we ran on the image...







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (5) Now compute the Euclidean distance between pairs of images. As discussed in class, 
% Euclidean distance measures the square root of the sum of the squared element-wise distances 
% between the image descriptors. Initialize (set to []) one variable to store within-category 
% distances (distances between images that are of the same animal category), 
% and another to store between-category distances (distance between images 
% showing different animal categories). Then iterate over the image pairs
% and concatenate the distance for that image pair to the correct (within_ or between_) variable.

% define matrices that will hold all of our distance vectors for each image 
within_cat_distance_vectors = [];
between_cat_distance_vectors = [];

%%%% DISTANCE CALCULATION  %%%%%
% compute individual distnaces between all images 
for y = 1:size(ImageNames(:))
    
    within_category_dist = [];
    between_category_dist = [];
    
    for x = 1:size(ImageNames(:))
        
        % skip self-distance
        if x == y
            %disp 'Found self-distance, skipping';
            continue
        end
        
        % check if we are within-category (based on how I defined this
        % cell-array)       
        if x == (y+3) || x == (y-3)
            difference = image_descriptors(y,:) - image_descriptors(x, :);
            difference_squared = difference .^ 2;
            sum_of_difference_squared = sum(difference_squared);
            euclidean_distance = sqrt(sum_of_difference_squared);
            within_category_dist = cat(1, within_category_dist, euclidean_distance);
            %disp 'Found within-pair'
        else
            difference = image_descriptors(y,:) - image_descriptors(x, :);
            difference_squared = difference .^ 2;
            sum_of_difference_squared = sum(difference_squared);
            euclidean_distance = sqrt(sum_of_difference_squared);
            between_category_dist = cat(1, between_category_dist, euclidean_distance);
            %disp 'Found between-pair'
        end  
        
    end
   
    % concat our distance vectors at end
    within_cat_distance_vectors = cat(1, within_cat_distance_vectors, within_category_dist(:));
    between_cat_distance_vectors = cat(1, between_cat_distance_vectors, between_category_dist(:));

end

% use unique on each vector list to ensure no double counting
within_cat_distance_vectors = unique(within_cat_distance_vectors);
between_cat_distance_vectors = unique(between_cat_distance_vectors);








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (6) Print the mean of the within-category and between-category distances. 
% Which one is smaller? By how much? Is this what you would expect? 
% Why or why not? Answer these questions in a text file called responses.txt 
% which you include in your submission zip file.
%%%
% (8) run each filter. take mean of result... put all in a 1x48 matrix

mean_within_cat = mean(within_cat_distance_vectors);
mean_between_cat = mean(between_cat_distance_vectors);

disp('6.--------- MEAN TAKING WHOLE FILTER INTO ACCOUNT ------');
fprintf('WITHIN-CATEGORY DISTANCE MEAN = %u\n', mean_within_cat);
fprintf('BETWEEN-CATEGORY DISTANCE MEAN = %u\n', mean_between_cat);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (7) Now let's compute the image represenation in a different way, again using filters. 
% However, rather than computing a histogram, 
% each image's representation will be the mean response across all pixels to each of the filters, 
% resulting in one mean value per filter and an overall image representation of size 1x48. 
% Repeat the process above to compute within-category and between-category distances. 
% Now how does average within-category and between-category distance compare? 
% Is this more in line with what you would expect?


%%%%%%%%%% >>> TAKES ABOUT 1-min to RUN (on my computer) <<<< %%%%%%%%%%%%

% make a matrix to store all six 1x48 image reps
all_six_image_reps = ones(6,48);


for y = 1:size(ImageList,1)
    % make a structure to store our image rep for this iteration
    image_representation = ones(1,48);
    
    for j = 1:size(F,3)
        % get image reference
        im = ImageList{y};
        
        % compute the vector response to j-th filter
        filt_im = imfilter(im, F(:, :, j)); 
        filt_im = filt_im(:); 

        % compute **mean** of the filter image
        mean_filt_im = mean(filt_im);
        
        % store that mean in our image representation vector
        image_representation(1,j) = mean_filt_im;
        
    end    
    
    % store our image representation in our matrix of image representatinos
    all_six_image_reps(y,:) = image_representation(:);
end

%%%%% AT END OF THIS PROCESS, WE HAVE ALL SIX IMAGE REPS IN A MATRIX %%%%%
% Now, need to find the category distances again....

% % % % % %                            % % % % % % 
% % % % % %  Euclidean Distance again  % % % % % % 
% % % % % %                            % % % % % % 
% define matrices that will hold all of our distance vectors for each image 
within_cat_distance_vectors = [];
between_cat_distance_vectors = [];

%%%% DISTANCE CALCULATION  %%%%%
% compute individual distances between all images 
for y = 1:size(ImageNames(:))
    
    within_category_dist = [];
    between_category_dist = [];
    
    for x = 1:size(ImageNames(:))
        
        % skip self-distance
        if x == y
            %disp 'Found self-distance, skipping';
            continue
        end
        
        % check if we are within-category (based on how I defined this
        % cell-array)       
        if x == (y+3) || x == (y-3)
            difference = all_six_image_reps(y,:) - all_six_image_reps(x, :);
            difference_squared = difference .^ 2;
            sum_of_difference_squared = sum(difference_squared);
            euclidean_distance = sqrt(sum_of_difference_squared);
            within_category_dist = cat(1, within_category_dist, euclidean_distance);
            %disp 'Found within-pair'
        else
            difference = all_six_image_reps(y,:) - all_six_image_reps(x, :);
            difference_squared = difference .^ 2;
            sum_of_difference_squared = sum(difference_squared);
            euclidean_distance = sqrt(sum_of_difference_squared);
            between_category_dist = cat(1, between_category_dist, euclidean_distance);
            %disp 'Found between-pair'
        end  
        
    end
   
    % concat our distance vectors at end
    within_cat_distance_vectors = cat(1, within_cat_distance_vectors, within_category_dist(:));
    between_cat_distance_vectors = cat(1, between_cat_distance_vectors, between_category_dist(:));

end



% use unique on each vector list to ensure no double counting
within_cat_distance_vectors = unique(within_cat_distance_vectors);
between_cat_distance_vectors = unique(between_cat_distance_vectors);


% Print the means again
mean_within_cat = mean(within_cat_distance_vectors);
mean_between_cat = mean(between_cat_distance_vectors);
disp('7.-------USING MEAN ACROSS ALL 48 FILTERS INDIVIDUALLY------')
fprintf('WITHIN-CATEGORY DISTANCE MEAN = %u\n', mean_within_cat);
fprintf('BETWEEN-CATEGORY DISTANCE MEAN = %u\n', mean_between_cat);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (8) Finally, let's just use the image pixels i.e. im(:) as the representation/description. 
% Compute a histogram as for the texture histogram representation (the first one you tried),
% and use 0:5:255 as the bin edges. Compute within-/between-category distances again.

% 6-images, 52 bin-edges in our histogram
image_descriptors = zeros(6, 52);
for y = 1:size(ImageList,1)
    % create a vector we can concat into
    % all_responses = [];
    %for j = 1:size(F,3)
        % get image reference
        im = ImageList{y};
        
        % compute the vector response to j-th filter
        %filt_im = imfilter(im, F(:, :, j)); 
        %filt_im = filt_im(:); 
        filt_im = im(:);
        
        %bin_edges = 48 * length(2.^(0:0.5:7));  
        bin_edge =  length(0:5:255);
        [response] = histc(filt_im, 1:bin_edge);
        % each N is 48, so you concat them all and we get 720
        %all_responses = cat(1, all_responses, response);
    %end    
    % get a 1x720 vector at the end of this process, that's our image
    % vector--> the descriptor for filtering everything over this filter
    % bank...
    %descriptor_vector = all_responses';
    % and we want to store all of the vectors, so that we have 6x720 vectors
    %image_descriptors = cat(1, image_descriptors, descriptor_vector);
    image_descriptors(y, :) = response;
end

% At the end of this process, the image_descriptors variable has 6 vectors,
% each of which are image descriptors, of length 52 (number of bins in our
% histogram), one for every 5 values between 0-->255


%%%%% COMPUTE BETWEEN and WITHIN Category Distances Again %%%%%
%%%% DISTANCE CALCULATION  %%%%%
% compute individual distances between all images 
for y = 1:size(ImageNames(:))
    
    within_category_dist = [];
    between_category_dist = [];
    
    for x = 1:size(ImageNames(:))
        
        % skip self-distance
        if x == y
            %disp 'Found self-distance, skipping';
            continue
        end
        
        % check if we are within-category (based on how I defined this
        % cell-array)       
        if x == (y+3) || x == (y-3)
            difference = image_descriptors(y,:) - image_descriptors(x, :);
            difference_squared = difference .^ 2;
            sum_of_difference_squared = sum(difference_squared);
            euclidean_distance = sqrt(sum_of_difference_squared);
            within_category_dist = cat(1, within_category_dist, euclidean_distance);
            %disp 'Found within-pair'
        else
            difference = image_descriptors(y,:) - image_descriptors(x, :);
            difference_squared = difference .^ 2;
            sum_of_difference_squared = sum(difference_squared);
            euclidean_distance = sqrt(sum_of_difference_squared);
            between_category_dist = cat(1, between_category_dist, euclidean_distance);
            %disp 'Found between-pair'
        end  
        
    end
   
    % concat our distance vectors at end
    within_cat_distance_vectors = cat(1, within_cat_distance_vectors, within_category_dist(:));
    between_cat_distance_vectors = cat(1, between_cat_distance_vectors, between_category_dist(:));

end



% use unique on each vector list to ensure no double counting
within_cat_distance_vectors = unique(within_cat_distance_vectors);
between_cat_distance_vectors = unique(between_cat_distance_vectors);
% Print the means again
mean_within_cat = mean(within_cat_distance_vectors);
mean_between_cat = mean(between_cat_distance_vectors);
disp('8.-------USING MEAN ACROSS PIXEL REPRESENTATIONS ------')
fprintf('WITHIN-CATEGORY DISTANCE MEAN = %u\n', mean_within_cat);
fprintf('BETWEEN-CATEGORY DISTANCE MEAN = %u\n', mean_between_cat);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (9) Which of the three types of descriptors that you used is the best one? 
% How can you tell? Include your reasoning in your response. 
% Don't worry about whether you get the answer that I expect,
% I care more about your reasoning than the actual answer, 
% and your response in the text file mentioned above.

% >>>> SEE FILE NAMED:  'responses.txt' for answer





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (10)  Include all your code in a script compare_filter_responses.m.

% >>>>> CONFIRMING:  Fthis file is named 'compare_filter_responses.m



