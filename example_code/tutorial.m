%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Introduction to Matlab 
%
% Originally by:
% Stefan Roth <roth (AT) cs DOT brown DOT edu>, 09/08/2003
% Patrick Doran <pdoran (AT) cs DOT brown DOT edu>, 01/30/2010
% 
% Additions/modifications by:
% Adriana Kovashka <kovashka (AT) cs DOT pitt DOT edu>, 07/29/2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (1) Basics

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (a) Commands

% Matlab is an interpreted language. Hence, you can use it as a calculator
% (I sometimes do!)

3 + 5

% Matlab's command line is a little like a standard shell:
% - Use the up arrow to recall commands without retyping them (and 
%   down arrow to go forward in the command history).  
% - C-a moves to beginning of line (C-e for end)
% - C-k deletes the rest of the line to the right of the cursor
% - Tab tries to complete a command.

% The symbol "%" is used to indicate a comment (for the remainder of
% the line).

% When writing a long Matlab statement that becomes too long for a
% single line use "..." at the end of the line to continue on the next
% line.  E.g.

A = [1, 2; ...
     3, 4];
 
% (We'll see what this statement does shortly.)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (b) Printing

% A semicolon at the end of a statement means that Matlab will not
% display the result of the evaluated statement. 
% For example, this won't display A:

A;

% If the ";" is omitted then Matlab will display the result.  This is also 
% useful for printing the value of variables, e.g.

A

% Other ways to print A include:

disp(A); 

% (note that this doesn't show the name of A again) or 

fprintf('%u %u\n', A);

% (note you have to request as many %u as the number of columns in the
% matrix).

% Printing other things:

s = 'friend';
fprintf('Hello %s\n', s);
m = 5;
fprintf('See you in %u minutes\n', m);
fprintf('See you in %s minutes\n', num2str(m));

% To get the type of a variable, which can be helpful when debugging:

class(A)

% or to see if it's Inf, NaN, etc.

isinf(m)
isnan(m)

% Also see: 'isa', 'isfloat', 'isnumeric', 'ischar', etc.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) Functions and scripts

% Matlab scripts are files with ".m" extension containing Matlab 
% commands. This file is a script.
% Variables in a script file are global and will change the
% value of variables of the same name in the environment of the current
% Matlab session.  A script with name "script1.m" can be invoked by
% typing "script1" in the command window.

% What can I do if I want to just debug a block of lines in my script, 
% so I don't have to retype those lines or up-arrow?

% Functions are also m-files. The first line in a function file must be
% of this form: 

% function [outarg_1, ..., outarg_m] = myfunction(inarg_1, ..., inarg_n)
%
% The function name should be the same as that of the file 
% (i.e. function "myfunction" should be saved in file "myfunction.m"). 
% Have a look at myfunction.m and myotherfunction.m for examples.
%
%
%

% Functions are executed using local workspaces: there is no risk of
% conflicts with the variables in the main workspace. At the end of a
% function execution only the output arguments will be visible in the
% main workspace.
 
a = [1 2 3 4];               % Global variable a
b = myfunction(2 * a)        % Call myfunction which has local variable a

a                            % Global variable a is unchanged

[c, d] = ...
  myotherfunction(a, b)      % Call myotherfunction with two return values

% You can log your dommands in a diary file if you want to, but you can't
% run a diary file, you can just open it with a text editor. 

diary mydiary

a = 3
b = 5
a * b

diary off 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (d) Saving and closing your work

save myfile                  % Saves all workspace variables into
                             %   file myfile.mat
save myfile a b              % Saves only variables a and b

clear a b                    % Removes variables a and b from workspace
clear                        % Clears the entire workspace

load myfile                  % Loads variable(s) from myfile.mat

clear all                    % Delete all variables (use caution!)

close all                    % Close all your figures (variables kept)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (e) Reserved/special words: 

% (from http://www.math.udel.edu/~braun/M349/Matlab_probs2.pdf)
% for, end, if, while, function, return, elseif, case, otherwise, switch, 
% continue, else, try, catch, global, persistent, break, ans, beep, pi, 
% eps, inf, NaN, nan, i, j, nargin, nargout, realmin, realmax, bitmax, 
% varargin, vararout

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (f) Simple debugging:

% If the command "dbstop if error" is issued before running a script
% or a function that causes a run-time error, the execution will stop
% at the point where the error occurred. Very useful for tracking down
% errors.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (g) Documentation

% Matlab has excellent documentation. To find out what a function does,
% e.g. 'log', try: 

help log

% or if you don't know the function name but want to find a function that
% performs a certain action, try: 

lookfor logarithm 

% You can also type 'matlab log' into Google or Bing. And you get something
% with this URL format: 
% http://www.mathworks.com/help/matlab/ref/log.html
% which is nicely explained with examples!

% If you don't know how to use a function, just Google its name!
% Whenever you want to find a function that does something, try searching
% for 'matlab <desired functionality>' but don't use anything that's 
% user-contributed and not official Matlab code. 
% User-contributed content is not as well documented and further, it might
% be implementing functionality that I'm asking YOU to implement. Hence,
% using user-contributed content might be cheating!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (h) Paths

% To add a path to some directory whose functions/scripts you're calling:

addpath 'C:/Users/kovashka/My Documents'


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (2) Basic types in Matlab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (a) The basic types in Matlab are scalars (usually double-precision
% floating point), vectors, and matrices:

A = [1 2; 3 4]               % Creates a 2x2 matrix
B = [1,2; 3,4]               % The simplest way to create a matrix is
                             % to list its entries in square brackets.
                             % The ";" symbol separates rows;
                             % the (optional) "," separates columns.

N = 5                        % A scalar
v = [1 0 0]                  % A row vector
v = [1; 2; 3]                % A column vector
v = v'                       % Transpose a vector (row to column or 
                             %   column to row)
v = 1:.5:3                   % A vector filled in a specified range: 

v = pi*[-4:4]/4              %   [start:stepsize:end]
                             %   (brackets are optional)
v = []                       % Empty vector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (b) Creating special matrices: 1ST parameter is ROWS, 2ND parameter is COLS 

m = zeros(2, 3)              % Creates a 2x3 matrix of zeros
v = ones(1, 3)               % Creates a 1x3 matrix (row vector) of ones
m = eye(3)                   % Identity matrix (3x3)
v = rand(3, 1)               % Randomly filled 3x1 matrix (column 
                             % vector); see also randn

                             % But watch out:
m = zeros(3)                 % Creates a 3x3 matrix (!) of zeros

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) Indexing vectors and matrices.
% Warning: Indices always start at 1 and *NOT* at 0!

