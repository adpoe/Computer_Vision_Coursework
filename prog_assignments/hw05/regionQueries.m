%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #5
% Fall 2016
%
% 'regionQueries.m' --> a script to demonstrate what fames/images are 
%       retriev ed when we do a search using region queries, for 5 query
%       regions (i.e. - polgyon regions from frames which you select
%       with a mouse). For each query, show the top 3 retrieved frames when
%       the SIFT descriptors in the selected region are used to form
%       a bag of words, and that bag of words is mtached against the 
%       bag of words for each frame. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Start by loading in some data, just pick the first image for now
%%%%%% From our load data example %%%%%%%%%%
framesdir = 'frames_subset/';
siftdir = 'sift_subset/';
fnames = dir([siftdir '*.mat']);
% Get a list of all the .jpeg and .mat files in the two directories, respectively.
% There is one .mat file per .jpeg frame/image
assert(size(fnames, 1) > 0);
fnames2 = dir([framesdir '*.jpeg']);
assert(size(fnames2, 1) > 0);
assert(all(size(fnames) == size(fnames2)));

% just pick 100, as noted, for debugging purposes 
i = 100; 
% load that file
fname = [siftdir '/' fnames(i).name];
load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
numfeats = size(descriptors,1);


% read in the associated image
imname = [framesdir '/' imname]; % add the full path
im = imread(imname);

%%%%%%%%%%% end load data %%%%%%%%%%%%%%%%%%


%%% >>> NEED TO PICK 5 separate query regions and show results for each

% 1.  Form a query from a region within a frame. Select a polygonal region
%       interactively with the mouse, and compute a bag of words histogram
%       from ONLY the SIFT descriptors that fall within that region
%       see:  selectRegion.m code, (provided)

% used the code from loadData as an example
oninds = selectRegion(im, positions);
imshow(im);
displaySIFTPatches(positions(oninds,:), scales(oninds), orients(oninds), im); 
plot(positions(:,1), positions(:,2), 'ro');
title('showing features within region of interest in cyan, and all feature positions in red');
    

% 2. Then compute BOW for ALL other video frames, and compare how similar
%       the BOW for your for your query region is to any other from BOW.
%       Use the **compareSimilarity** function (provided)
%       - Finally, rank the the retrieved frames by how similar they 
%       are to the query, and return the top 3.
load('centers.mat');
bow_for_selected_im = computeBOWRepr(descriptors, means);
similarities = zeros(200,1); % may need to concat later, but this okay for now

% just do first 200 frames for now
for index = 1:200
       
    % load that file
    fname = [siftdir '/' fnames(index).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);
    
    % get bow for current file
    current_bow = computeBOWRepr(descriptors, means);
    
    % compare similarity
    sim = compareSimilarity(bow_for_selected_im, current_bow);
    
    % store result of that comparison, 
    % so we can sort later
    % and find top 3
    similarities(index,1) = sim;
    
end

% get top 3 frames, after this
[sorted_similarities, inds] = sort(similarities, 1);

% show the top 3 images
for i = 1:3
    % just pick 100, as noted, for debugging purposes 
    index = inds(i); 
    % load that file
    fname = [siftdir '/' fnames(index).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);


    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
    figure; imshow(im);
end


% 3. In final submission, include each of the 5 queries (take a screenshot
%       of the image with selected region) along with its most similar 3
%       images, and explain what you observe in the results in a text file,
%       search.txt. 
%       - It should be clear which query image goes with which 3 retrieved
%       frames. Include example(s) where the same object appears amidst
%       different objects or backgrounds, and also include a few failure
%       cases where the returned results don't make any sense.
%            --> this function should take a few minutes PER query frame
%                and need to show 5 frames. 
%                TO DEBUG, try using frame 100 as the query and
%                a chunk of the patterned dress as the region.
%                And only compute BOW similarity for the first 200 frames.