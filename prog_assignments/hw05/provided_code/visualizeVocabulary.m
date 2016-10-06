% visualizeVocabulary

disp('Did you change the folder paths? Press Enter to continue, or Ctrl-C to return/terminate.');
pause

% You will need to change the paths below!
framesdir = 'frames_subset/';
fnames_frames = dir([framesdir '*.mat']);
siftdir = 'sift_subset/';
fnames_sift = dir([siftdir '*.mat']);

r = randperm(size(fnames_sift, 1));
r = r(1:200);

descriptors_all = []; % don't worry about efficiency
parent_images = []; % keep track of parent image
features_within_image = [];

for i=1:length(r)
    
    disp(i);
    % index into random item directory and load it in
    % filling all the values we need....
    fname = [siftdir '/' fnames_sift(r(i)).name];        
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    rd = randperm(size(descriptors, 1));
    rd = rd(1:min(10, length(rd)));
    descriptors_all = [descriptors_all; descriptors(rd, :)];
    parent_images = [parent_images; repmat(r(i), length(rd), 1)];
    features_within_image = [features_within_image; rd'];
    
end

disp('kmeans run...');
k = 100; %1500;
[membership, means] = kmeansML(k, descriptors_all');

save('centers.mat', 'membership', 'means')

means = means';

membership_counts = zeros(1, k);
for i = 1:k
    membership_counts(i) = length(find(membership == i));
end
ok_clusters = find(membership_counts >= 25);

centers_dists = dist2(means(ok_clusters, :), means(ok_clusters, :));
[~, max_centers_dist] = max(centers_dists(:));
[c1, c2] = ind2sub(size(centers_dists), max_centers_dist);
c1 = ok_clusters(c1);
c2 = ok_clusters(c2);

figure; hold on
inds = find(membership == c1);
inds = inds(randperm(length(inds)));
inds = inds(1:min(25, length(inds)));

for i = 1:length(inds)
    
    image_id = parent_images(inds(i));
    feat_id = features_within_image(inds(i));
    fname = [siftdir '/' fnames_sift(image_id).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    im = imread([framesdir '/' imname]); 
    im = rgb2gray(im);
    
    patch = getPatchFromSIFTParameters(positions(feat_id, :), scales(feat_id), orients(feat_id), im);
    subplot(5, 5, i); imshow(patch)
    
end

figure; hold on
inds = find(membership == c2);
inds = inds(randperm(length(inds)));
inds = inds(1:min(25, length(inds)));

for i = 1:length(inds)
    
    image_id = parent_images(inds(i));
    feat_id = features_within_image(inds(i));
    fname = [siftdir '/' fnames_sift(image_id).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    im = imread([framesdir '/' imname]); 
    im = rgb2gray(im);
    
    patch = getPatchFromSIFTParameters(positions(feat_id, :), scales(feat_id), orients(feat_id), im);
    subplot(5, 5, i); imshow(patch)
    
end