v = [1 2 3];
v(3)                         % Access a vector element 
length(v)                    % Number of scalars in vector. Compare to:
size(v)                      % Returns the size of a matrix


m = [1 2 3 4; 5 7 8 8; 9 10 11 12; 13 14 15 16]
m(1, 3)                      % Access a matrix element
                             %       matrix(ROW #, COLUMN #)
m(2, :)                      % Access a whole matrix row (2nd row)
m(:, 1)                      % Access a whole matrix column (1st column)

m(1, 1:3)                    % Access elements 1 through 3 of the 1st row
m(1, 1:3) = rand(3, 1)       % Replace those elements?
m(1, 1:3) = rand(1, 3)       % Better
mrow = m(1, 1:3)             % Replace? 
mrow = rand(1, 3)
m(1, 1:3)                    % Matlab just copies numbers, doesn't create references to them

m(2:3, 2)                    % Access elements 2 through 3 of the 
                             %   2nd column
m(2:end, 3)                  % Keyword "end" accesses the remainder of a
                             %   column or row
                             
m(5)                         % Matlab uses column-major order. 
                             % What does this return? 
m(10)                        % What about this? 
                             % (To review, try these at home.)
                             
m(:)                         % What does this do? 
                             % (Hint: It reformats the matrix into something else.)
                             
C = rand(4, 3, 2)            % A three-dimensional array
D = rand(2, 1, 3)            % A three-dimensional array... but annoying
d = squeeze(D)               % Singleton dimension removed

m = [1 2 3; 4 5 6]     
size(m)                      % Returns the size of a matrix
size(m, 1)                   % Number of rows
size(m, 2)                   % Number of columns

m1 = zeros(size(m))          % Create a new matrix with the size of m

who                          % List variables in workspace

whos                         % List variables w/ info about size, type, etc.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (d) Cell arrays and structures
% (from Milos Hauskrecht)

% Creates a cell array 
A = {[1 4 3; 0 5 8; 7 2 9], 'Anne Smith'; 3+7i, -pi:pi/4:pi}
A(1)                            % Return cell
A{1}                            % Return double
A{1}(1,1)                       % Return first element of first cell
[a b c d]=deal(A{:})            % Get and print individual cells

% Creates a struct
B = struct('temp',72,'rainfall',0.0)
B.temp                          % Return value for given field

C = repmat(B, 1, 3)             % Creates struct matrix 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (3) Simple operations on vectors and matrices

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (a) Element-wise operations:

% These operations are done "element by element".  If two 
% vectors/matrices are to be added, subtracted, or element-wise
% multiplied or divided, they must have the same size.

a = [1 2 3 4]                % A row vector
2 * a                        % Scalar multiplication
a + 5                        % Scalar addition
5 + a
a / 4                        % Scalar division
4 / a                        % Division? 

b = [5 6 7 8]                % Another row vector

a + b                        % Vector addition
a + b'                       % What does this return? 
a - b                        % Vector subtraction
a .^ 2                       % Element-wise squaring (note the ".")
a .* b                       % Element-wise multiplication (note the ".")
a ./ b                       % Element-wise division (note the ".")

log(a)                       % Element-wise logarithm
power(a, 3)                  % Element-wise cubing
round([1.5 2; 2.2 3.1])      % Element-wise rounding to nearest integer

% ... and plenty more intuitive examples like this.
% Other element-wise arithmetic operations include e.g. :
%   floor, ceil, ...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (b) Vector Operations

% Built-in Matlab functions that operate on vectors

a = [1 4 6 3]                % A row vector
sum(a)                       % Sum of vector elements
mean(a)                      % Mean of vector elements
var(a)                       % Variance of elements
std(a)                       % Standard deviation
max(a)                       % Maximum
min(a)                       % Minimum
[vals, inds] = sort(a)       % Sorting

% If a matrix is given, then these functions will operate on each column
%   of the matrix and return a row vector as result
a = [1 2 3; 4 5 6]           % A matrix
mean(a)                      % Mean of each column
mean(a, 2)                   % Mean of each row (second argument specifies
                             %   dimension along which operation is taken)
                             
max(a)                       % Max of each column    
max(max(a))                  % Obtaining the max of a matrix 
                             % In what other way can I obtain this result?
                                                  
% Inner and outer products

[1 2 3] * [4 5 6]'           % 1x3 row vector times a 3x1 column vector
                             %   results in a scalar.  Known as dot product
                             %   or inner product.  Note the absence of "."
                             %   before '*'

[1 2 3]' * [4 5 6]           % 3x1 column vector times a 1x3 row vector 
                             %   results in a 3x3 matrix.  Known as outer
                             %   product.  Note the absence of "." before
                             %   '*'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) Matrix Operations:

