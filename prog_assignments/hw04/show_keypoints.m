
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #4
% Fall 2016 
%
% Show Keypoints for 10 different pictures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% (1) Pittsburgh.png %%%%%%%%%%%%%
image = imread('pittsburgh.png');
image = imresize(image, 0.75);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    %plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) / 1000000000);
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_pittsburgh_corners.png');
hold off

% get the feature descriptors via SIFT
[ pgh_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% (2) Rainbow.jpg %%%%%%%%%%%%
image = imread('Rainbow.jpg');
image = imresize(image, 0.5);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_rainbow_corners.png');
hold off

% get the feature descriptors via SIFT
[ rainbow_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%% (3) pearl_earring.jpg  %%%%%%%%%%
image = imread('pearl_earring.jpg');
image = imresize(image, 0.66);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_pearl_earing_corners.png');
hold off

% get the feature descriptors via SIFT
[ pearl_earring_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% (4) Prague.jpg %%%%%%%%%%%%
image = imread('prague.jpg');
image = imresize(image, 0.75);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_prague_corners.png');
hold off

% get the feature descriptors via SIFT
[ prague_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% (5) Provence.jpg %%%%%%%%%%%%
image = imread('Provence.jpg');
image = imresize(image, 0.5);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_provence_corners.png');
hold off

% get the feature descriptors via SIFT
[ provence_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% (6) circuit_board.jpg %%%%%%%%%%%%%
image = imread('circuit_board.JPG');
image = imresize(image, 0.7);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_circuit_corners.png');
hold off

% get the feature descriptors via SIFT
[ circuit_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% (7) vermeer.jpg %%%%%%%%%%%%%%%%
image = imread('vermeer.jpg');
image = imresize(image, 0.25);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_vermeer_corners.png');
hold off
% get the feature descriptors via SIFT
[ vermeer_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% (8) Mountains.jpg %%%%%%%%%%%%%%
image = imread('Mountains.jpg');
image = imresize(image, 0.70);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_mountains_corners.png');
hold off
% get the feature descriptors via SIFT
[ mountains_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%% (9) VAN_EYCK.jpg %%%%%%%%%%%%%%%%
image = imread('VAN_EYCK.jpg');
image = imresize(image, 0.50);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_van_eyck_corners.png');
hold off
% get the feature descriptors via SIFT
[ van_eyck_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%% (10) dali.jpg %%%%%%%%%%%%%%
image = imread('dali.jpg');
image = imresize(image, 0.66);
[ x, y, scores, Ix, Iy ] = extract_keypoints( image );
figure; imshow(image) 
hold on
for i = 1:size(scores,2)
    plot(x(i), y(i), 'ro', 'MarkerSize', scores(i) );
    
end
saveas(gcf,'hw04_dali_corners.png');
hold off

% get the feature descriptors via SIFT
[ dali_features, x, y, scores ] = compute_features( x, y, scores, Ix, Iy );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
