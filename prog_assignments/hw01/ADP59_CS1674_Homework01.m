%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% @author:  Anthony (Tony) Poerio (adp59@pitt.edu)
%
% CS1674 - Computer Vision
% Programming Assignment #1
% Fall 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (a) Numbers, Matrices and Functions

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) Generate a 1000000x1 (one million by one) vector of random numbers 
% from a Gaussian (normal) distribution with mean of 0 
% and standard deviation of 5. Use Matlab's randn function.

    %%% SOLUTION:: 
    %%% From the Matlab Help Docs (help randn), I know this;
    %%%  "Example 1: Generate values from a normal distribution with mean 1
    %%%   and standard deviation 2.
    %%%      r = 1 + 2.*randn(100,1);"
    %%%
    %%% Therefore, I'm just going to change this to be mean 0, stdev 5,
    %%% and 1000000 items like so:
    r = 0 + 5.*randn(1000000,1);
    %%% This is a Gaussian distro, so we can scale each item to change the
    %%% mean, and multiply each element (the .* operator) by our chosen
    %%% stdev, in order to change the standard deviation.
%%    
    




%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (2) Add 1 to every value in this list, by using a loop. 
% To determine how many times to loop, use Matlab's size function. 
% Time this operation and print the number in the code. 
% Write that number down.

% Timing code from documentation at: 
%     http://www.mathworks.com/help/matlab/ref/tic.html

size_of_list = size(r);

disp('----------Problem #2---------------')
disp(' >>> Uncomment test code to see line-by-line output')
tic
for n = 1:size_of_list
    %---------- BEGIN TEST -------------------
    %fprintf('Number was: %s\n', r(n))
    %fprintf('Number becomes: %s\n', r(n) +1)
    %----------- END TEST --------------------
    
    % add one to every value in the list
    r(n) = r(n) + 1;
end
disp('Time elapsed using a for-loop:\n\t')

% Method used to PRINT the number:  tic / toc and disp
toc

disp('---------END PROBLEM 2-------------')
%%





%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (3) Now add 1 to every value in the original random vector, 
% without using a loop. Time this operation, print the time, 
% and write it down. Use a different way to print the number
% than the method you used above.
% (See ways to print numbers at the beginning of the Matlab 
% tutorial script.) Write down the number.
disp('----------Problem #3---------------')
% ---- TEST NUMBERS BEFORE ---
r(1)
r(999)
%--------- END TEST ----------

% found timing method from (help timeit)
r1=r+1;

% PRINT with timeit function / fprintf
time_elapsed = timeit(f)
fprintf('Time elapsed since function start: %ul', time_elapsed)