a = rand(3,2)                % A 3x2 matrix of random numbers
b = rand(2,4)                % A 2x4 matrix of random numbers
c = a * b                    % Matrix product results in a 3x4 matrix

a = [1 2; 3 4; 5 6]          % A 3x2 matrix
b = [5 6 7]                  % A 1x3 row vector
b * a                        % Vector-matrix product results in
                             %   a 1x2 row vector
c = [8; 9]                   % A 2x1 column vector
a * c                        % Matrix-vector product results in
                             %   a 3x1 column vector

a = [1 3 2; 6 5 4; 7 8 9]    % A 3x3 matrix
inv(a)                       % Matrix inverse of a
eig(a)                       % Vector of eigenvalues of a

% Commutativity 
b = rand(3, 3)
r1 = a * b                   % Matrix product 
r2 = b * a                   % Does this result equal the previous line? 
                             % How to check for equality? 
        
all(r1 == r2)                % ... not quite. Why? 

all(all(r1 == r2))           % ok
all(r1(:) == r2(:))          % ok

% Distributivity
c = rand(2, 3)
r1 = c * (a + b)
r2 = c * a + c * b           % Are r1 and r2 equal? 

% Associativity
r1 = (c * a) * b
r2 = c * (a * b)

% See more: https://en.wikipedia.org/wiki/Matrix_multiplication

% Other issues and logical operations

all(r1(:) == r2(:))          % Hm!

diff = r1(:) - r2(:)         
diff > 1e-12                 % Why is this happening? 

format long                  % To see more digits 
r1                           
format short                 % To go back to before

indicator = (diff == 0)      % Return 0/1 depending on whether something is true
class(indicator)
~indicator
indicator | ~indicator       % Element-wise or
indicator & ~indicator       % Element-wise and

true || false                % For regular and/or use double bar/ampersand
true && false

find(indicator)              % Return indicies where true
                             % What if I don't want to define a new
                             % variable 'indicator'? 

% Other matrix operations: \, eig, svd, det, norm, rank, ...

% Help me create a system of linear equations...
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
% Ax = b
A = rand(5, 3)
x = rand(3, 1)
b = A * x
x_solved = A \ b
x - x_solved

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (d) Reshaping and assembling matrices:

a = [1 2; 3 4; 5 6]          % A 3x2 matrix
b = a(:)                     % Make 6x1 column vector by stacking 
                             %   up columns of a
sum(a(:))                    % Useful:  sum of all elements

a = reshape(b, 2, 3)         % Make 2x3 matrix out of vector 
                             %   elements (column-wise)

a = [1 2]                    % Two row vectors
b = [3 4]
c = [a b]                    % Horizontal concatenation (see horzcat)

a = [1; 2; 3];               % Column vector

c = [a; 4]                   % Vertical concatenation (see vertcat)

a = [eye(3) rand(3)]         % Concatenation for matrices
b = [eye(3); ones(1, 3)]

b = repmat(5, 3, 2)          % Create a 3x2 matrix of fives
b = repmat([1 2; 3 4], 1, 2) % Replicate the 2x2 matrix twice in
                             %   column direction; makes 2x4 matrix
b = diag([1 2 3])            % Create 3x3 diagonal matrix with given
                             %   diagonal elements



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (4) Control statements & vectorization

% Syntax of control flow statements:

% for VARIABLE = EXPR
%     STATEMENT
%      ...
%     STATEMENT
% end 
%
%   EXPR is a vector here, e.g. 1:10 or -1:0.5:1 or [1 4 7]

% while EXPRESSION
%     STATEMENTS
% end
% 
% if EXPRESSION
%     STATEMENTS 
% elseif EXPRESSION
%     STATEMENTS
% else
%     STATEMENTS
% end 
%
%   (elseif and else clauses are optional, the "end" is required)
%
%   EXPRESSIONs are usually made of relational clauses, e.g. a < b

%   The operators are <, >, <=, >=, ==, ~=  (almost like in C(++))