% --- TEST NUMBERS AFTER ----
r1(1)
r1(999)
%--------- END TEST ----------
disp('---------END PROBLEM 3-------------')
%%




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (4) Copy this in your code: A = rand(5, 3);
% Then create a single command that ensures the sum in each row is (approximately) 1,
% without hard-coding any numbers except to denote along which matrix dimension (rows or columns) 
% that you're operating within. In other words, 
% I should be able to run your code on another 2-dimensional matrix,
% of a different size which you don't know, and it should still work. 
% Hint: Use repmat.
A = rand(5, 3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Q4 FINAL SOLUTION %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% run this function to check your output
fn_q4 = @(M)  M ./ repmat(sum(M, 2), 1, size(M,2))
% run this function to confirm everything is scaled and adds to 1
check_q4 = @(M) sum(fn_q4(M)')

% now doing it with A
fn_q4(A)
check_q4(A)
%%



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (5) How many changes do you need to make to your code in the task right above 
% to ensure that the sum in each column is 1?
%
A = rand(5, 3);

% run this function to check your output
fn_q5 = @(M)  M ./ repmat( sum(M, 1), size(M,1), 1) 
% run this function to confirm everything is scaled and adds to 1
check_q5 = @(M) sum(fn_q5(M))

% now doing it with A
fn_q5(A)
check_q5(A)

%%% ANSWER:  We need to sum on the 1st dimenson (columns) and then repmat
%%% the column sums, instead of the row sums, so we can divide by them.
%%




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (6) Create two matrices which when added together result in a matrix
% containing all numbers from 1 to 100. Each matrix should only be created with a single command.

% create our first to matrices, each with a single command
a = 0:99;
b = ones(100, 1)

% ADD them, and make a matrix with values 1 .. 100. 
c = b + a'


%%




%%
%%%%%%%%%%%%%%%%%%
% (7) Plot the exponential function 2^x, for even values of x smaller than 100.
%

% Just to show that this does work, because the larger version gets 
% truncated, because the numbers are so long
x = [0:2:8];
y = repmat(2, size(x), 1);
z = y .^ x
plot(z);

% And here's the full version, for all x values smaller than 100
x = [0:2:99];
y = repmat(2, size(x), 1);
z1 = y .^ x
plot(z1)

%% 



%%

%%
%%%%%%%%%%%%%%%%%%
% (8) Create a function that returns the n-th number in the Fibonacci sequence.
%  SEE FILE NAMED: fib_n.m for the fibonacci function
%

% generate some example fibonacci numbers
fib10 = fib_n(10)  % should be 55
fib11 = fib_n(11)  % should be 89
fib12 = fib_n(12)  % should be 144
fib13 = fib_n(13)  % should be 233

% run a quick test to see if all of our examples are correct
if fib10==55 && fib11==89 && fib12==144 && fib13==233 
    disp('=) FIB NUMBERS PASS TESTING')
else
    disp('xxx FIB NUMBERS FAIL TESTING xxx')
end

%%




% (b) Images

%%%%%%%%%%%%%%%%%%
% (9) Read in Pittsburgh.png image into Matlab as a matrix, and write down its dimensions.
%

I = imread('pittsburgh.png');
size(I)
fprintf('Dimensions of pittsburgh.png are: %u x %u x %u\n',size(I,1), size(I,2), size(I,3))

%%


%%

%%%%%%%%%%%%%%%%%%
% (10) Convert the image into grayscale.
% From documentation at: http://www.mathworks.com/help/matlab/ref/rgb2gray.html
GRAY = rgb2gray(I);

% Uncomment to display gray scale image
%figure
%imshow(GRAY)

%%




%%
%%%%%%%%%%%%%%%%%%
% (11) Find the darkest pixel in the image, and write its value and [row, column]
% in your answer sheet. Hint: Convert to a vector first,
% and use Matlab's ind2sub function. Use Matlab's help to find out how
% to use that function.

% for darkest pixel, we want to use the Gray-Scale matrix
% Convert it to a vector, as suggested
V = GRAY(:);

% Each cell now has a value between 0 and 255
% and the darkest pixel will be the lowest numbered value,
% so let's find the min of V. Assuming that 0 is darkest, 255 is brightest
min_cell = min(V);

% Next, according to the Matlab documentation for ind2sub, we can find
% cells in a matrix with ind2sub like so:  
% [I,J] = in2sub(size(A), find(A>5))
% Let's apply that to our situation here 
[row, col] = ind2sub(size(GRAY), find(V == min_cell));

disp('----- ANSWER FOR Q11 -----')
fprintf('The DARKEST PIXEL in the gray scale version of pittsburgh.png is at\n\t row: %u x col: %u. Its value is: %u\n', row, col, min_cell) 
disp('----- END Q11 -----')

%%


%%

%%%%%%%%%%%%%%%%%%
% (12) Use the function sum and a logical operator measuring equality to a scalar, 
% to determine and write down how many pixels in the grayscale image equal 
% the value 6

% first, get a vector for gray
gray_vector = GRAY(:);
num_px_eq_6 = sum(6 == gray_vector);
disp('----- ANSWER FOR Q12 ----')
fprintf('\nThere are %u pixels == 6 in the grayscale image\n\n', num_px_eq_6)
disp('----- END Q12 ----')

%%

%%%%%%%%%%%%%%%%%%
% (13) Consider a 31x31 square (a square with side equal to 31 pixels)
% that is centered on the darkest pixel. Replace all pixels in that square 
% with white pixels (pixels with value 255). Do this with loops.

% Okay, so darkest pixel is at: [row, col]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% BOUNDING BOX SOLUTIONFOR #13 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw the box, replacing ALL PIXELS in a 31x31 square
for y = 1:size(GRAY,1)
    for x = 1:size(GRAY,2)
        % only check if we're in the desired area
        if ( y >= row-floor(31/2)  && ...
             y <= row+ceil(31/2)  && ... 
             x >= col-floor(31/2)  && ...
             x <= col+ceil(31/2)      )
        
            % find all pixels within a 31x31 square of the target pixel
            % color edge pixels for x
            if ( x == col-floor(31/2) || ...
                 x == col+ceil(31/2)  )    
                GRAY(y,x) = 255;
            end
            
            % color edge pixels for y
            if ( y == row+floor(31/2) || ...
                 y == row-floor(31/2) )
                GRAY(y,x) = 255;
            end
        end
    end
end
imshow(GRAY)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%reset (if needed)
%GRAY = GRAY_DUP;


%%




%%
%%%%%%%%%%%%%%%%%%
% (14) Now use the code you wrote above to find one of several pixels with 
% value 6. Find which of those pixels are at least 15 pixels away from the 
% border of the image in any direction (not including the 6-valued pixel itself).
% You can use loops. Let's call these 15-away 6-valued pixels inds (you don't have 
% to call them this in your code).

% I'm performing this calculation on our GRAY scale image matrix, GRAY
count = 0;
for y = 1:size(GRAY,1)
    for x = 1:size(GRAY, 2)
        if ( (x > 15 && y > 15) && ...  % x and y are 15px away from top border
             ( (x < size(GRAY,2)-15) && (y < size(GRAY,1)-15) )  && ...  % x and y are 15 away from bottom border
             GRAY(y,x) == 6 )  % and the value at the current location == 6 
         
             % then increase our count of inds
             count = count + 1;
        end
    end
end

disp('------- Q14 ANSWER -----')
fprintf('\nNumber of 15-away 6-valued pixels inds = %u\n\n', count)
disp('----- END Q14 -----')

%%


%%
%%%%%%%%%%%%%%%%%%
% (15) Write code to randomly choose one of the inds pixels.
%

% Okay, so I'm storing the number of inds pixels in 'count'
% I'll randomly generate a number between 1 and 'count', then stop the for-
% loop when I get there.

% generate a random integer using method from the documentation at: 
%     http://www.mathworks.com/help/matlab/math/random-integers.html
rng(0, 'twister');
r = randi([1, count], 1, 1);
rand_num = r(1,1)

disp('------- Q15 ANSWER -----')
% then go through the loops again and find the x,y of our random pixel
count = 0;
for y = 1:size(GRAY,1)
    for x = 1:size(GRAY, 2)
        if ( (x > 15 || y > 15) && GRAY(y,x) == 6);
            count = count + 1;
            if count == rand_num
                fprintf('RANDOM IND PIXEL IS: y=%u, x=%u\n', y, x)
                rand_y = y
                rand_x = x
                break
            end
        end
    end
end
disp('----- END Q15 -----')

%%



%%
%%%%%%%%%%%%%%%%%%
% (16) Now consider another 31x31 square, but this time gray (e.g. with pixel values 150). 
% Take the image with the white square in it. Replace the randomly chosen pixel from above,
% and the 31x31 square in the image that's centered on this pixel, with the gray square. 
% This time you are NOT allowed to use loops. Note that you shouldn't run into border issues 
% because of the 15-away code you wrote above.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% SOLUTION FOR Q16 %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find the start of each line we need to draw, and fill the borders along
% that square up to 31 px


% also need to fix the issue that it's not 31x31 easily,
% need to draw 15 along one direction and 16 along the other,
% --> use floor and ceil for this, like we did before

%%% X-DIRECTION LINES
% draw TOP of box
% index into to top-left and draw 31px across (along x)
GRAY(rand_y-floor(31/2), rand_x-floor(31/2):rand_x+ceil(31/2)) = 150;
% draw BOTTOM of box
% index into bottom-left and draw 31px across (along x)
GRAY(rand_y+floor(31/2), rand_x-floor(31/2):rand_x+ceil(31/2)) = 150; 
%%%%

%%% Y-DIRECTION LINES
% draw LEFT side of box
% index into top-left and draw 31px down (along y)
GRAY(rand_y-floor(31/2):rand_y+ceil(31/2), rand_x-floor(31/2)) = 150;
% draw RIGHT side of box
% index into top-right and draw 31px down (along y)
GRAY(rand_y-floor(31/2):rand_y+ceil(31/2), rand_x+floor(31/2)) = 150;
%%%%%

imshow(GRAY)

%reset (if necessary)
%GRAY = GRAY_DUP;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%


%%
%%%%%%%%%%%%%%%%%%
% (17) Make a new figure, display the modified image (which includes both
% a white square and gray square), and save it to a file using saveas(gcf, 'new_image.png').

% create figure
figure

% show the new figure to check it
imshow(GRAY)

% save the new figure, as specified
saveas(gcf, 'new_image.png')


% NOTE:: My version of the new PNG looks like it loses one edge of each
% square bounding box... BUT, if you look at the same picture in imshow(..)
% the squares are perfectly clear...



%%

% (c) LOOPS!!! 

%%
%%%%%%%%%%%%%%%%%%
% (18) Create a script that prints all the values between 1 and 100,
% in random order, with pauses of 1 second between each two prints.

% We can use randperm for this, with documenation via (help randperm)
P = randperm(100);

for index = 1:100
    fprintf('Number #%u = %u\n', index, P(index))
    % pause on multiples of 2
    if mod(index,2) == 0
        pause(2)
        % and print a newline
        disp(' ')
    end
end


%%





%%
%%%%%%%%%%%%%%%%%%
% (19) Generate two random matrices A and B, and compute their product by hand, 
% using loops. Check your code by comparing the loop-computed product with 
% the product that you get from Matlab's A*B.

% create our random matrics
A = rand(10,10);
B = rand(10,10);

% do the calculation via Matlab's internal matrix multiplication function
C = A * B;

% allocate a new 10x10 matrix to store the results of our own
% multiplication, done by 'hand' using for-loops
D = zeros(10,10);

% mutliply the matrix out, row by col, using for-loops
for x = 1:size(A,2)
    for y = 1:size(B,1)
        D(y,x) = sum( A(x,:) .* B(:,y)');
    end
end
% need to transpose the matrix at the end of this, so that it has the same
% orientaction as C.
D = D'

% now, we can confirm that C == D by comparing them visually
disp(C)
disp(D)

% test for equality via isequal(C,D) returns false, because they aren't 
% exactly equal....
% Though not explicitly asked for, we can see that we are very close,
% within 0.1 in each cell using this code, adpated from: 
% https://www.mathworks.com/matlabcentral/answers/9021-approximately-equal-or-egual-to-error
index = find(abs(C - D) >= 0.001)
% ^ This yields an empty matrix, meaning ALL CELLS are at least equal within a
% margin of error of 0.001

%%


%%
%%%%%%%%%%%%%%%%%%
% (20) Implement a function my_unique that returns the number of unique rows in a matrix, 
% and returns another matrix with any duplicate rows removed. 
% You cannot just call Matlab's unique.
disp('------------ PROBLEM #20 --------------')

% function to test is my_unique, found in my_unique.m 
X = rand(6,5);
Y = ones(5,5);
Y(2,1) = 3;
Y(3,2) = 4;
[Z1_uniqs, Z1] = my_unique(X)
[Z2_uniqs, Z2] = my_unique(Y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% PROBLEM #20 TESTS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check that X has 6 unique values after being processed by my_unique
if isequal(size(X,1), Z1_uniqs)
    disp('@my_unique CORRECTLY processed randomly generated matrix with @my_unique')
else
    disp('@my_unique breaks when passed a randomly generated matrix')
end

% check with a specially made matrix, which I want to have 3 uniques only,
% out of 5 possible rows. There should only be **ONE** row of all 1's.
if isequal(size(Z2,1), 3)
    disp('@my_unique CORRECTLY processed my custom matrix, identified duplicate rows and removed them')
else
    disp('@my_unique is NOT correctly processing custom matrix and removing duplicate rows')
end

disp('---------- END PROBLEM #20 ------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%


%%
%%%%%%%%%%%%%%%%%%
% (21) Create another script which reads in an image. 
% It computes the scalar average pixel value along each channel (R, G, B) separately.
% It then subtracts the average value per channel from the corresponding channel. 
% Finally, it writes the image to a file mean_sub.png.


% SEE:  script in "mean_sub.m"


%%