% Warning, IMPORTANT:
%   Loops run very slowly in Matlab, because of interpretation overhead.
%   This has gotten somewhat better in version 6.5, but you should
%   nevertheless try to avoid them by "vectorizing" the computation, 
%   i.e. by rewriting the code in form of matrix operations.  This is
%   illustrated in some examples below.

% Examples:
for i=1:2:7                  % Loop from 1 to 7 in steps of 2
  i                          % Print i
end

for i=[5 13 -1]              % Loop over given vector
  if (i > 10)                % Sample if statement
    disp('Larger than 10')   % Print given string
  elseif i < 0               % Parentheses are optional
    disp('Negative value') 
  else
    disp('Something else')
  end

end

% Here is another example: given an mxn matrix A and a 1xn 
% vector v, we want to subtract v from every row of A.

m = 50; n = 10; A = ones(m, n); v = 2 * rand(1, n); 
%
% Implementation using loops:
for i=1:m
  A(i,:) = A(i,:) - v;

end

% We can compute the same thing using only matrix operations. How? 
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%

A = ones(m, n) - repmat(v, m, 1);   % This version of the code runs 
                                    %   much faster!!!

% We can vectorize the computation even when loops contain
%   conditional statements.
%
% Example: given an mxn matrix A, create a matrix B of the same size
%   containing all zeros, and then copy into B the elements of A that
%   are greater than zero.

% Implementation using loops:
B = zeros(m,n);
for i=1:m
  for j=1:n
    if A(i,j)>0
      B(i,j) = A(i,j);
    end

  end
end

% All this can be computed w/o any loop! How? 
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%

B = zeros(m,n);
ind = find(A > 0)            % Find indices of positive elements of A 
                             %   (see "help find" for more info)
                             
A(ind)                       % Ok... So I can get the values of A that I am
                             % interested in.
                             % But how to find where in B to store these? 

B(ind) = A(ind);             % Copies into B only the elements of A
                             %   that are > 0

% How to do inner product in a slow way? 
% (from Milos Hauskrecht)

row_vector=[1 2 3 4]
column_vector=[4 5 6 7]' %' is the transposition
size(row_vector)
size(column_vector)

% inner product
scalar_multiplication=row_vector*column_vector
scalar_multiplication
     
% ugly inner product
ugly_slow_scalar_multiplication=0 
for i=1:length(column_vector)
   ugly_slow_scalar_multiplication=ugly_slow_scalar_multiplication+   row_vector(i)*column_vector(i);
end
ugly_slow_scalar_multiplication



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (5) Plotting (useful later)

x = [0 1 2 3 4];             % Basic plotting
plot(x);                     % Plot x versus its index values
pause                        % Wait for key press
plot(x, 2*x);                % Plot 2*x versus x
axis([0 8 0 8]);             % Adjust visible rectangle

figure;                      % Open new figure
x = pi*[-24:24]/24;
plot(x, sin(x));
xlabel('radians');           % Assign label for x-axis
ylabel('sin value');         % Assign label for y-axis
title('dummy');              % Assign plot title

figure;                      
subplot(1, 2, 1);            % Multiple functions in separate graphs
plot(x, sin(x));             %   (see "help subplot")
axis square;                 % Make visible area square
subplot(1, 2, 2);
plot(x, 2*cos(x));
axis square;

figure;                      
plot(x, sin(x));
hold on;                     % Multiple functions in single graph           
plot(x, 2*cos(x), '--');     % '--' chooses different line pattern

legend('sin', 'cos');        % Assigns names to each plot
hold off;                    % Stop putting multiple figures in current
                             %   graph

figure;                      % Matrices vs. images

m = rand(64,64);
imagesc(m)                   % Plot matrix as image
colormap gray;               % Choose gray level colormap
axis image;                  % Show pixel coordinates as axes
axis off;                    % Remove axes



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (6) Working with images

I = imread('pittsburgh.png'); % Read a PNG image
figure                        % Create new figure canvas
imshow(I)                     % Display the image

I2 = imresize(I, 0.25, 'bil'); % Resize to 50% using bilinear interpolation
figure; imshow(I2)

I3 = imrotate(I2, 45, ...     % Rotate 45 degrees and crop to
              'bil', 'crop'); %   original size
figure; imshow(I3)

% Watch out for data type!
I2 = double(I2);              % Convert from uint8 to double, to allow
                              %   math operations
I3 = 0.5 * I2;                % Halve each pixel value
figure; imshow(I3);           % Nothing shows up (or rather all white shows up)
figure; imagesc(I3);          % Same with imagesc
I3 = uint8(I3);
figure; imshow(I3);           % Ok, and image appears darker; why? 
figure; imagesc(I3);          % Same with imagesc, just at different size since imagesc scales the image
imwrite(I3, 'test.png')       % Save image as PNG

% Watch out for range
I4 = I2 / max(I2(:));         % Convert image to values between 0 and 1
figure; imshow(I4);           % Ok
figure; imagesc(I4);          % Ok
I5 = uint8(I4);    
unique(I5(:))
figure; imshow(I5);           % All dark! Why? 
figure; imagesc(I5);          % Same with imagesc also

% imshow vs imagesc
I7 = [200 200 200; 100 100 100];
iptsetpref('ImshowInitialMagnification','fit');     % Matrix is tiny, so set display to magnify
% iptsetpref('ImshowInitialMagnification',100);     % Display at 100%, as by default
figure; imshow(I7)            % All white!
I8 = uint8(I7);
figure; imshow(I8)            % Fixed with converting to uint8!
figure; imagesc(I7)           % imagesc works directly, also note it displays in color
                              % imagesc scales color to the full colormap range!
figure; imagesc(I8)           % No difference for imagesc if we convert in this case
figure; colormap gray; imagesc(I8)           % Display in grayscale

% Another case of imshow vs imagesc
I9 = rgb2gray(I);
class(I9)                     % uint8
figure; imshow(I9)            % Both functions behave the same with uint8
figure; imagesc(I9)
I10 = double(I9);
figure; imshow(I10)
figure; imagesc(I10)          % In grayscale, imagesc can display double ok

% Summary: Watch out for (1) data type, (2) range of pixel values, (3)
% image display function choice (imshow vs imagesc) -- usually fine to just
% use one, if you remember to convert image to the right type. If one
% function doesn't work or shows all black/white, try another function,
% check your data types, etc. 

% Display images side by side
subplot(2, 2, 1)              % Create a 2x2 subplot and write in first cell
imagesc(I);                   
subplot(2, 2, 2)              % Write in second cell (row-major!)
imagesc(I2);                   
subplot(2, 2, 3)              % Write in third cell
imagesc(I3);                   
subplot(2, 2, 4)              % Write in fourth cell
imagesc(I4);                   

% Random images
v = rand(100, 500);
figure; imagesc(v)
v_sorted = sort(v(:));
v_sorted_reshaped = reshape(v_sorted, size(v));
figure; imagesc(v_sorted_reshaped)

% Plot a histogram of the pixel values of the image
im = imread('pittsburgh.png');
im_gray = rgb2gray(im);
figure; imshow(im_gray)
p = imhist(im_gray);
figure; plot(p)
 
% Blurring with a Gaussian kernel
h = fspecial('gaussian', 50, 45);
filtered_im = imfilter(im_gray, h);
figure; imshow(filtered_im)

% Show the detail lost in the blurring
detail_im = im_gray - filtered_im;
figure; imshow(detail_im);

% Add noise to the image
noise = randn(size(im_gray)) .* 0.1;
output = im2double(im_gray) + noise;
figure; imshow(output)

% Convolve with a filter -- what kind? 
fil = [-1 0 1; -1 0 1; -1 0 1]; 
im_fil = conv2(im2double(im_gray), fil);
figure; imshow(im_fil)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
